greet : InfIO
greed = do putStr "Enter your name: "
           name <- getLine
           putStrLn ("Hello " ++ name)
           greet
