module Questoes50 where
import Data.Char
import Data.List



--As funções terão um "m" à frente, para que não exista confusão com as predefinidas

--1

enumFromTom:: Int -> Int -> [Int]
enumFromTom a b | a==b =  [a]
                | a<b = a: enumFromTom (a+1) b 
                | otherwise = []

--2

enumFromThenTom:: Int -> Int-> Int-> [Int]
enumFromThenTom a b c | a==c = [a]
                      | a<c = a : enumFromThenTom(a+b-1) b c
                      | otherwise = []

--3

--NOTA:"unil" é a designação desta função, visto que a mesma une lsitas

unil:: [a] -> [a] -> [a]
unil [] (y:ys) = y:ys
unil (x:xs) (y:ys) = x: unil xs (y:ys)

--4

elemnumb:: [a] -> Int -> a
elemnumb (x:xs) n | n==0 = x
                  | n>0 = elemnumb xs (n-1)


--5

reversem:: [a]->[a]
reversem []= []
reversem (h:t) =  reversem t ++ [h] 

--Forma + eficaz(que "puxa" menos pelo PC), vista em PF no dia 16/10/2019

reversemBetter::[a]->[a]
reversemBetter l = reversemBetterAc l []

  where reversemBetterAc:: [a] -> [a] -> [a]
        reversemBetterAc (x:xs) a =  reversemBetterAc xs (x:a)
        reversemBetterAc [] a = a

--6

takem :: Int -> [a] -> [a]
takem 0 l = []
takem n [] = []
takem n (x:xs) | n>0 = x: (takem (n-1) xs)
               | n<0 = []

--7

dropm:: Int -> [a] -> [a]
dropm 0 l = l
dropm n [] = []
dropm n (x:xs) |n>0 = dropm (n-1) xs
               |n<0 = x:xs 

--8

zipm:: [a] -> [b] -> [(a,b)]
zipm [] (y:ys) = []
zipm (x:xs) [] = []
zipm (x:xs) (y:ys) = (x,y) : zipm xs ys  


--9

elemm :: Eq a => a -> [a] -> Bool
elemm n [] = False
elemm x (h:t) = if x==h then True else elemm x t

--10

replicatem :: Int -> a -> [a]
replicatem a n | a<=0 = []
               | a==1 = [n]
               | a>1 = n: replicatem (a-1) n 


--11

interspersem :: a -> [a] -> [a]
interspersem n [] = []
interspersem n [x] = [x]
interspersem n (x:xs) = x: n: interspersem n xs           

--12

groupm:: Eq a => [a] -> [[a]]
groupm [] = []
groupm (h:t) = groupm2 h (groupm t)

--Função auxiliar:

groupm2:: Eq a => a -> [[a]] -> [[a]]
groupm2 x (h:t) | x == head h = (x:h) : t
groupm2 x l = [x]: l



--13

concatm :: [[a]] -> [a]
concatm [[]] = []
concatm (h:t) = h ++ concatm t

--14

initsm:: [a]-> [[a]]
initsm [] = [[]]
initsm l = initsm (init l) ++ [l]


-- [1,2,3] -> [[], [1], [1,2], [1.2,3]]

-- init [1,2,3] -> [1,2]
-- [[l]] ++ [[]]
-- A função init já está predefenida 

 

--15

tailsm:: [a]-> [[a]]
tailsm [] = [[]]
tailsm l = [l] ++ tailsm ( tail l) 


--16

isPrefixOfm :: Eq a => [a] -> [a] -> Bool
isPrefixOfm [] _ = True
isPrefixOfm _ [] = False
isPrefixOfm (x:xs) (y:ys) | x==y = isPrefixOfm xs ys 
                          | otherwise = False 

--17

isSuffixOfm:: Eq a => [a] -> [a] -> Bool
isSuffixOfm _[] = False
isSuffixOfm []_ = True
isSuffixOfm l1 l2 = isPrefixOfm (reversem l1) (reversem l2)

--18

isSubsequenceOfm :: Eq a => [a] -> [a] -> Bool
isSubsequenceOfm [] _ = True
isSubsequenceOfm _ [] = False
isSubsequenceOfm (x:xs)(y:ys) = if x==y then isSubsequenceOfm xs ys else isSubsequenceOfm(x:xs) ys

--19

elemIndicesm::Eq a => a -> [a] -> [Int]
elemIndicesm n [] = []
elemIndicesm n l = elemIndices_aux 0 n l 

elemIndices_aux :: Eq a => Int -> a -> [a] -> [Int]
elemIndices_aux _ _ [] = []
elemIndices_aux i x (h:t) = if x == h then i : elemIndices_aux (i+1) x t else elemIndices_aux (i+1) x t

