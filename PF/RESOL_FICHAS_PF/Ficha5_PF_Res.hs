--map:: (a->b) -> [a]-> [b]
--map f [] = []
--map f (a:as) = (f a) : map f as

--map (*2) [1,2,3,4] -> [2,4,6,8]

--map (>0) [1.2.3.4]

--1

--a

myany:: (a-> Bool) -> [a] -> Bool
myany p [] = False ---pq estamos a testar se algum dos elementos satisfazem o predicado, não a testar se todos o satisfazem
myany p (a:as) = p a || myany p as

--any(>4) [1,2,3,4] -> False
--any(>3) [1,2,3,4] -> True

--b 

myzipWith :: (a->b->c) -> [a] -> [b] -> [c]
myzipWith p [] [] = []
myzipWith p (x:xs) (y:ys) = p x y : myzipWith p xs ys


--c

mytakeWhile :: (a -> Bool) -> [a] -> [a]
mytakeWhile p [] = []
mytakeWhile p (x:xs) | p x == True = x: mytakeWhile p xs
                     | otherwise = []


--d

mydropWhile :: (a-> Bool) -> [a] -> [a]
mydropWhile p [] = []
mydropWhile p (x:xs) | p x == True = mydropWhile p xs
                     | otherwise = x:xs

--e

myspan :: (a-> Bool) -> [a] ->  ([a],[a])
myspan p [] = ([],[])
myspan p (x:xs) | p x = (x:e, d)
                | otherwise = (e, x:d)
       where (e,d) = myspan p xs


--f


mydeleteBy :: (a->a-> Bool) -> a -> [a] -> [a]
mydeleteBy f y [] = []
mydeleteBy f y (x:xs)  | f y x = xs
                       | otherwise = x: mydeleteBy f y xs  


--g

--NOTA: Eu não quero comparar "a"s, quero comparar "b"s, por isso, tenho de pôr "f" antes do elemento ou da lista, pois eu pretendo trabalhar
--com os "b"s, originários dos "a"s


mysortOn :: Ord b => (a -> b) -> [a] -> [a]
mysortOn f [] = []
mysortOn f (x:xs) = insert f x (mysortOn f xs)

insert :: Ord b => (a -> b) -> a -> [a] -> [a]
insert f x [] = [x]
insert f x (y:ys) = if f x < f y then x:y:ys else y:insert f x ys



--2

--a

type Polinomio = [Monomio]
type Monomio = (Float, Int)

selgrau :: Int -> Polinomio -> Polinomio
selgrau n [] = []
selgrau n l = filter (\x -> snd x == n) l
