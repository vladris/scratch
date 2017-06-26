data InfIO : Type where
     Do : IO a
          -> (a -> Inf InfIO)
          -> InfIO

loopPrint : String -> InfIO
loopPrint msg = Do (putStrLn msg)
                   (\_ => loopPrint msg)

data Fuel = Dry | More Fuel

tank : Nat -> Fuel
tank Z = Dry
tank (S k) = More (tank k)

data Fuel' = Dry' | More' (Lazy Fuel')

forever : Fuel'
forever = More' forever

run : Fuel -> InfIO -> IO ()
run (More fuel) (Do action cont) = do res <- action
                                      run fuel (cont res)
run Dry _ = putStrLn "Out of fuel"

(>>=) : IO a -> (a -> Inf InfIO) -> InfIO
(>>=) = Do

loopPrint' : String -> InfIO
loopPrint' msg = do putStrLn msg
                    loopPrint' msg
