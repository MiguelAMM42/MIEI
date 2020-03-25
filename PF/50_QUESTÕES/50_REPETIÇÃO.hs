module Questoes50_REPETIÇÃO where
import Data.Char
import Data.List

--1)

enumFromTom :: Int -> Int -> [Int]
enumFromTom a b | a==b = [a]
                | a<b =  a: enumFromTom (a+1) b
                | otherwise = reversem(enumFromTom b a)


--2)

enumFromThenTom :: Int -> Int -> Int -> [Int]
enumFromThenTom a b c | a==c = [a]
                      | a<c = enumFromThenTomcrescente a b c
                      | otherwise = enumFromThenTomdecrescente a b c

enumFromThenTomcrescente :: Int -> Int -> Int -> [Int]
enumFromThenTomcrescente a b c | a==c = [a]
                               | a<c = a: enumFromThenTomcrescente(a+b-1) b c
                               | otherwise = []


enumFromThenTomdecrescente :: Int -> Int -> Int -> [Int]
enumFromThenTomdecrescente a b c | a==c = [a]
                                 | a>c = a: enumFromThenTomdecrescente (b) (b+(b-a)) c
                                 | otherwise = []
--3)

maismais :: [a] -> [a] -> [a]
maismais [] l = l
maismais l [] = l
maismais (x:xs) (y:ys) = x: maismais xs (y:ys)

--25)

insertm :: Ord a => a -> [a] -> [a]
insertm x [] = [x]
insertm x (h:t) | x<=h = x:h:t
                | otherwise = h:(insertm x t)

--39)

insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet a [] = []
insereMSet a ((x,y):t) | a==x = (x,(y+1)) : t   --É-nos dito no enunciado que não existem pares cuja primeira componente coincida, logo podemos por só "t" 
                       | otherwise = (x,y) : (insereMSet a t)


--43)

catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (Just x : t) = x: catMaybes t
catMaybes (Nothing : t) = catMaybes t

--33)

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (h:t) | h>(head t) = False
               | h<=(head t) = isSorted t

--22)

cutcut :: Eq a => [a] -> [a] -> [a]
cutcut l [] = l
cutcut [] _ = []
cutcut (x:xs) (y:ys) | y==x = cutcut xs ys
                     | y/=x = x : cutcut xs (y:ys)

--A função "(\\)"" trambém pode ser definida recorrendo à função da alínea 21, a "delete"

cutcut2 :: Eq a => [a] -> [a] -> [a]
cutcut2 l [] = l
cutcut2 [] _ = []
cutcut2 l (x:xs) = (cutcut2 (deletem x l) xs)




--21)

deletem :: Eq a => a -> [a] -> [a]
deletem x [] = []
deletem x (h:t) | x==h = t
                | otherwise = h : (deletem x t)

--8)

zipm :: [a] -> [b] -> [(a,b)]
zipm _ [] = []
zipm [] _ = []
zipm (x:xs) (y:ys) = (x,y) : zipm xs ys

--10)

replicatem :: Int -> a -> [a]
replicatem n x | n>0 = x: replicatem (n-1) x
               | otherwise = []


--7)

dropm :: Int-> [a] -> [a]
dropm _ [] = []
dropm n (x:xs) | n == 1 = xs
               | n>1 = dropm (n-1) xs
               | otherwise = []

--4)

exclamation2 :: [a] -> Int -> a
exclamation2 [] _ = error "Dá erro"
exclamation2 (x:xs) n | n == 0 = x
                      | otherwise = exclamation2 xs (n-1)


--9)

elemm :: Eq a => a -> [a] -> Bool
elemm _ [] = False
elemm n (x:xs) | n == x = True
              | otherwise = elemm n xs


--13)


concatm :: [[a]] -> [a]
concatm [] = []
concatm (h:t) = h++concatm t


--48)

data Posicao = Pos Int Int
       deriving Show

vizinhos :: Posicao -> [Posicao] -> [Posicao]
vizinhos _ [] = []
vizinhos (Pos x y) ((Pos a b):t) | (a == x) && (b == (y+1)) = (Pos a b) : vizinhos (Pos x y) t  
                                 | (a == x) && (b == (y-1)) = (Pos a b) : vizinhos (Pos x y) t
                                 | (b == y) && (a == (x+1)) = (Pos a b) : vizinhos (Pos x y) t
                                 | (b == y) && (a == (x-1)) = (Pos a b) : vizinhos (Pos x y) t
                                 | otherwise = vizinhos (Pos x y) t


--31)

posImpares :: [a] -> [a]
posImpares [] = []
posImpares [a] = []
posImpares (a:b:c) = b : posImpares c 


--30)

algarismos :: [Char] -> [Char]
algarismos [] = []
algarismos (h:t) | isDigit h = h : algarismos t
                 | otherwise = algarismos t


--45)

data Movimento = Norte | Sul | Este | Oeste
          deriving Show

