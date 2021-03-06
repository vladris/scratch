import Data.Primitives.Views
import System

%default total

data Fuel = Dry | More (Lazy Fuel)

data Command : Type -> Type where
     PutStr : String -> Command ()
     GetLine : Command String

     Pure : ty -> Command ty
     Bind : Command a -> (a -> Command b) -> Command b

data ConsoleIO : Type -> Type where
     Quit : a -> ConsoleIO a
     Do : Command a -> (a -> Inf (ConsoleIO b)) -> ConsoleIO b

record Score where
     constructor MkScore
     correct : Nat
     questions : Nat

show : Score -> String
show (MkScore c qs) = show c ++ " / " ++ show qs

namespace CommandDo
    (>>=) : Command a -> (a -> Command b) -> Command b
    (>>=) = Bind

namespace ConsoleDo
    (>>=) : Command a -> (a -> Inf (ConsoleIO b)) -> ConsoleIO b
    (>>=) = Do

data Input = Answer Int | QuitCmd

readInput : (prompt : String) -> Command Input
readInput prompt = do PutStr prompt
                      answer <- GetLine
                      if toLower answer == "quit"
                         then Pure QuitCmd
                         else Pure (Answer (cast answer))

runCommand : Command a -> IO a
runCommand (PutStr x) = putStr x
runCommand GetLine = getLine
runCommand (Pure val) = pure val
runCommand (Bind c f) = do res <- runCommand c
                           runCommand (f res)

run : Fuel -> ConsoleIO a -> IO (Maybe a)
run fuel (Quit val) = do pure (Just val)
run (More fuel) (Do c f) = do res <- runCommand c
                              run fuel (f res)
run Dry p = pure Nothing

mutual
  correct : Stream Int -> (score : Score) -> ConsoleIO Score
  correct nums (MkScore c qs)
          = do PutStr "Correct!\n"
               quiz nums (MkScore (S c) (S qs))

  wrong : Stream Int -> Int -> (score : Score) -> ConsoleIO Score
  wrong nums ans (MkScore c qs)
        = do PutStr ("Wrong, the answer is " ++ show ans ++ "\n")
             quiz nums (MkScore c (S qs))

  quiz : Stream Int -> (score : Score) -> ConsoleIO Score
  quiz (num1 :: num2 :: nums) score
     = do PutStr ("Score so far: " ++ show score ++ "\n")
          input <- readInput (show num1 ++ " * " ++ show num2 ++ "? ")
          case input of
               Answer answer => if answer == num1 * num2
                                   then correct nums score
                                   else wrong nums (num1 * num2) score
               QuitCmd => Quit score

randoms : Int -> Stream Int
randoms seed = let seed' = 1664525 * seed + 1013904223 in
                   (seed' `shiftR` 2) :: randoms seed'

arithInputs : Int -> Stream Int
arithInputs seed = map bound (randoms seed)
  where
    bound : Int -> Int
    bound x with (divides x 12)
      bound ((12 * div) + rem) | (DivBy prf) = abs rem + 1

partial
forever : Fuel
forever = More forever

partial
main : IO ()
main = do seed <- time
          Just score <- run forever (quiz (arithInputs (fromInteger seed)) (MkScore Z Z))
              | Nothing => putStrLn "Ran out of fuel"
          putStrLn ("Final score: " ++ show score)
