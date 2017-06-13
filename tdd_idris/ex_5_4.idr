readToBlank : IO (List String)
readToBlank = do line <- getLine
                 if line == "" then pure []
                               else do lines <- readToBlank
                                       pure (line :: lines)

readAndSave : IO ()
readAndSave = do lines <- readToBlank
                 file <- getLine
                 Right h <- writeFile file (unlines lines)
                 | Left err => putStrLn (show err)
                 pure ()
