insert ::  Ord a => a -> [a] ->[a]
insert n (x:xs) | (n==x) || (n<x) = (n:x:xs)
                | otherwise	 = insert n xs                