caminho::(Int,Int)->(Int,Int)-> [Movimento]
caminho (a,b) (x,y) | a > x =  Oeste : caminho (a-1,b) (x,y)
                    | a < x =  Este : caminho (a+1,b) (x,y)
                    | b > y =  Sul : caminho (a,b-1) (x,y)
                    | b < y =  Norte : caminho (a,b+1) (x,y)
                    | otherwise = []


--49)


mesmaOrdenada :: [Posicao] -> Bool
mesmaOrdenada [] = True
mesmaOrdenada [x] = True
mesmaOrdenada ((Pos a b):(Pos x y):t) | y/=b = False
                                      | otherwise = mesmaOrdenada((Pos a b):t)

--27)

unlinesm :: [String] -> String
unlinesm [] = ""
unlinesm [x] = x ++ "\n"
unlinesm (h:t) = h ++ "\n" ++ unlinesm t

--41)DEPENDE DA 39

constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet l = constroiMSet_aux [] l

constroiMSet_aux :: Eq a => [(a,Int)] -> [a] -> [(a,Int)]
constroiMSet_aux l [] = l
constroiMSet_aux l (h:t) = constroiMSet_aux (insereMSet h l) t 

--29)

temRepetidos:: Eq a => [a] -> Bool
temRepetidos [] = False
temRepetidos [x] = False
temRepetidos (x:xs) | existeelem x xs = True
                    | otherwise = temRepetidos xs


existeelem :: Eq a => a -> [a] -> Bool
existeelem a [] = False
existeelem a (x:xs) | a==x = True
                    | otherwise = existeelem a xs


--36)

elemMSet :: Eq a=> a -> [(a,Int)] -> Bool
elemMSet _ [] = False
elemMSet n ((a,b):t) | n==a = True
                     | otherwise = elemMSet n t

--42)

partitionEithersm :: [Either a b] -> ([a],[b])
partitionEithersm [] = ([],[])
partitionEithersm l = pE_aux l ([],[]) --acumulador em estado neutro
 where 
   pE_aux :: [Either a b] -> ([a],[b]) -> ([a],[b])
   pE_aux [] p = p
   pE_aux (Left a : t) (l,r) = (a:l,r) 
   pE_aux (Right b : t) (l,r) = (l,b:r) 


pE :: [Either a b] -> ([a],[b])
pE l = (partL l, partR l)


partL :: [Either a b] -> [a]
partL ((Left x):t) = x : (partL t)
partL (_: t) = partL t
partL [] = []

partR :: [Either a b] -> [b]
partR ((Right x):t) = x : (partR t)
partR (_: t) = partR t
partR [] = []


--23)

unionm :: Eq a=> [a] -> [a] -> [a]
unionm l [] = l
unionm [] l = l
unionm (x:xs) (y:ys) | y==x = unionm (x:xs) ys
                     | otherwise = (unionm (x:xs) ys) ++ [y]


--5)

reversem :: [a] -> [a]
reversem [] = []
reversem (x:xs) = reversem xs ++ [x]


--16)

isPrefixOfm :: Eq a => [a] -> [a] -> Bool
isPrefixOfm [] _ = True
isPrefixOfm _ [] = False
isPrefixOfm (x:xs) (y:ys) | x==y = isPrefixOfm xs ys
                          | otherwise = False


--17)

isSuffixOfm :: Eq a => [a] -> [a] -> Bool
isSuffixOfm [] _ = False
isSuffixOfm _ [] = True
isSuffixOfm l1 l2 = isPrefixOfm (reversem l1) (reversem l2)

--

--32)

posPares :: [a] -> [a]
posPares [] = []
posPares [a] = [a]
posPares (a:b:xs) = a:posPares xs

--18)

isSubsequenceOfm :: Eq a => [a] -> [a] -> Bool
isSubsequenceOfm [] _ = True
isSubsequenceOfm _ [] = False
isSubsequenceOfm (x:xs)(y:ys) | x==y = isSubsequenceOfm xs ys 
                              | otherwise = isSubsequenceOfm(x:xs) ys

--6)

takem:: Int -> [a] -> [a]
takem n [] = []
takem n (x:xs) | n==0 = x:xs
               | n>1 = x : (takem (n-1) xs)
               | otherwise = []



--15)

tailsm:: [a]->[[a]]
tailsm [] = [[]]
tailsm (x:xs) = (x:xs):(tailsm xs)



--28) 

pMaiorm :: Ord a => [a] -> Int
pMaiorm l = pMaiorm_aux 0 (maximum l) l

pMaiorm_aux :: Ord a => Int -> a -> [a] -> Int
pMaiorm_aux x _ [] = x
pMaiorm_aux x y (h:t) = if y == h then pMaiorm_aux x y [] else pMaiorm_aux (succ x) y t


--40)

removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet a ((x,y):t) | (a==x && y>1) = (x,y-1) : t 
                       | (a==x && y==1) = t
                       | otherwise = (x,y) : removeMSet a t


