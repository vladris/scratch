data Last : List a -> a -> Type where
     LastOne : Last [value] value
     LastCons : (prf : Last xs value) -> Last (x :: xs) value

notInNil : Last [] value -> Void
notInNil LastOne impossible
notInNil (LastCons _) impossible

lastNotFound : (contra: (x = value) -> Void) -> (Last [x] value -> Void)
lastNotFound contra LastOne = contra Refl

notFound : (contra : Last xs value -> Void) -> (Last (x :: xs) value -> Void)
notFound contra (LastCons prf) = contra prf 

isLast : DecEq a => (xs : List a) -> (value : a) -> Dec (Last xs value)
isLast [] a = No notInNil
isLast [x] a = case decEq x a of
                    Yes Refl => Yes LastOne
                    No notLast => No (lastNotFound notLast)
isLast (x :: xs) a = case isLast xs a of
                          Yes prf => Yes (LastCons prf)
                          No notLast => No (notFound notLast)
