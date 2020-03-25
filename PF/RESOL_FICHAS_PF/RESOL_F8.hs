import Data.List

data Frac = F Integer Integer

normaliza :: Frac -> Frac
normaliza (F x y) = undefined


mdc :: Integer -> Integer -> Integer
mdc x y | x == y = y
        | x>y = mdc x (y-x)
        | x<y = mdc (x+y) y

