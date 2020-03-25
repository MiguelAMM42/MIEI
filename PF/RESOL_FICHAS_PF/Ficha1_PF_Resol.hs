import Data.Char


--1)a

perimetro :: Float->Float
perimetro(r) = 2*pi*r

--1)b

dist :: (Double,Double)->(Double, Double)->Double
dist (p1x,p1y)(p2x,p2y)= sqrt(dx+dy)
 where
 dx=(p1x-p2x)^2
 dy=(p1y-p2y)^2

--1)c

primUlt :: [Int]->(Int,Int)
primUlt l = (head l, last l)

 --1)d

multiplo :: Int->Int->Bool
multiplo m n = mod n m == 0

--1)e

truncaImpar :: [Int]->[Int]
truncaImpar l = if odd(length l)
 then tail l
 else l

--1)f

max2:: Int->Int->Int
max2 x y = if x > y
 then x
 else y

--1)g

max3 :: Int->Int->Int->Int
max3 x y z = max2 ( max2 x y) z

--2)a

nRaizes :: Double->Double-> Double-> Int
nRaizes a b c = if det<0
 then 0
 else if det==0 then 1 else 2
 where
  det= b^2-4*a*c

--2)b

raizes:: Double->Double->Double->[Double]
raizes a b c  | n==0=[]
              | n==1=[r1]
              | otherwise = [r1,r2]
 where
  det= b^2-4*a*c
  n= nRaizes a b c
  r1= (-b+sqrt det)/(2*a)
  r2= (-b-sqrt det)/(2*a)

--3)a

type Hora = (Int,Int)

horaValida :: Hora-> Bool
horaValida (h,m) = (0<=h && h<24)&&(0<m && m<60)

--3)b

eDepois :: Hora->Hora->Bool
eDepois (h1,m1)(h2,m2)| h1>h2= True
                      | h1<h2= False
                      | otherwise = m1>m2

--3)c

type Minutos= Int

converteMinutos::Hora->Minutos
converteMinutos(h,m)=h*60+m

--3)d

converteHoras::Minutos->Hora
converteHoras mins= (mins`div`60, mins`mod`60)

--3)e

diferencaHoras::Hora->Hora->Int
diferencaHoras h1 h2 = abs(converteMinutos h1 - converteMinutos h2)

--3)f

adicionaMinutos:: Hora->Minutos->Hora
adicionaMinutos h m = converteHoras (converteMinutos h + m)


--Os nomes estranhos das funções do ex.4 devem-se ao facto de não se poder dar o mesmo nome a duas funções declaradas de forma diferente
--4)a

data Hour = H Int Int deriving (Show,Eq)

hourValida:: Hour->Bool
hourValida (H h m)= (0<=h && h<24) && (0<=m && m<60)

--4)b

andDepois :: Hour->Hour->Bool
andDepois (H h1 m1)(H h2 m2)| h1>h2= True
                      | h1<h2= False
                      | otherwise = m1>m2

--4)c

type Minutes= Int

converteMinutes::Hour->Minutes
converteMinutes(H h m)=h*60+m

--4)d

converteHours::Minutes->Hour
converteHours min = H h m 
 where 
 h= min`div`60
 m= min`mod`60

--4)e

diferenceHours::Hour->Hour->Int
diferenceHours (H h1 m1)(H h2 m2) = abs(converteMinutes(H h1 m1) - converteMinutes(H h2 m2))


--4)f

addMinutes:: Hour->Minutes->Hour
addMinutes(H h m)minu = converteHours (converteMinutes(H h m)+ minu)


--5


data Semaforo= Verde | Amarelo | Vermelho deriving (Show,Eq)

--5)a

next:: Semaforo->Semaforo   
next x=if x==Verde then Amarelo else Vermelho

--5)b

stop:: Semaforo-> Bool
stop x=if x==Vermelho then True else False

--5)c

safe::Semaforo->Semaforo->Bool
safe x y = if (x==Vermelho && y==Verde) || (x==Verde && y==Vermelho) then True else False

--6

data Ponto= Cartesiano Double Double | Polar Double Double deriving (Show,Eq)

--6)a

posx :: Ponto->Double
posx(Cartesiano x y)= x

--6)b

posy :: Ponto->Double
posy(Cartesiano x y)= y

--6)c

raio:: Ponto->Double
raio(Cartesiano x y)=sqrt(x^2+y^2)

--6)d

angulo:: Ponto->Double
angulo(Polar x y)= atan(y/x)

--6)e

--Chamei "dista" à função porque num exercício anterior já existia uma função com o nome "dist"

dista:: Ponto->Ponto->Double
dista(Cartesiano x1 y1)(Cartesiano x2 y2)=sqrt(dtx+dty)
 where
 dtx=(x1-x2)^2
 dty=(y1-y2)^2

--7

data Figura = Circulo Ponto Double
            |Rectangulo Ponto Ponto
            |Triangulo Ponto Ponto Ponto 
               deriving (Show,Eq)

--7)a

poligono :: Figura-> Bool
poligono (Circulo _ r)= r>0
poligono (Rectangulo x y)= posx x/=posx y && posy x/= posy y
poligono (Triangulo x y z)=((abs(b-c))< a && a < (b + c))
                         ||((abs(a-c))< b && b < (a + c))
                         ||((abs(a-b))< c && c < (a + b))
        where
            a= (dista x y)
            b= (dista x z)
            c= (dista y z)




--Dúvidas na 7----------

--7)b

vertices::Figura->[Ponto]
vertices(Circulo _ r)= []
vertices(Rectangulo x y )= [ x, y, (Cartesiano x1 (y1 +vy)), (Cartesiano(x1+vx)y1)]
    where
     x1= posx x
     y1= posy y
     vx= posx y -posx x
     vy= posy y -posy x
vertices(Triangulo x y z)= [x, y, z]

--7)c

area :: Figura-> Double
area(Triangulo x y z)=
  let a = dista x y
      b = dista y z
      c = dista z x
      s = (a+b+c) / 2   --semi-perimetro
  in sqrt (s*(s-a)*(s-b)*(s-c))    -- formula de Heron
area(Rectangulo x y) = abs(posx x -posy y)* abs(posy x - posy y)
area(Circulo _ r)= pi*(r^2)


--7)d 

perimetro1:: Figura->Double
perimetro1(Triangulo x y z)= a+b+c
     where 
     a = dista x y
     b = dista y z
     c = dista z x
perimetro1(Rectangulo x y)= 2*abs(posx x -posy y)+ 2*abs(posy x - posy y)
perimetro1(Circulo _ r)=pi*(2*r)


--8

--8)a

isLowerm :: Char -> Bool
isLowerm x = if (ord x >= 97 && ord x<=122) then True else False

--8)b

isDigit :: Char-> Bool
isDigit x = if (ord x>= ord '0' && ord x <= ord '9') then True else False

--8)c

isAlpha:: Char-> Bool
isAlpha x = (isUpper x) || (isLowerm x)

--8)d

toUpper:: Char-> Char
toUpper x = if (ord x > ord 'a' && ord x <= ord 'z')
    then chr (ord x - 32)
    else x

--8)e

intToDigit:: Int-> Char
intToDigit a= if (a>=0 && a<=9) then chr a else
 'n'

--8)f

numa:: [Char]-> [Int]
numa [] = []
numa (h:t) = (ord h - 48): numa t 

--Dei o nome de numa por questoes de n confusao com as funçoes predefenidas no ghci





















