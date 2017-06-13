palindrome : Nat -> String -> Bool
palindrome minLength str = ((length str) > minLength) && ((toLower str) == toLower (reverse str))
