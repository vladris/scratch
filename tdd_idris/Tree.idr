data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)

insert : Ord elem => elem -> Tree elem -> Tree elem
insert x Empty = Node Empty x Empty
insert x orig@(Node left val right) = case compare x val of
    LT => Node (insert x left) val right
    EQ => orig
    RT => Node left val (insert x right)

Eq elem => Eq (Tree elem) where
    (==) Empty Empty = True
    (==) (Node left e right) (Node left' e' right')
         = left == left' && e == e' && right == right'
    (==) _ _ = False

Functor Tree where
    map func Empty = Empty
    map func (Node left e right)
        = Node (map func left)
               (func e)
               (map func right)

Foldable Tree where
    foldr func acc Empty = acc
    foldr func acc (Node left e right)
        = let leftfold = foldr func acc left
              rightfold = foldr func leftfold right in
              func e rightfold
