palindrome : Nat -> String -> Bool
palindrome minLength str = ((length str) > minLength) && ((toLower str) == toLower (reverse str))

counts : String -> (Nat, Nat)
counts str = (length (words str), length str)

top_ten : Ord a => List a -> List a
top_ten lst = take 10 (reverse (sort lst))

over_length : Nat -> List String -> Nat
over_length n lst = length (filter (> n) (map length lst))