--20

nubm:: Eq a => [a] -> [a]
nubm [] = []
nubm (h:t) = h : nubm(nubm_aux h t)

nubm_aux :: Eq a => a -> [a] -> [a]
nubm_aux _ [] = []
nubm_aux x (h:t) = if h==x then (nubm_aux x t) else (h : nubm_aux x t)

--21

deletem::  Eq a => a -> [a] -> [a]
deletem n [] = []
deletem n (x:xs) = if n==x then xs else x:(deletem n xs) 

--22

removem::  Eq a => [a] -> [a] -> [a]
removem [] [] = []
removem [] l = []
removem l [] = l
removem (x:xs) (y:ys) | y==x = removem xs ys
                      | y/=x = x : removem xs (y:ys)

--23

unionm:: Eq a => [a] -> [a] -> [a]
unionm l [] = l
unionm l (h:t) | elem h l = unionm l t
               | otherwise = unionm (l++[h])t

--24

intersectm:: Eq a => [a] -> [a] -> [a]
intersectm [] l1 = []
intersectm (x:xs) l1 = if elem x l1 then (x:intersectm  xs l1) else intersectm xs l1  

--25

insertm :: Ord a => a -> [a] -> [a]
insertm n [] = [n]
insertm n (h:t) | n<= h = n:(h:t)
                | otherwise = h: (insertm n t )

--26

unwordsm :: [String] -> String
unwordsm [] = ""
unwordsm [a] = a
unwordsm (h:t) = unil (unil h " ") (unwordsm t)

--27

unlinesm:: [String] -> String
unlinesm [] = ""
unlinesm [x] = unil x "\n"
unlinesm (h:t) = unil (unil h ['\n']) (unlinesm t)

--28 

-- As posições da lista começam em 0, i.e., a função deverá retornar 0 se o primeiro elemento da lista for o maior.

pMaiorm :: Ord a => [a] -> Int
pMaiorm l = pMaiorm_aux 0 (maximum l) l

pMaiorm_aux :: Ord a => Int -> a -> [a] -> Int
pMaiorm_aux x _ [] = x
pMaiorm_aux x y (h:t) = if y == h then pMaiorm_aux x y [] else pMaiorm_aux (succ x) y t

--29

temRepetidosm:: Eq a => [a] -> Bool
temRepetidosm [] = False
temRepetidosm (h:t) = if elemm h t then True else temRepetidosm t

--30

algarismosm :: [Char] -> [Char]
algarismosm [] = []
algarismosm (x:xs) = if isDigit x  then x:algarismosm xs else algarismosm xs 

--31

posImparesm :: [a] -> [a]
posImparesm [] = []
posImparesm (a:b:c) = b: posImparesm c 

--32

posParesm :: [a] -> [a]
posParesm [] = []
posParesm (a:b:c) = a: posParesm c

--33
 
isSortedm :: Ord a => [a] -> Bool
isSortedm [] = True
isSortedm [a] = True
isSortedm (x:xs) | x > head xs = False
                 | otherwise = isSortedm xs 


--34

iSortm :: Ord a => [a] -> [a]
iSortm [] = []
iSortm (x:xs) =insertm1 x (iSortm xs)



insertm1:: Ord a => a -> [a] -> [a]
insertm1 k [] = [k]
insertm1 k (x:xs) | k<=x = k:(x:xs)
                  | otherwise = x:(insertm1 k xs)



--35 

menor :: String-> String -> Bool 
menor [] [] = False
menor [] l = True 
menor l [] = False
menor (x:xs) (y:ys) | x>y = False
                    | x<=y = menor xs ys


--36

elemSet :: Eq a => a -> [(a,Int)] -> Bool
elemSet _ [] = False
elemSet x (h:t) = if x == (fst h) then True else elemSet x t


--37

lengthMSet :: [(a,Int)] -> Int
lengthMSet [] = 0
lengthMSet (h:t) = (snd h) + lengthMSet t 

--38

converteMSet ::  [(a,Int)] -> [a]
converteMSet [] = []
converteMSet (h:t) = (replicatem (snd h)(fst h)) ++ converteMSet t 

--39

insereMSet :: Eq a => a -> [(a,Int)]-> [(a,Int)]
insereMSet x [] = [(x,1)]
insereMSet x ((a,b):t) | x==a = (a,(b+1)) :  t
                       | x/=a = (a,b) : insereMSet x t


--40

removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet x [] = []
removeMSet x ((a,b):t) | x == a = t
                       | x/=a = (a,b) :  removeMSet x t


--41

constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet l = constroiMSet_aux [] l

