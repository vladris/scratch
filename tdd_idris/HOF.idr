twice : (a -> a) -> a -> a
twice f x = f (f x)

-- Shape : Type
-- rotate : Shape -> Shape

add : Num a => a -> a -> a
add x y = x + y

double : Num a => a -> a
double x = x + x

quadruple : Num a => a -> a
quadruple = twice double

--urn_around : Shape -> Shape
--urn_around = twice rotate
