import Data.Vect

readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = pure []
readVectLen (S k) = do x <- getLine
                       xs <- readVectLen k
                       pure (x :: xs)

data VectUnknown : Type -> Type where
     MkVect : (len : Nat) -> Vect len a -> VectUnknown a

readVect : IO (VectUnknown String)
readVect = do x <- getLine
              if (x == "")
                 then pure (MkVect _ [])
                 else do MkVect _ xs <- readVect
                         pure (MkVect _ (x :: xs))

printVect : Show a => VectUnknown a -> IO ()
printVect (MkVect len xs) = putStrLn (show xs ++ " (length " ++ show len ++ ")")

anyVect : (n : Nat ** Vect n String)
anyVect = (3 ** ["foo", "bar", "baz"])

readVect2 : IO (len ** Vect len String)
readVect2 = do x <- getLine
               if (x == "")
                  then pure (_ ** [])
                  else do (_ ** xs) <- readVect2
                          pure (_ ** x :: xs)

zipInputs : IO ()
zipInputs = do putStrLn "Enter1: "
               (len1 ** vec1) <- readVect2
               putStrLn "Enter2: "
               (len2 ** vec2) <- readVect2
               case exactLength len1 vec2 of
                    Nothing => putStrLn "Vectors are different lengths"
                    Just vec2' => printLn (zip vec1 vec2')
