import Data.Vect

createEmpties : Vect n (Vect 0 elem)
createEmpties {n = Z} = []
createEmpties {n = (S k)} = [] :: createEmpties

transposeMat : Vect m (Vect n elem) -> Vect n (Vect m elem)
transposeMat [] = createEmpties
transposeMat (x :: xs) = let xsTrans = transposeMat xs in zipWith (::) x xsTrans

addMatrix : Num a => Vect n (Vect m a) -> Vect n (Vect m a) -> Vect n (Vect m a)
addMatrix [] [] = []
addMatrix (x::xs) (y::ys) = zipWith (+) x y :: addMatrix xs ys

mulMatrixHelper : Num a => Vect m a -> Vect p (Vect m a) -> Vect p a
mulMatrixHelper _ [] = []
mulMatrixHelper xs (y::ys) = foldl (+) 0 (zipWith (*) xs y) :: (mulMatrixHelper xs ys)

mulMatrix : Num a => Vect n (Vect m a) -> Vect m (Vect p a) -> Vect n (Vect p a)
mulMatrix [] _ = []
mulMatrix (x::xs) ys = mulMatrixHelper x (transposeMat ys) :: mulMatrix xs ys
