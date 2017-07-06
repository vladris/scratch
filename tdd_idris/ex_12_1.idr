import Control.Monad.State

update : (stateType -> stateType) -> State stateType ()
update f = do current <- get
              put (f current)

increase : Nat -> State Nat ()
increase x = update (+x)

data Tree a = Empty
            | Node (Tree a) a (Tree a)

testTree : Tree String
testTree = Node (Node (Node Empty "Jim" Empty) "Fred"
                      (Node Empty "Sheila" Empty)) "Alice"
                (Node Empty "Bob" (Node Empty "Eve" Empty))

countEmpty : Tree a -> State Nat ()
countEmpty Empty = do current <- get
                      put (S current)
countEmpty (Node left _ right) = do countEmpty left
                                    countEmpty right

countEmptyNode : Tree a -> State (Nat, Nat) ()
countEmptyNode Empty = do (empty, node) <- get
                          put (S empty, node)
countEmptyNode (Node left _ right) = do countEmptyNode left
                                        (empty, node) <- get
                                        put (empty, S node)
                                        countEmptyNode right