--20)

nubm:: Eq a => [a] -> [a]
nubm [] = []
nubm (h:t) = h : nubm(nubm_aux h t)

nubm_aux :: Eq a => a -> [a] -> [a]
nubm_aux _ [] = []
nubm_aux x (h:t) = if h==x then (nubm_aux x t) else (h : nubm_aux x t)



--35)

menor :: String -> String -> Bool
menor [] _ = True
menor _ [] =  False
menor (x:xs) (y:ys) | a==b = menor as bs
                    | elem a [b..'z'] = False
                    | otherwise = True
         where (a:as) = toMinuscula (x:xs)
               (b:bs) = toMinuscula (y:ys)

toMinuscula :: String -> String
toMinuscula [] = []
toMinuscula (h:t) | elem h ['a'..'z'] = h : toMinuscula t 
                  | otherwise = c : toMinuscula t
         where c = head (drop ((length ['A'..h])-1) ['a'..'z'])




--44)




posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao (a,b) [] = (a,b)
posicao (a,b) (x:xs) | show x == "Este" = posicao (a+1,b) xs
                     | show x == "Oeste" = posicao (a-1,b) xs
                     | show x == "Norte" = posicao (a,b+1) xs
                     | show x == "Sul" = posicao (a,b-1) xs




--OU--

posicaom :: (Int,Int) -> [Movimento] -> (Int,Int)
posicaom (x,y) [] = (x,y)
posicaom (x,y) (Norte:t) = posicaom (x,y+1) t
posicaom (x,y) (Sul:t) = posicaom (x,y-1) t
posicaom (x,y) (Este:t) = posicaom (x+1,y) t
posicaom (x,y) (Oeste:t) = posicaom (x-1,y) t


--19)

elemIndicesm::Eq a => a -> [a] -> [Int]
elemIndicesm n [] = []
elemIndicesm n l = elemIndices_aux 0 n l 

elemIndices_aux :: Eq a => Int -> a -> [a] -> [Int]
elemIndices_aux _ _ [] = []
elemIndices_aux i x (h:t) = if x == h then i : elemIndices_aux (i+1) x t else elemIndices_aux (i+1) x t

--12)

groupm::Eq a=> [a] -> [[a]]
groupm [] = []
groupm (h:t) = inserem h (groupm t)

inserem:: Eq a => a-> [[a]] -> [[a]]
inserem h [] = [[h]]
inserem h (y:ys) | elem h y = (h:y):ys
                 | otherwise = [h]:(y:ys) 


--46)

vertical :: [Movimento] -> Bool
vertical [] = True
vertical (x:xs) | (show x == "Norte" || show x == "Sul") = vertical xs
                | otherwise = False


--34)

iSortm :: Ord a => [a] -> [a]
iSortm [] = []
iSortm (x:xs) = insertmn x (iSortm xs)

insertmn :: Ord a => a -> [a] -> [a]
insertmn b [] = [b]
insertmn b (y:ys) | b<=y = (b:y:ys)
                  | otherwise = y:(insertmn b ys)

--11)

interspersem :: a -> [a] -> [a]
interspersem n [] = []
interspersem n (x:xs) = x:n:(interspersem n xs)

--14)

initsm:: [a] -> [[a]]
initsm [] = [[]]
initsm l = initsm (initm l) ++ [l]

initm :: [a] -> [a]
initm [x] = []
initm (x:xs) = [x] ++ initm xs

--24)

intersectm :: Eq a => [a] -> [a] -> [a]
intersectm [] l = []
intersectm (y:ys) l1 | elem y l1 = y : (intersectm ys l1)
                     | otherwise = intersectm ys l1


--26)

unwordsm:: [String] -> String
unwordsm [] = ""
unwordsm (x:xs) = x ++ " " ++ unwordsm xs

--37)

lengthMSet :: [(a,Int)] -> Int
lengthMSet [] = 0
lengthMSet ((a,b):t) = b + (lengthMSet t) 

--38)

converteMSet :: [(a,Int)] -> [a]
converteMSet [] = []
converteMSet ((a,b):t) = (replicatem b a) ++ converteMSet t 

--47)



maisCentral :: [Posicao] -> Posicao
maisCentral [] = Pos 0 0
maisCentral (h:t) = maisCentral_aux t h
    where maisCentral_aux :: [Posicao] -> Posicao -> Posicao
          maisCentral_aux [] max = max
          maisCentral_aux (Pos x y:t) (Pos x1 y1) = if x1^2 + y1^2 > x^2 + y^2
                                                    then maisCentral_aux t (Pos x y) --posiçao mais perto da origem
                                                    else maisCentral_aux t (Pos x1 y1)



--50)

data Semaforo = Verde | Amarelo | Vermelho
               deriving Show

interseccaoOK :: [Semaforo] -> Bool
interseccaoOK l = length [s | s <- l , case s of Vermelho -> False ; otherwise -> True ] < 2
          
                    