

data BTree a = Empty | Node a (BTree a) (BTree a)
   deriving Show

--tree = Node 2(Node 3 Empty Empty) (Node 4(Node 5 Empty Empty) Empty)

--1a

altura :: BTree a -> Int
altura Empty = 0
altura (Node x l r) = 1 + max (altura l) (altura r)

--1b

contaNodos:: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node x l r) = 1 + contaNodos l + contaNodos r


procura:: Ord a => a -> BTree a -> Bool
procura x Empty = False
procura x (Node y l r) | x == y = True
                       | x > y = procura x r
                       | x < y = procura x l


--1c

folhas:: BTree a -> Int
folhas Empty = 0
folhas (Node x Empty r) = 1 
folhas (Node x l Empty) = 1
folhas (Node x l r) = 1 + folhas l + folhas r 



--1d

prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 1 (Node x l r) = Node x Empty Empty
prune a (Node x l r) = (Node x (prune (a-1) l) (prune (a-1) r))

--1e

path :: [Bool] -> BTree a -> [a]
path l Empty = []
path [] (Node x l r) = [x]
path (x:xs) (Node y l r) | x == True = [y] ++ (path xs r)
                         | x == False = [y] ++ (path xs l)
                         | otherwise = []


--1f 

mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node x l r) = Node x (mirror r) (mirror l)


--1g

zipWithBT :: (a->b->c) -> BTree a -> BTree b -> BTree c
zipWithBT f (Node x l1 r1) (Node y l2 r2) = Node (f x y) (zipWithBT f l1 l2) (zipWithBT f r1 r2) 
zipWithBT f _ _= Empty

--1h

unzipBT :: BTree (a,b,c) -> (BTree a,BTree b, BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (x,y,z) l r) = ( Node x la ra , Node y lb rb , Node z lc rc )  
     where
     (la,lb,lc) = unzipBT l
     (ra,rb,rc) = unzipBT r


--2a

minimo :: Ord a => BTree a -> a
minimo (Node x Empty r) = x
minimo (Node x l r) = minimo l


--2b

semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node x Empty r) = r
semMinimo (Node x l r) = Node x (semMinimo l) r  


--2c

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin a@(Node x Empty r)= (minimo a, semMinimo a)
minSmin b@(Node x l r) = (minimo b, semMinimo b) 


--2d

remove :: Ord a => a -> BTree a -> BTree a
remove a t@(Node x Empty Empty) | a==x = Empty
                                | otherwise = t 
remove a y@(Node x l r) | a == x = Node (minimo y) l r
                        | otherwise = Node x (semMinimo l) (semMinimo r)

--3

type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL  deriving Show
data Classificacao = Aprov Int
                   | Rep
                   | Faltou
   deriving Show
type Turma = BTree Aluno  --  árvore binária de procura (ordenada por número)



--3a

inscNum :: Numero -> Turma -> Bool
inscNum n Empty = False
inscNum n (Node (num, name, reg, clas) l r) | n == num = True
                                            | otherwise = inscNum n l || inscNum n r 


--3b

inscName :: Nome -> Turma -> Bool
inscName a Empty = False
inscName a (Node (num, name, reg, clas) l r) | a == name = True
                                             | otherwise = inscName a l || inscName a r

--3c






--3d

nota :: Numero -> Turma -> Maybe Classificacao 
nota n Empty = Nothing
nota n (Node (num, name, reg, clas) l r) | n == num = Just clas
                                         | otherwise = nota n l 
                                         | otherwise = nota n r

--3e

--percFaltas :: Turma -> Float
--percFaltas t@(Node a@(num, name, reg, clas) l r) | alunoFaltou a = 1 + 
                                         
   --where 
        --alunoFaltou :: Aluno -> Bool
        --alunoFaltou (num, name, reg, clas) | clas == Faltou = True
                                           --| otherwise = False

--3f



--3g

