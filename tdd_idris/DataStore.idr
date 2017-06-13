module Main

import Data.Vect

data DataStore : Type where
     MkData : (size : Nat) ->
              (items : Vect size String) ->
              DataStore

size : DataStore -> Nat
size (MkData size' items') = size'

items : (store : DataStore) -> Vect (size store) String
items (MkData size' items') = items'

addToStore : DataStore -> String -> DataStore
addToStore (MkData size items) newitem = MkData _ (addToData items)
    where
        addToData : Vect old String -> Vect (S old) String
        addToData [] = [newitem]
        addToData (x :: xs) = x :: addToData xs

data Command = Add String
             | Get Integer
             | Size
             | Search String
             | Quit

parseCommand : (cmd : String) -> (args : String) -> Maybe Command
parseCommand "add" str = Just (Add str)
parseCommand "get" val = case all isDigit (unpack val) of
                              False => Nothing
                              True => Just (Get (cast val))
parseCommand "size" val = Just Size
parseCommand "search" str = Just (Search str)
parseCommand "quit" "" = Just Quit
parseCommand _ _ = Nothing


parse : (input : String) -> Maybe Command
parse input = case span (/= ' ') input of
                   (cmd, args) => parseCommand cmd (ltrim args)


getEntry : (pos : Integer) -> (store : DataStore) -> Maybe (String, DataStore)
getEntry pos store = let store_items = items store in
                     case integerToFin pos (size store) of
                         Nothing => Just ("Out of range\n", store)
                         Just id => Just (index id store_items ++ "\n", store)


searchStore : (input : String) -> (store : DataStore) -> String
searchStore input store = searchStoreHelper input (items store) Z
    where
        searchStoreHelper : String -> Vect n String -> Nat -> String
        searchStoreHelper _ [] _ = ""
        searchStoreHelper input (x::xs) n = (if Strings.isInfixOf input x then (show n) ++ ":" ++ x ++ "\n" else "") ++ searchStoreHelper input xs (S n)


processInput : DataStore -> String -> Maybe (String, DataStore)
processInput store inp
    = case parse inp of
           Nothing => Just ("Invalid command\n", store)
           Just (Add item) => Just ("ID " ++ show (size store) ++ "\n", addToStore store item)
           Just (Get pos) => getEntry pos store
           Just Size => Just ("Store size " ++ show (size store) ++ "\n", store)
           Just (Search str) => Just (searchStore str store, store)
           Just Quit => Nothing

main : IO ()
main = replWith (MkData _ []) "Command: " processInput
