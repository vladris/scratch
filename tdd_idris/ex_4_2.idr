import Data.Fin
import Data.Vect

vectTake : (m : Fin (S n)) -> Vect n elem -> Vect (finToNat m) elem
vectTake FZ _ = []
vectTake (FS m) (x::xs) = x :: vectTake m xs

sumEntries : Num a => (pos : Integer) -> Vect n a -> Vect n a -> Maybe a
sumEntries {n} pos xs ys = case integerToFin pos n of
                                Nothing => Nothing
                                Just idx => Just ((Data.Vect.index idx xs) + (Data.Vect.index idx ys))
