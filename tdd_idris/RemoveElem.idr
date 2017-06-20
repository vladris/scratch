import Data.Vect

removeElem : (value : a) -> (xs : Vect (S n) a) -> 
             (prf : Elem value xs) -> Vect n a
removeElem value (value :: ys) Here = ys
removeElem {n = Z} value (y :: []) (There later) = absurd later
removeElem {n = (S k)} value (y :: ys) (There later) = y :: removeElem value ys later

removeElem' : (value : a) -> (xs : Vect (S n) a) -> 
              {auto prf : Elem value xs} -> Vect n a
removeElem' value (value :: ys) {prf = Here} = ys
removeElem' {n = Z} value (y :: []) {prf = There later} = absurd later
removeElem' {n = (S k)} value (y :: ys) {prf = There later} = y :: removeElem' value ys
