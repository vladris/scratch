module Main

palindrome : String -> Bool
palindrome str = (toLower str) == toLower (reverse str)

main : IO ()
main = repl "\nEnter a string: " (show . palindrome)
