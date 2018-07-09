data Term =
    TmVar Int Int
    | TmAbs String Term
    | TmApp Term Term
    deriving (Eq, Show)

data Binding = NameBind

type Context = [(String, Binding)]

printTm :: Context -> Term -> String
printTm ctx (TmAbs x t1) = let (ctx', x') = pickFreshName ctx x in
    "(lambda " ++ x' ++ ". " ++ printTm ctx' t1 ++ ")" 
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
        walk c (TmAbs x t1) = TmAbs x (walk (c + 1) t1)
        walc c (TmApp t1 t2) = TmApp (walk c t1) (walk c t2)

termSubst :: Int -> Term -> Term -> Term
termSubst j s t = walk 0 t
    where
        walk c (TmVar x n) = if x == j + c then termShift c s else TmVar x n
        walk c (TmAbs x t1) = TmAbs x (walk (c + 1) t1)
        walk c (TmApp t1 t2) = TmApp (walk c t1) (walk c t2)

termSubstTop :: Term -> Term -> Term
termSubstTop s t = termShift (-1) (termSubst 0 (termShift 1 s) t)

-- Context not used in this implementation
eval1 :: Context -> Term -> Term
eval1 ctx (TmApp (TmAbs x t12) v2@(TmAbs _ _)) = termSubstTop v2 t12
eval1 ctx (TmApp v1@(TmAbs _ _) t2) = let t2' = eval1 ctx t2 in TmApp v1 t2'
eval1 ctx (TmApp t1 t2) = let t1' = eval1 ctx t1 in TmApp t1' t2
eval1 _ t = t

eval :: Context -> Term -> Term
eval ctx t = let t' = eval1 ctx t in
    if t' == t then t else eval ctx t'

main :: IO ()
main = 
    let ctx = [("x", NameBind)] in
    do
        putStrLn $ printTm ctx $ eval ctx (TmVar 0 1)
        putStrLn $ printTm ctx $ eval ctx (TmApp (TmAbs "x" (TmVar 0 2)) (TmAbs "y" (TmVar 0 2)))