module DataStore

import Data.Vect

infixr 5 .+.

public export
data Schema = SString | SInt | SChar | (.+.) Schema Schema

public export
SchemaType : Schema -> Type
SchemaType SString = String
SchemaType SInt = Int
SchemaType SChar = Char
SchemaType (x .+. y) = (SchemaType x, SchemaType y)

export
record DataStore (schema : Schema) where
    constructor MkData
    size : Nat
    items : Vect size (SchemaType schema)

export
empty : DataStore schema
empty = MkData 0 []

export
addToStore : (value : SchemaType schema) -> (store : DataStore schema) -> DataStore schema
addToStore value (MkData _ items) = MkData _ (value :: items)

public export
data StoreView : DataStore schema -> Type where
     SNil : StoreView empty
     SAdd : (rec : StoreView store) -> StoreView (addToStore value store)

storeViewHelp : (items : Vect size (SchemaType schema)) ->
                StoreView (MkData size items)
storeViewHelp [] = SNil
storeViewHelp (val :: xs) = SAdd (storeViewHelp xs)

export
storeView : (store : DataStore schema) -> StoreView store
storeView (MkData size items) = storeViewHelp items

{-
data Command : Schema -> Type where
    SetSchema : (newSchema : Schema) -> Command schema
    Add : SchemaType schema -> Command schema
    Get : Maybe Integer -> Command schema
    Quit : Command schema

parseSchema : List String -> Maybe Schema
parseSchema ("String" :: xs)
    = case xs of
           [] => Just SString
           _ => do xs_sch <- parseSchema xs
                   Just (SString .+. xs_sch)
parseSchema ("Int" :: xs)
    = case xs of
           [] => Just SInt
           _ => do xs_sch <- parseSchema xs
                   Just (SInt .+. xs_sch)
parseSchema ("Char" :: xs)
    = case xs of
           [] => Just SChar
           _ => do xs_sch <- parseSchema xs
                   Just (SChar .+. xs_sch)
parseSchema _ = Nothing

setSchema : (store : DataStore) -> Schema -> Maybe DataStore
setSchema store schema = case size store of
                              Z => Just (MkData schema _ [])
                              S k => Nothing

parsePrefix : (schema : Schema) -> String -> Maybe (SchemaType schema, String)
parsePrefix SString input = getQuoted (unpack input)
    where 
        getQuoted : List Char -> Maybe (String, String)
        getQuoted ('"' :: xs)
            = case span (/= '"') xs of
                   (quoted, '"' :: rest) => Just (pack quoted, ltrim (pack rest))
                   _ => Nothing
        getQuoted _ = Nothing

parsePrefix SInt input = case span isDigit input of
                             ("", rest) => Nothing
                             (num, rest) => Just (cast num, ltrim rest)
parsePrefix SChar input = getChar (unpack input)
    where
        getChar : List Char -> Maybe (Char, String)
        getChar (char :: rest) = Just (char, ltrim (pack rest))
        getChar _ = Nothing
parsePrefix (schemal .+. schemar) input = do (l_val, input') <- parsePrefix schemal input
                                             (r_val, input'') <- parsePrefix schemar input'
                                             Just ((l_val, r_val), input'')

parseBySchema : (schema : Schema) -> String -> Maybe (SchemaType schema)
parseBySchema schema input = case parsePrefix schema input of
                                  Just (res, "") => Just res
                                  Just _ => Nothing
                                  Nothing => Nothing

parseCommand : (schema : Schema) -> String -> String -> Maybe (Command schema)
parseCommand schema "add" rest = do restok <- parseBySchema schema rest
                                    Just (Add restok)
parseCommand schema "get" val = if val == "" then Just (Get Nothing) else case all isDigit (unpack val) of
                                                                               False => Nothing
                                                                               True => Just (Get (Just (cast val)))
parseCommand schema "quit" "" = Just Quit
parseCommand schema "schema" rest = do schemaok <- parseSchema (words rest)
                                       Just (SetSchema schemaok)
parseCommand _ _ _ = Nothing

parse : (schema : Schema) -> (input : String) -> Maybe (Command schema)
parse schema input = case span (/= ' ') input of
                          (cmd, args) => parseCommand schema cmd (ltrim args)

display : SchemaType schema -> String
display {schema = SString} item = show item
display {schema = SInt} item = show item
display {schema = SChar} item = show item
display {schema = (x .+. y)} (item1, item2) = display item1 ++ ", " ++ display item2

getEntry : (pos : Integer) -> (store : DataStore) -> Maybe (String, DataStore)
getEntry pos store = let store_items = items store in
                     case integerToFin pos (size store) of
                         Nothing => Just ("Out of range\n", store)
                         Just id => Just (display (index id (items store)) ++ "\n", store)

processInput : DataStore -> String -> Maybe (String, DataStore)
processInput store input
    = case parse (schema store) input of
           Nothing => Just ("Invalid command\n", store)
           Just (Add item) => Just ("ID " ++ show (size store) ++ "\n", addToStore store item)
           Just (Get Nothing) => Just (foldl (++) "" (map (\x => (display x) ++ "\n") (items store)), store)
           Just (Get (Just pos)) => getEntry pos store
           Just (SetSchema schema') =>
                case setSchema store schema' of
                     Nothing => Just ("Can't update schema\n", store)
                     Just store' => Just ("OK\n", store')
           Just Quit => Nothing

main : IO ()
main = replWith (MkData SString _ []) "Command: " processInput
-}
