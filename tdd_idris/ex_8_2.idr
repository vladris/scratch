import Data.Vect

myPlusCommutes : (n : Nat) -> (m : Nat) -> n + m = m + n
myPlusCommutes Z m = sym (plusZeroRightNeutral m)
myPlusCommutes (S k) m = rewrite sym (plusSuccRightSucc m k) in cong (myPlusCommutes k m)

reverseProof_nil : Vect n1 a -> Vect (plus n1 0) a
reverseProof_nil {n1} prf = rewrite plusZeroRightNeutral n1 in prf

reverseProof_xs : Vect (S (plus n1 len)) a -> Vect (plus n1 (S len)) a
reverseProof_xs {n1} {len} prf = rewrite sym (plusSuccRightSucc n1 len) in prf

myReverse : Vect n a -> Vect n a
myReverse xs = reverse' [] xs
    where reverse' : Vect n a -> Vect m a -> Vect (n + m) a
          reverse' acc [] = reverseProof_nil acc
          reverse' acc (x :: xs) = reverseProof_xs (reverse' (x :: acc) xs)
