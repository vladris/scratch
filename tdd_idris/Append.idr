import Data.Vect

append : {elem : Type} -> {n : Nat} -> {m : Nat} -> Vect n elem -> Vect m elem -> Vect (n + m) elem
append xs ys = xs ++ ys
