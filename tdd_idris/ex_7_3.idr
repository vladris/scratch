data Vect : Nat -> Type -> Type where
     Nil  : Vect Z a
     (::) : (x : a) -> (xs : Vect k a) -> Vect (S k) a

Eq elem => Eq (Vect n elem) where
    (==) [] [] = True
    (==) (x :: xs) (y :: ys) = x == y && xs == ys

Foldable (Vect n) where
    foldr f acc [] = acc
    foldr f acc (x :: xs) = f x (foldr f acc xs)
