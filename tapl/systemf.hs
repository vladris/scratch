data Type =
    TyVar Int Int
    | TyArr Type Type
    | TyAll String Type
    | TySome String Type
    deriving (Eq, Show)

data Binding = NameBind | VarBind Type | TyVarBind

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
    (\c x n -> if x >= c then TyVar (x + d) (n + d) else TyVar x (n + d)) c tyT

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

main :: IO ()
main = do
    putStrLn ""