import DataStore

getValues : DataStore (SString .+. val_schema) ->
            List (SchemaType val_schema)
getValues input with (storeView input)
  getValues _ | SNil = []
  getValues (addToStore (key, value) store) | (SAdd rec) = value :: getValues store | rec 

testStore : DataStore (SString .+. SInt)
testStore = addToStore ("First", 1) $
            addToStore ("Second", 2) $
            empty

