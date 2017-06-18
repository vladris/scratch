data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double

Eq Shape where
   (==) (Triangle x y) (Triangle x' y') = x == x' && y == y'
   (==) (Rectangle x y) (Rectangle x' y') = x == x' && y == y'
   (==) (Circle x) (Circle x') = x == x'
   (==) _ _ = False

area : Shape -> Double
area (Triangle base height) = 0.5 * base * height
area (Rectangle length height) = length * height
area (Circle radius) = pi * radius * radius

Ord Shape where
    compare shapel shaper = compare (area shapel) (area shaper)

testShapes : List Shape
testShapes = [Circle 3, Triangle 3 9, Rectangle 2 6, Circle 4, Rectangle 2 7]
