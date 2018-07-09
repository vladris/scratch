data Term =
    TmTrue -- True
  | TmFalse -- False
  | TmIf Term Term Term -- if <term> then <term> else <term>
  | TmZero -- 0
  | TmSucc Term -- succ <term>
  | TmPred Term -- pred <term>
  | TmIsZero Term -- isZero <term>
  deriving (Eq, Show)

isNumericVal :: Term -> Bool
isNumericVal TmZero = True -- 0 is a numerical value
isNumericVal (TmSucc t1) = isNumericVal t1 -- succ of numerical value is a numerical value
isNumericVal _ = False

isVal :: Term -> Bool
isVal TmTrue = True -- True is a value
isVal TmFalse = True -- False is a value
isVal t = isNumericVal t -- A numerical value is a value 

eval1 :: Term -> Term
-- if True then t2 else t3 => t2
eval1 (TmIf TmTrue t2 t3) = t2
-- if False then t2 else t3 => t3
eval1 (TmIf TmFalse t2 t3) = t3
-- t1 -> t1', if t1 then t2 else t3 => if t1' then t2 else t3
eval1 (TmIf t1 t2 t3) = let t1' = eval1 t1 in TmIf t1' t2 t3
-- t1 -> t1', succ t1 => succ t1'
eval1 (TmSucc t1) = let t1' = eval1 t1 in TmSucc t1'
-- pred 0 => 0
eval1 (TmPred TmZero) = TmZero
-- pred succ nv, nv numericval => nv
eval1 (TmPred (TmSucc nv1))
    | isNumericVal nv1 = nv1
--- t1 -> t1', pred t1 => pred t1'
eval1 (TmPred t1) = let t1' = eval1 t1 in TmPred t1'
-- isZero 0 => True
eval1 (TmIsZero TmZero) = TmTrue
-- isZero succ nv => False
eval1 (TmIsZero (TmSucc nv1))
    | isNumericVal nv1 = TmFalse
-- t1 -> t1', isZero t1 => isZero t1'
eval1 (TmIsZero t1) = let t1' = eval1 t1 in TmIsZero t1'
eval1 term = term

eval :: Term -> Term
eval t = let t' = eval1 t in 
    if t' == t then t else eval t'

main :: IO ()
main = do
    putStrLn $ show $ eval (TmIf (TmIsZero TmZero) (TmSucc TmZero) TmZero)
    putStrLn $ show $ eval (TmIf TmZero (TmSucc TmZero) TmZero)