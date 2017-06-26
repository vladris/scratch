import Data.Primitives.Views

-- 1
every_other : Stream a -> Stream a
every_other (_ :: x :: xs) = x :: every_other xs

-- 2
data InfList : Type -> Type where
     (::) : (value : elem) -> Inf (InfList elem) -> InfList elem

countFrom : Integer -> InfList Integer
countFrom x = x :: countFrom (x + 1)

getPrefix : Nat -> InfList a -> List a
getPrefix Z x = []
getPrefix (S k) (x :: xs) = x :: getPrefix k xs

map : (a -> a) -> InfList a -> InfList a
map f (x :: xs) = f x :: map f xs

-- 3
data Face = Head | Tail

randoms : Int -> Stream Int
randoms seed = let seed' = 1664525 * seed + 1013904223 in
                   (seed' `shiftR` 2) :: randoms seed'

coinFlips : (count : Nat) -> Stream Int -> List Face
coinFlips Z _ = []
coinFlips (S k) (x :: xs) = (if bound x == 0 then Head else Tail) :: coinFlips k xs
    where
        bound : Int -> Int
        bound num with (divides num 2)
            bound ((2 * div) + rem) | (DivBy prf) = rem

-- 4
square_root_approx : (number : Double) -> (approx : Double) -> Stream Double
square_root_approx number approx = approx :: square_root_approx number ((approx + (number / approx)) / 2)

-- 5
square_root_bound : (max : Nat) -> (number : Double) -> (bound : Double) ->
                    (approxs : Stream Double) -> Double
square_root_bound Z _ _ (x :: xs) = x
square_root_bound (S k) number bound (x :: xs) =
    if abs (x * x - number) < bound
       then x
       else square_root_bound k number bound xs

square_root : (number : Double) -> Double
square_root number = square_root_bound 100 number 0.00000000001 (square_root_approx number number)
