data Type =
    TyVar Int Int
    | TyArr Type Type
    | TyAll String Type
    | TySome String Type
    deriving (Eq, Show)

data Binding = NameBind | VarBind Type | TyVarBind

type Context = [(String, Binding)]

addBinding :: Context -> String -> Binding -> Context
addBinding ctx s b = (s, b):ctx

getTypeFromContext :: Context -> Int -> Type
getTypeFromContext ctx i =
    case ctx !! i of
        (_, VarBind ty) -> ty
        _ -> error "Wrong kind of binding for variable"

{-
typeShiftAbove :: Int -> Int -> Type -> Type
typeShiftAbove d c tyT = walk c tyT
    where
        walk c (TyVar x n) = if x >= c then TyVar (x + d) (n + d) else TyVar x (n + d)
        walk c (TyArr tyT1 tyT2) = TyArr (walk c tyT1) (walk c tyT2)
        walk c (TyAll tyX tyT2) = TyAll tyX (walk (c + 1) tyT2)
        walk c (TySome tyX tyT2) = TySome tyX (walk (c + 1) tyT2)

Type-specific shift-above function can be generalized
-}

tyMap :: (Int -> Int -> Int -> Type) -> Int -> Type -> Type
tyMap onVar c tyT = walk c tyT
    where
        walk c (TyArr tyT1 tyT2) = TyArr (walk c tyT1) (walk c tyT2)
        walk c (TyVar x n) = onVar c x n
        walk c (TyAll tyX tyT2) = TyAll tyX (walk (c + 1) tyT2)
        walk c (TySome tyX tyT2) = TySome tyX (walk (c + 1) tyT2)

typeShiftAbove :: Int -> Int -> Type -> Type
typeShiftAbove d c tyT = tyMap
    (\c x n -> if x >= c then 
                   if x + d < 0 then error "Scoping error"
                   else TyVar (x + d) (n + d)
               else
                   TyVar x (n + d))
    c tyT

typeShift :: Int -> Type -> Type
typeShift d tyT = typeShiftAbove d 0 tyT

typeSubst :: Type -> Int -> Type -> Type
typeSubst tyS j tyT = tyMap
    (\c x n -> if x == j then (typeShift j tyS) else TyVar x n) j tyT

typeSubstTop :: Type -> Type -> Type
typeSubstTop tyS tyT = typeShift (-1) (typeSubst (typeShift 1 tyS) 0 tyT)

data Term =
    TmVar Int Int
    | TmAbs String Type Term
    | TmApp Term Term
    | TmTAbs String Term
    | TmTApp Term Type
    | TmPack Type Term Type
    | TmUnpack String String Term Term
    deriving (Eq, Show)

tmMap :: (Int -> Int -> Int -> Term) -> (Int -> Type -> Type) -> Int -> Term -> Term
tmMap onVar onType c t = walk c t
    where
        walk c (TmVar x n) = onVar c x n
        walk c (TmAbs x tyT1 t2) = TmAbs x (onType c tyT1) (walk (c + 1) t2)
        walk c (TmApp t1 t2) = TmApp (walk c t1) (walk c t2)
        walk c (TmTAbs tyX t2) = TmTAbs tyX (walk (c + 1) t2)
        walk c (TmTApp t1 tyT2) = TmTApp (walk c t1) (onType c tyT2)
        walk c (TmPack tyT1 t2 tyT3) = TmPack (onType c tyT1) (walk c t2) (onType c tyT3)
        walk c (TmUnpack tyX x t1 t2) = TmUnpack tyX x (walk c t1) (walk (c + 2) t2)

termShiftAbove :: Int -> Int -> Term -> Term
termShiftAbove d c t = tmMap
    (\c x n -> if x >= c then TmVar (x + d) (n + d) else TmVar x (n + d))
    (typeShiftAbove d) c t

termShift :: Int -> Term -> Term
termShift d t = termShiftAbove d 0 t

termSubst :: Int -> Term -> Term  -> Term
termSubst j s t = tmMap
    (\j x n -> if x == j then termShift j s else TmVar x n)
    (\j tyT -> tyT) j t

