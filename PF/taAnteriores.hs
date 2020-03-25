import Data.Char (isDigit,isAlpha)
import Data.Maybe (fromMaybe)
import Data.List (sort)
import System.Random

--16/17--teste

--1
--a

type MSet a = [(a,Int)]

cardMSet :: MSet a -> Int
cardMSet [] = 0
cardMSet ((x,n) : t) = n + cardMSet t

--b

moda :: MSet a -> [a]
moda [] = []
moda [(x,n)] = []
moda ((x,n) : (y,m) :  t)= x : y : moda t

--c

converteMSet :: MSet a -> [a]
converteMSet [] = []
converteMSet ((x,n) : t) = (replicate n x) ++ converteMSet t 

--d 

--addNcopies :: Eq a => MSet a -> a -> Int -> MSet a
--addNcopies [] x n = [(x,n)]
--addNcopies [(x,m):t] y n | (ord y) == (ord x) = [(x,n+m):t]
  --                       | (ord y) < (ord x) = (x,m) : (addNcopies t y n)
    --                     | otherwise = [(x,m):t] 

addNcopies :: Eq a => MSet a -> a -> Int -> MSet a 
addNcopies ms elm num = foldr (\(x,n)-> (:) (x,n + (if x == elm then num else 0))) [] ms

--2

data SReais = AA Double Double | FF Double Double
            | AF Double Double | FA Double Double
            | Uniao SReais SReais

ex2 :: SReais
ex2 = Uniao (Uniao (AA 4.2 5.5) (AF 3.1 7.0)) (FF (-12.3) 30.0)

--a

instance Show SReais where
    show (Uniao a b) = "(" ++ show a ++ " U " ++ show b ++ ")"
    show intv = ch1 ++ num1 ++ "," ++ num2 ++ ch2
        where (ch1,num1,num2,ch2) = case intv of AA a b -> ("]",show a,show b,"[")
                                                 AF a b -> ("]",show a,show b,"]")
                                                 FA a b -> ("[",show a,show b,"[")
                                                 FF a b -> ("[",show a,show b,"]")

--b

pertence :: Double -> SReais -> Bool
pertence num (Uniao a b) = pertence num a || pertence num b
pertence num intv = (af1 && num >= num1 || num > num1) && (af2 && num <= num2 || num < num2)
    where (af1,num1,num2,af2) = case intv of AA a b -> (False,a,b,False)
                                             AF a b -> (False,a,b,True)
                                             FA a b -> (True,a,b,False)
                                             FF a b -> (True,a,b,True)

--c

tira ::  Double -> SReais -> SReais
tira n (Uniao a b) | pertence n a = Uniao (tira n a) b
                   | pertence n b = Uniao a (tira n b)
                   | otherwise = (Uniao a b)
tira n intv = case intv of AA a b -> if n > a && n < b then (Uniao (AA a n) (AA n b)) else intv
                           AF a b -> if n == b then AA a b else if n > a && n < b then (Uniao (AA a n) (AF n b)) else intv
                           FA a b -> if n == a then AA a b else if n > a && n < b then (Uniao (FA a n) (AA n b)) else intv
                           FF a b -> if n == b then FA a b else if n == a then AF a b else if n > a && n < b then (Uniao (FA a n) (AF n b)) else intv

--3

data RTree a = R a [RTree a]

--a

percorre :: [Int] -> RTree a -> Maybe [a]
percorre [] (R a _) = Just [a]
percorre _ (R a []) = Nothing
percorre (h:t) (R a r) | length r < h || null auxX = Nothing
                       | otherwise = Just (a:auxX)
    where aux = percorre t (r !! (h - 1))
          auxX = fromMaybe [] aux

--b

procura :: Eq a => a -> RTree a -> Maybe [Int]
procura n (R a r) | n == a = Just []
                  | null r = Nothing
                  | otherwise = foldl (\acc num -> if procura n (r !! (num - 1)) == Nothing then acc else Just (num:fromMaybe [] (procura n (r !! (num - 1))))) Nothing [1..length r]



--17/18--teste

--1

insertm :: Ord a => a -> [a] -> [a]
insertm n [] = [n]
insertm n l@(h:t) | n <= h = [n] ++ l
                 | otherwise = [h] ++ (insertm n t)

--2

catMaybesm :: [Maybe a] -> [a]
catMaybesm [] = [] 
catMaybesm (h:t) = case h of Just x -> x : catMaybesm t
                             otherwise -> catMaybesm t

--3


data Exp a = Const a | Var String | Mais (Exp a) (Exp a) | Mult (Exp a) (Exp a)

instance Show a => Show (Exp a) where
    show (Const a) = show a
    show (Var a) = a
    show (Mais a b) = "(" ++ show a ++ " + " ++ show b ++ ")"
    show (Mult a b) = "(" ++ show a ++ " * " ++ show b ++ ")"


--4

sortOn ::  Ord b => (a -> b) -> [a] -> [a]
sortOn _ [] = []
sortOn f (h:t) = insert' h (sortOn f t)
    where insert' a [] = [a]
          insert' a (x:y) = if f a > f x then x:insert' a y else a:x:y

--5

--a

amplitude ::  [Int] -> Int
amplitude [] = 0
amplitude l = mx - mn
    where (mx,mn) = foldl (\(a,b) n -> (if n > a then n else a,if n < b then n else b)) (head l,head l) l 

--b

parte :: [Int] -> ([Int],[Int])
parte l = foldl1 (\(acc1,acc2) (a,b) -> if amplitude acc1 + amplitude acc2 < amplitude a + amplitude b then (acc1,acc2) else (a,b)) combinacoes
    where combinacoes = foldl (\acc n -> splitAt n sl : acc) [] [1..(length l - 1)]
          sl = sort l

