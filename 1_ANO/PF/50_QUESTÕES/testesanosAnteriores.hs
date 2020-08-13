type MSet a = [(a,Int)]

cardMSet :: MSet a -> Int
cardMSet [] = 0
cardMSet ((b,n) : t) = n + cardMSet t