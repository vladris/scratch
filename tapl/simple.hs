data Type =
    TyArr Type Type
    | TyBool
    deriving (Eq, Show)

data Binding = NameBind | VarBind Type

type Context = [(String, Binding)]

addBinding :: Context -> String -> Binding -> Context
addBinding ctx s b = (s, b):ctx

getTypeFromContext :: Context -> Int -> Type
getTypeFromContext ctx i =
    case ctx !! i of
        (_, VarBind ty) -> ty
        _ -> error "Wrong kind of binding for variable"

data Term =
    TmVar Int Int
    | TmAbs String Type Term
    | TmApp Term Term
    | TmTrue
    | TmFalse
    | TmIf Term Term Term
    deriving (Eq, Show)

printTm :: Context -> Term -> String
printTm ctx (TmAbs x ty t1) = let (ctx', x') = pickFreshName ctx x in
    "(lambda " ++ x' ++ ":" ++ show ty ++ ". " ++ printTm ctx' t1 ++ ")" 
printTm ctx (TmApp t1 t2) =
    "(lambda " ++ (printTm ctx t1) ++ " " ++ (printTm ctx t2) ++ ")"
printTm ctx (TmVar x n) =
    if length ctx == n then
        fst (ctx !! x)
    else
        "[bad index]"

pickFreshName :: Context -> String -> (Context, String)
pickFreshName ctx t =
    if t `elem` (map fst ctx) then
        pickFreshName ctx (t ++ "'")
    else
        ((t, NameBind) : ctx, t)

termShift :: Int -> Term -> Term
termShift d t = walk 0 t
    where
        walk c (TmVar x n) = if x >= c then TmVar (x + d) (n + d) else TmVar x (n + d)
        walk c (TmAbs x ty t1) = TmAbs x ty (walk (c + 1) t1)
        walc c (TmApp t1 t2) = TmApp (walk c t1) (walk c t2)

termSubst :: Int -> Term -> Term -> Term
termSubst j s t = walk 0 t
    where
        walk c (TmVar x n) = if x == j + c then termShift c s else TmVar x n
        walk c (TmAbs x ty t1) = TmAbs x ty (walk (c + 1) t1)
        walk c (TmApp t1 t2) = TmApp (walk c t1) (walk c t2)

termSubstTop :: Term -> Term -> Term
termSubstTop s t = termShift (-1) (termSubst 0 (termShift 1 s) t)

-- Context not used in this implementation
eval1 :: Context -> Term -> Term
eval1 ctx (TmApp (TmAbs x _ t12) v2@(TmAbs _ _ _)) = termSubstTop v2 t12
eval1 ctx (TmApp v1@(TmAbs _ _ _) t2) = let t2' = eval1 ctx t2 in TmApp v1 t2'
eval1 ctx (TmApp t1 t2) = let t1' = eval1 ctx t1 in TmApp t1' t2
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
        TmTrue -> TyBool
        TmFalse -> TyBool
        TmIf t1 t2 t3 ->
            if typeOf ctx t1 == TyBool then
                let tyT2 = typeOf ctx t2 in
                    if tyT2 == typeOf ctx t3 then
                        tyT2
                    else
                        error "Arms of conditional have different types"
            else
                error "Guard of conditional not a boolean"

main :: IO ()
main = 
    let ctx = [("x", VarBind TyBool)] in
    do
        putStrLn $ show $ typeOf ctx (TmVar 0 1)
        putStrLn $ show $ typeOf ctx (TmIf (TmVar 0 1) TmTrue TmFalse)