--4

nzp :: [Int]-> (Int,Int,Int)
nzp l = (countneg l,countzeros l,countpos l)


countneg :: [Int] -> Int
countneg [] = 0
countneg (x:xs) | x<0 = 1 + countneg xs
                | otherwise = countneg xs



countzeros :: [Int] -> Int
countzeros [] = 0
countzeros (x:xs) | x==0 = 1 + countzeros xs
                  | otherwise = countzeros xs

countpos :: [Int] -> Int
countpos [] = 0
countpos (x:xs) | x>0 = 1 + countpos xs
                | otherwise = countpos xs
