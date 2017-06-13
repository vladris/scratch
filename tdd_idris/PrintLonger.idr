printLonger : IO ()
printLonger = do putStr "First string: "
                 str1 <- getLine
                 putStr "Second string: "
                 str2 <- getLine
                 putStrLn (show (max (length str1) (length str2)))

printLonger2 : IO ()
printLonger2 = putStr "First string: " >>= \_ =>
               getLine >>= \str1 =>
               putStr "Second string: " >>= \_ =>
               getLine >>= \str2 =>
               putStrLn (show (max (length str1) (length str2)))

