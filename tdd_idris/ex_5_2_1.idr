module Main

import System

readNumber : IO (Maybe Nat)
readNumber = do
    input <- getLine
    if all isDigit (unpack input)
        then pure (Just (cast input))
        else pure Nothing

guess : (target : Nat) -> (guesses : Nat) -> IO ()
guess target guesses = do putStr ((show guesses) ++ " Guess: ")
                          Just num <- readNumber
                             | Nothing => do putStrLn "Invalid input"
                                             guess target guesses

                          case compare num target of
                              GT => do putStrLn "Too high"
                                       guess target (S guesses)
                              LT => do putStrLn "Too low"
                                       guess target (S guesses)
                              EQ => do putStrLn "Correct!"
                                       pure ()

main : IO ()
main = do num <- time
          guess (fromIntegerNat (num `mod` 20)) 0
