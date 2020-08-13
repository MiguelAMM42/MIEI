--1


data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt



--expressão de exemplo = Mais  (Simetrico (Const 1)) (Menos (Const 2) (Const 3))

--1a

calcula :: ExpInt -> Int
calcula  (Const i) = i
calcula (Simetrico e) = -(calcula e)
calcula (Mais e1 e2) = calcula e1 + calcula e2
calcula (Menos e1 e2) = calcula e1 - calcula e2
calcula (Mult e1 e2) = calcula e1 * calcula e2       



--BTree e RTree-------------------------------------------


data BTree a = Empty | Node a (BTree a) (BTree a)
   deriving Show


somaBTree :: Num a => BTree a -> a
somaBTree Empty = 0
somaBTree (Node x l r) = x + somaBTree l + somaBTree r

----------------------------------------------------------


--1b

infixa :: ExpInt -> String
infixa  (Const i) = show i
infixa (Simetrico e) = "(" ++ "-" ++ infixa e ++ ")"
infixa (Mais e1 e2) = "(" ++ (infixa e1) ++ "+" ++ (infixa e2) ++ ")"
infixa (Menos e1 e2) = "(" ++ (infixa e1) ++ "-" ++ (infixa e2) ++ ")"
infixa (Mult e1 e2) = "(" ++ (infixa e1) ++ "*" ++ (infixa e2) ++ ")"    


--1c


posfixa :: ExpInt -> String
posfixa  (Const i) = show i
posfixa (Simetrico e) = posfixa e ++ " " ++ "-" 
posfixa (Mais e1 e2) = posfixa e1 ++ " " ++ posfixa e2 ++ " " ++ "+" 
posfixa (Menos e1 e2) = posfixa e1 ++ " " ++ posfixa e2 ++ " " ++ "-"
posfixa (Mult e1 e2) =  posfixa e1 ++ " " ++ posfixa e2 ++ " " ++ "*"


--2

--ex. Rose Tree : R 1 [R 5 [R 6 []]]



data RTree a = R a [RTree a]
 deriving Show

--2a

soma :: Num a => RTree a -> a
soma (R x l) = x + sum (map soma l)

--2b

altura :: RTree a -> Int
altura (R x []) = 1
altura (R x l) = 1 + maximum(map altura l)


--2c

prune :: Int -> RTree a -> RTree a
prune 1 (R x _) = (R x [])
prune y (R x xs) = (R x (map (prune (y-1)) xs))   

--2d(VER MELHOR:DÚVIDAS)

mirror :: RTree a -> RTree a
mirror (R x []) = R x []
mirror (R x l) = (R x (map mirror l))

--2e(VER MELHOR:DÚVIDAS)

postorder :: RTree a -> [a]
postorder (R x []) = [x]
postorder (R x l) = (concat(map postorder l)) ++ [x]

--3

data LTree a = Tip a | Fork (LTree a) (LTree a)

--ex.Leaf Tree : Fork (Tip 3) (Fork (Tip 6) (Fork (Tip 9) (Tip 9)))

--3a

ltSum :: Num a => LTree a -> a
ltSum (Tip x) = x
ltSum (Fork e d) = ltSum e + ltSum d

--3b

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork e d) = (listaLT e) ++ (listaLT d) 

--3c(VER MELHOR:DÚVIDAS)

ltHeight :: LTree a -> Int
ltHeight (Tip x) = 1
ltHeight (Fork e d) = 1+ (max (ltHeight e) (ltHeight d))


--4(VER MELHOR:DÚVIDAS)

data FTree a b = Leaf b | No a (FTree a b) (FTree a b)

--4a(VER MELHOR:DÚVIDAS)

--splitFTree :: FTree a b -> (BTree a, LTree b)
--splitFTree Leaf x = (Empty, Tip x)
--splitFTree No x (No y e d) (No y' e' d') = (Node x [] [], (Fork (Fork e d) (Fork e' d')) )

--4b(VER MELHOR:DÚVIDAS)

--joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
--joinTrees Empty (Tip x) = Just (Leaf x)
--joinTrees Empty (Fork e d) = No 