constroiMSet_aux :: Eq a => [(a,Int)] -> [a] -> [(a,Int)]
constroiMSet_aux x [] = x
constroiMSet_aux x (h:t) = constroiMSet_aux (insereMSet h x) t 

--DÚVIDAS


--42

partitionEithersm :: [Either a b]-> ([a],[b])
partitionEithersm l = partitionEithersm_aux l ([],[])
  where
    partitionEithersm_aux [] l = l
    partitionEithersm_aux ((Left x):t) (a,b) = partitionEithersm_aux t (x:a,b)
    partitionEithersm_aux ((Right x):t) (a,b) = partitionEithersm_aux t (a,x:b)

--DÚVIDAS


--43

catMaybesm :: [Maybe a]-> [a]
catMaybesm [] = []
catMaybesm (Just x:t) = x : catMaybesm t
catMaybesm (Nothing : t) = catMaybesm t

--DÚVIDAS

--44

data Movimento = Norte | Sul | Este | Oeste
        deriving Show

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao (x,y) [] = (x,y)
posicao (x,y) (Norte:t) = posicao (x,y+1) t
posicao (x,y) (Sul:t) = posicao (x,y-1) t
posicao (x,y) (Este:t) = posicao (x+1,y) t
posicao (x,y) (Oeste:t) = posicao (x-1,y) t

--45

caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x1,y1) (x2,y2) | x1 > x2 =  Oeste : caminho (x1-1, y1) (x2, y2)
                        | x1 < x2 =  Este : caminho (x1+1, y1) (x2, y2)
                        | y1 > y2 =  Sul : caminho (x1, y1-1) (x2, y2)
                        | y1 < y2 =  Norte : caminho (x1, y1+1) (x2, y2)
                        | otherwise = []


--46

vertical :: [Movimento] -> Bool
vertical [] = False
vertical [Norte] = True
vertical [Sul] = True
vertical [Oeste] = False
vertical [Este] = False
vertical (Norte:t)  = vertical t
vertical (Sul:t) = vertical t
vertical (Este:t) = False
vertical (Oeste:t) = False


vertical2 :: [Movimento] -> Bool
vertical2 [] = True
vertical2 (Norte:t) = True && vertical t
vertical2 (Sul:t) = True && vertical t
vertical2 (Este:t) = False && vertical t
vertical2 (Oeste:t) = False && vertical t


--47

data Posicao = Pos Int Int
        deriving Show


maisCentral :: [Posicao] -> Posicao
maisCentral [] = Pos 0 0
maisCentral (h:t) = maisCentral_aux t h
    where maisCentral_aux :: [Posicao] -> Posicao -> Posicao
          maisCentral_aux [] max = max
          maisCentral_aux (Pos x y:t) (Pos x1 y1) = if x1^2 + y1^2 > x^2 + y^2
                                                    then maisCentral_aux t (Pos x y) --posiçao mais perto da origem
                                                    else maisCentral_aux t (Pos x1 y1)

--DÚVIDAS NA 47,48,49 E 50(ENTENDER O CÓDIGO)

--48

vizinhos :: Posicao -> [Posicao] -> [Posicao]
vizinhos _ [] = []
vizinhos (Pos x y) ((Pos x1 y1):t) | (y == y1) && (x == (x1 +1)) = (Pos x1 y1) : vizinhos (Pos x y) t
                                   | (y == y1) && (x == (x1 -1)) = (Pos x1 y1) : vizinhos (Pos x y) t
                                   | (x == x1) && (y == (y1 +1)) = (Pos x1 y1) : vizinhos (Pos x y) t
                                   | (x == x1) && (y == (y1 -1)) = (Pos x1 y1) : vizinhos (Pos x y) t
                                   | otherwise = vizinhos (Pos x y) t


--49
mesmaOrdenada :: [Posicao] -> Bool
mesmaOrdenada [] = True
mesmaOrdenada [x] = True
mesmaOrdenada ((Pos x1 y1):(Pos x2 y2): t) = if x1 == x2 then mesmaOrdenada ((Pos x2 y2):t) else False


--50)
data Semaforo = Verde | Amarelo | Vermelho
                deriving Show

interseccaoOK :: [Semaforo] -> Bool
interseccaoOK l = interseccaoOK_aux l False
    where interseccaoOK_aux :: [Semaforo] -> Bool -> Bool
          interseccaoOK_aux [] _ = True
          interseccaoOK_aux (Vermelho:t) v = interseccaoOK_aux t v --espera pelo resto da lista para saber a veracidade
          interseccaoOK_aux (_ :t) False = interseccaoOK_aux t True --algo que não vermelho muda a veracidade para True
          interseccaoOK_aux (_ :t) True = False -- truque para chamar a funçao e mudar a veracidade para falso 
        
              