tytermSubst :: Type -> Int -> Term -> Term
tytermSubst tyS j t = tmMap
    (\c x n -> TmVar x n)
    (\j tyT -> typeSubst tyS j tyT) j t

termSubstTop :: Term -> Term -> Term
termSubstTop s t = termShift (-1) (termSubst 0 (termShift 1 s) t)

tytermSubstTop :: Type -> Term -> Term
tytermSubstTop tyS t = termShift (-1) (tytermSubst (typeShift 1 tyS) 0 t)

isVal :: Context -> Term -> Bool
isVal _ _ = True -- not implemeneted, should return True if term is a value

eval1 :: Context -> Term -> Term
eval1 ctx (TmApp (TmAbs x _ t12) v2@(TmAbs _ _ _)) = termSubstTop v2 t12
eval1 ctx (TmApp v1@(TmAbs _ _ _) t2) = let t2' = eval1 ctx t2 in TmApp v1 t2'
eval1 ctx (TmApp t1 t2) = let t1' = eval1 ctx t1 in TmApp t1' t2
eval1 ctx (TmTApp (TmTAbs x t11) tyT2) = tytermSubstTop tyT2 t11
eval1 ctx (TmTApp t1 tyT2) = let t1' = eval1 ctx t1 in TmTApp t1' tyT2
eval1 ctx (TmUnpack tyX x (TmPack tyT11 v12 tyS) t2) =
    if isVal ctx v12 then
        tytermSubstTop tyT11 (termSubstTop (termShift 1 v12) t2)
    else
        let t1' = eval1 ctx (TmPack tyT11 v12 tyS) in TmUnpack tyX x t1' t2
eval1 ctx (TmUnpack tyX x t1 t2) = let t1' = eval1 ctx t1 in TmUnpack tyX x t1' t2
eval1 ctx (TmPack tyT1 t2 tyT3) = let t2' = eval1 ctx t2 in TmPack tyT1 t2' tyT3
eval1 _ t = t

eval :: Context -> Term -> Term
eval ctx t = let t' = eval1 ctx t in
    if t' == t then t else eval ctx t'

typeOf :: Context -> Term -> Type
typeOf ctx t =
    case t of
        TmVar i _ -> getTypeFromContext ctx i
        TmAbs x tyT1 t2 ->
            let ctx' = addBinding ctx x (VarBind tyT1) in
            let tyT2 = typeOf ctx' t2 in
                TyArr tyT1 tyT2
        TmApp t1 t2 ->
            let tyT1 = typeOf ctx t1 in
            let tyT2 = typeOf ctx t2 in
                case tyT1 of
                    TyArr tyT11 tyT12 -> if tyT2 == tyT11 then 
                                            tyT12
                                         else
                                            error "Parameter type mismatch"
                    _ -> error "Arrow type expected"
        TmTAbs tyX t2 ->
            let ctx = addBinding ctx tyX TyVarBind in
            let tyT2 = typeOf ctx t2 in
                TyAll tyX tyT2
        TmTApp t1 tyT2 ->
            let tyT1 = typeOf ctx t1 in
                case tyT1 of
                    TyAll _ tyT12 -> typeSubstTop tyT2 tyT12
                    _ -> error "Universal type expected"
        TmPack tyT1 t2 tyT ->
            case tyT of
                TySome tyY tyT2 ->
                    let tyU = typeOf ctx t2 in
                    let tyU' = typeSubstTop tyT1 tyT2 in
                        if (==) tyU tyU' then tyT else error "Doesn't match declared type"
                _ -> error "Existential type expected"
        TmUnpack tyX x t1 t2 ->
            let tyT1 = typeOf ctx t1 in
                case tyT1 of
                    TySome tyY tyT11 ->
                        let ctx' = addBinding ctx tyX TyVarBind in
                        let ctx'' = addBinding ctx' x (VarBind tyT11) in
                        let tyT2 = typeOf ctx'' t2 in
                        typeShift (-2) tyT2
                    _ -> error "Existential type expected"

main :: IO ()
main = do
    putStrLn ""