import Data.List.Views
import Data.Nat.Views
import Data.Vect
import Data.Vect.Views

equalSuffix : Eq a => List a -> List a -> List a
equalSuffix input1 input2 with (snocList input1)
  equalSuffix [] input2 | Empty = []
  equalSuffix (xs ++ [x]) input2 | (Snoc xsrec) with (snocList input2)
    equalSuffix (xs ++ [x]) [] | (Snoc xsrec) | Empty = []
    equalSuffix (xs ++ [x]) (ys ++ [y]) | (Snoc xsrec) | (Snoc ysrec)
                = if x == y then (equalSuffix xs ys | xsrec | ysrec) ++ [x] else []

mergeSort : Ord a => Vect n a -> Vect n a
mergeSort input with (splitRec input)
  mergeSort [] | SplitRecNil = []
  mergeSort [x] | SplitRecOne = [x]
  mergeSort (lefts ++ rights) | (SplitRecPair lrec rrec)
            = merge (mergeSort lefts | lrec) (mergeSort rights | rrec)

toBinary : Nat -> String
toBinary n with (halfRec n)
  toBinary Z | HalfRecZ = ""
  toBinary (n + n) | (HalfRecEven rec) = toBinary n | rec ++ "0"
  toBinary (S (n + n)) | (HalfRecOdd rec) = toBinary n | rec ++ "1"

palindrome : Eq a => List a -> Bool
palindrome input with (vList input)
  palindrome _ | VNil = True
  palindrome _ | VOne = True
  palindrome (x :: xs ++ [y]) | (VCons rec) = if x == y then palindrome xs | rec else False

