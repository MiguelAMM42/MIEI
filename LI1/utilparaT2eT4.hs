import Data.Fixed ---para fazer o modulo sobre doubles


data Angulo = Graus Double | Radianos Double
   --deriving (Show,Eq,Ord) --uma forma de resolver o problema de angulos em radianos e graus na T2 e T4


grausParaRadianos :: Double -> Double
grausParaRadianos graus = graus*180 / pi 

radianosParaGraus :: Double -> Double
radianosParaGraus rads = rads*pi/180 

--0..360
normalizaGraus :: Double -> Doublr
normalizaGraus graus = mod' (360 + mod' graus 360)360 


instance Eq Angulo where
  x == y = anguloEq x y

anguloEq :: Angulo -> Angulo -> Bool
anguloEq (Graus x) (Graus y) = normalizaGraus x == normalizaGraus y
anguloEq (Radianos x) y = anguloEq ( Graus (radianosParaGraus x)) y
anguloEq x (Radianos y) = anguloEq x (Graus (radianosParaGraus y))


instance Show Angulo where
  show = anguloShow

anguloShow :: Angulo -> String
anguloShow (Graus graus) = show (normalizaGraus graus)
anguloShow (Radianos rads) = anguloShow (Graus (radianosParaGraus rads))

instance Ord Angulo where
   compare = anguloOrd

anguloOrd :: Angulo -> Angulo -> Ordering
anguloOrd (Graus x) (Graus y) = compare (normalizaGraus x) (normalizaGraus y)
anguloOrd (Radianos  x) y = anguloOrd (Graus (radianosParaGraus x)) y 
anguloOrd x (Radianos y) = anguloOrd x (Graus (radianosParaGraus y))

instance Num Angulo where

instance Fractional Angulo where
   fromRational r = Graus (fromRational r)
   (Graus x) / (Graus y) = Graus (x / y)
   (Radianos x) / y = (Graus (radianosParaGraus x)) / y
   x / (Radianos y) = x / (Graus (radianosParaGraus y))

instance  Floating Angulo where
   pi = Radianos pi
   sin = (Radianos  rads) = Graus $ sin rads
   sin (Graus graus ) = Graus $ sin (grausParaRadianos graus)

 --o cifrão significa um parenteses desde o inicio donde ele está até ao fim da linha



















