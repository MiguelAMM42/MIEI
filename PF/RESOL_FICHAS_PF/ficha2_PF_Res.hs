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




--2

--a

dobros:: [Float]->[Float]
dobros [] = []
dobros (x:xs) = 2*x : dobros xs

--b

numOcorre:: Char-> String->Int
numOcorre  a []  = 0
numOcorre a (h:t) = if a == h then 1 + numOcorre a t else (numOcorre a t)


--c

positivos:: [Int]->Bool
positivos (h:t)= if h>0
positivos []= False