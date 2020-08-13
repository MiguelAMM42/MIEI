import Data.Char


--1)a

--Olhar para a função e ver se ela é vazia. Não é então começar:

--funA [2,3,5,1]
--funA(2:[3,5,1])
--2^2 + funA[3,5,1] 
--4 + funA[3,5,1]
--4 + funA(3:[5,1])
--4 + 3^2 + funA[5,1]


--1)b

--mod 8 2==0

--(funB [8,5,12])
--(8: funB[5,12])
--(8: fun[12])
--(8: 12)

--1)c

--Dúvidas

--1)d

--funD "otrec"
--g [] "otrec"






--2)a

dobros:: [Float]->[Float]
dobros [] = []
dobros (x:xs) = 2*x : dobros xs

--2)b

numOcorre:: Char-> String->Int
numOcorre  a []  = 0
numOcorre a (h:t) = if a == h then 1 + numOcorre a t else (numOcorre a t)

--2)c

positivos:: [Int]->Bool
positivos[]= True
positivos(x:xs)= x>=0 && positivos xs


--2)d

soPos::[Int]-> [Int]
soPos (h:t)= if h>0 then h:(soPos t) else soPos t
soPos []=[]


--2)e

somaNeg::[Int]-> Int
somaNeg(h:t)=if h<0 then h + somaNeg t else somaNeg t
somaNeg []=0


--2)f

tresUlt::[a]->[a]
tresUlt []=[]
tresUlt(h:[a,b,c]) = [a,b,c]

--2)g

segundos::[(a,b)]->[b]
segundos[]=[]
segundos((a,b):xs)=b:segundos xs

--2)h

nosPrimeiros:: (Eq a)=> a -> [(a,b)] -> Bool
nosPrimeiros i []= False
nosPrimeiros i [(a,b)]= if i==a then True else False 

--DÚVIDAS---


--2)i


sumTriplos:: (Num a, Num b, Num c)=> [(a,b,c)]->(a,b,c)
sumTriplos []= (0,0,0)
sumTriplos (x:xs)= somaTriplos x(sumTriplos xs)

somaTriplos::(Num a, Num b, Num c)=> (a,b,c)->(a,b,c)->(a,b,c)
somaTriplos (a,b,c) (x,y,z)= (a+x, b+y, c+z)

--3)a


soDigitos:: [Char]->[Char]
soDigitos []= []
soDigitos (x:xs) = if isDigit x then x:soDigitos xs else
 soDigitos xs

--(isDigit x) é o mesmo que (ord x >= ord '0' && ord x <= ord '9')

--3)b

minusculas:: [Char]->Int
minusculas []= 0
minusculas (x:xs) = if isLower x then 1+minusculas xs else minusculas xs

--(isLower x) é o mesmo que (ord x >= ord 'a' && ord x <= ord 'z')


--3)c


 nums:: String->[Int] 
nums a = numa (soDigitos a)

numa:: [Char]-> [Int]
numa [] = []
numa (h:t) = (ord h - 48): numa t 





