--6


data Imagem = Quadrado Int
            | Mover (Int,Int) Imagem
            | Juntar [Imagem] deriving (Show)

ex :: Imagem
ex = Mover (5,5) (Juntar [Mover (0,1) (Quadrado 5),
                          Quadrado 4,
                          Mover (4,3) (Quadrado 2)])

--a

conta :: Imagem -> Int
conta (Quadrado _) = 1
conta (Mover (_,_) im) = conta im
conta (Juntar l) = sum (map conta l)


--b

apaga :: Imagem -> IO Imagem
apaga im = do
    let indquad = indices_quadrados im
    randNum <- randomRIO (1,length indquad)
    let indtoremove = indquad !! (randNum - 1)
    return $ apaga_indice indtoremove im 

indices_quadrados :: Imagem -> [Int]
indices_quadrados (Quadrado n) = [n]
indices_quadrados (Mover (_,_) im) = indices_quadrados im
indices_quadrados (Juntar l) = concatMap indices_quadrados l

apaga_indice :: Int -> Imagem -> Imagem
apaga_indice x (Quadrado n) = if x == n then Juntar [] else Quadrado n
apaga_indice x (Mover (a,b) im) = Mover (a,b) (apaga_indice x im)
apaga_indice x (Juntar l) = Juntar (map (apaga_indice x) l)

--18/19--teste

--1

--a

elemIndicesm::Eq a => a -> [a] -> [Int]
elemIndicesm n [] = []
elemIndicesm n l = elemIndices_aux 0 n l 

elemIndices_aux :: Eq a => Int -> a -> [a] -> [Int]
elemIndices_aux _ _ [] = []
elemIndices_aux i x (h:t) = if x == h then i : elemIndices_aux (i+1) x t else elemIndices_aux (i+1) x t

--b

isSubsequenceOfm :: Eq a => [a] -> [a] -> Bool
isSubsequenceOfm [] _ = True
isSubsequenceOfm _ [] = False
isSubsequenceOfm (x:xs)(y:ys) = if x==y then isSubsequenceOfm xs ys else isSubsequenceOfm(x:xs) ys

--2

data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show

--a

lookupAP :: Ord a => a -> BTree (a,b) -> Maybe b
lookupAP _ Empty = Nothing
lookupAP x (Node (a,b) l r) | x == a = Just b
                            | x < a = lookupAP x l
                            | otherwise = lookupAP x r

--b

zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT _ Empty _ = Empty
zipWithBT _ _ Empty = Empty
zipWithBT f (Node a esq dir) (Node b left right) = Node (f a b) (zipWithBT f esq left) (zipWithBT f dir right)

--3

digitAlpha :: String -> (String,String)
digitAlpha = foldr (\x (ds,as) -> if isDigit x then (x:ds,as) else if isAlpha x then (ds,x:as) else (ds,as)) ([],[]) 

digitAlpham :: String -> (String,String)
digitAlpham [] = ([],[])
digitAlpham s = digitAlpham_aux s ([],[])

digitAlpham_aux :: String -> (String,String) -> (String,String)
digitAlpham_aux [] i = i 
digitAlpham_aux (h:t) (l,r) | isDigit h = digitAlpham_aux t (l++[h],r)
                            | isAlpha h = digitAlpham_aux t (l,r++[h])
                            | otherwise = digitAlpham_aux t (l,r)


--4

data Seq a = Nil | Cons a (Seq a) | App (Seq a) (Seq a)

--a

firstSeq :: Seq a -> a
firstSeq (Cons a s) = a
firstSeq (App Nil s) = firstSeq s
firstSeq (App s _) = firstSeq s

--b

dropSeq :: Int -> Seq a -> Seq a
dropSeq _ Nil = Nil
dropSeq n (Cons a s) = dropSeq (n - 1) s
dropSeq n (App s1 s2) | n > nx = dropSeq (n - nx) s2
                      | n == nx = s2
                      | otherwise = (App (dropSeq n s1) s2)
    where nx = contaCons s1

contaCons :: Seq a -> Int
contaCons Nil = 0
contaCons (Cons _ s) = 1 + contaCons s
contaCons (App s1 s2) = contaCons s1 + contaCons s2

--c

instance Show a => Show (Seq a) where
    show x = "<<" ++ mostra x ++ ">>"

mostra :: Show a => Seq a -> String
mostra Nil = ""
mostra (Cons a Nil) = show a
mostra (Cons a s) = show a ++ "," ++ mostra s
mostra (App s1 s2) = mostra s1 ++ "," ++ mostra s2

--5

type Mat a = [[a]]

--a

getElem :: Mat a -> IO a
getElem mat = do
    let (linhas,colunas) = (length mat, length (head mat))
    randLine <- randomRIO (0,linhas - 1)
    randRow <- randomRIO (0,colunas - 1)
    return $ (mat !! randLine) !! randRow

--b

magic :: Mat Int -> Bool
magic mat = linhasIguaisA n mat && colunasIguaisA n mat && diagonaisIguaisA n mat
    where n = sum (head mat)

linhasIguaisA :: Int -> Mat Int -> Bool
linhasIguaisA n = foldl (\acc l -> sum l == n && acc) True 

colunasIguaisA :: Int -> Mat Int -> Bool
colunasIguaisA n mat = foldl (\acc x -> sum (map (\l -> l !! x) mat) == n && acc) True [0..(length mat - 1)]

diagonaisIguaisA :: Int -> Mat Int -> Bool
diagonaisIguaisA n mat = sum (map (\n -> (mat !! n) !! n) [0..ln]) == n && sum (map (\n -> (mat !! n) !! (ln - n)) [0..ln]) == n
    where ln = length mat - 1