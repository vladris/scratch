module Main

import System

myRepl : String -> (String -> String) -> IO()
myRepl prompt f = do putStr prompt
                     input <- getLine
                     putStrLn (f input)
                     myRepl prompt f

myReplWith : (state : a) -> (prompt : String) -> (onInput : a -> String -> Maybe (String, a)) -> IO ()
myReplWith state prompt onInput =
    do putStr prompt
       input <- getLine
       case onInput state input of
           Nothing => pure ()
           Just (o, s) => do putStrLn o
                             myReplWith s prompt onInput

testFunc : Nat -> String -> Maybe (String, Nat)
testFunc n "" = Nothing
testFunc n _ = Just (show (n + 1), n + 1)
