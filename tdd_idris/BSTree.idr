data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)

insert : Ord elem => elem -> Tree elem -> Tree elem
insert x Empty = Node Empty x Empty
insert x orig@(Node left val right) = case compare x val of
    LT => Node (insert x left) val right
    EQ => orig
    RT => Node left val (insert x right)

listToTree : Ord elem => List elem -> Tree elem
listToTree xs = listToTreeHelper xs Empty
    where
        listToTreeHelper : Ord elem => List elem -> Tree elem -> Tree elem
        listToTreeHelper [] tree = tree
        listToTreeHelper (x::xs) tree = listToTreeHelper xs (insert x tree)

treeToList : Tree a -> List a
treeToList Empty = []
treeToList (Node left val right) = treeToList left ++ [val] ++ treeToList right
