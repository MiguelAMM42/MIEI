import Data.List
import System.Random



f:: Int -> Int
f x = x * 2


main::IO Int
main = do 
  str <- getLine
  let x2 = f (read str)
  return x2

main2 :: Int -> IO ()
main2 x = print x

main3 :: IO ()
main3 = do
  str <- readFile "ficha9_res.hs"
  putStrLn str

main4 :: String -> IO ()
main4 filename = do
   str <- readFile filename
   putStrLn str 


main5 :: IO ()
main5 = do
  str <- readFile "palavras.txt"
  let xs = lines str
  let ys = sort xs
  let str'  = unlines ys
  writeFile "palavras2.txt" str' 


printInt :: Int ->IO ()
printInt i = print i


--1a)
bingo :: IO ()
bingo = bingo' [1..90]

bingo' :: [Int] -> IO ()
bingo' [] = return ()
bingo' nums = do
   print nums
   getLine 
   i <- randomRIO (0, length nums -1)
   let num = nums !! i
   printInt num
   bingo' (delete num nums)


--1b)
mastermind :: IO ()
mastermind = do 
   let (x,y,z,w) = (randomRIO [0..9],randomRIO [0..9],randomRIO [0..9],randomRIO [0..9])
   putStrLn "Escreva 4 números na forma (x,y,z,w) na ordem em que considera estarem certos"
   (x',y',z',w') <- getLine
   let x'' = read "" :: Intege
   let str = rightnumber x (read x')
   let str1 = rightnumber y (read y')
   let str2 = rightnumber z (read z')
   let str3 = rightnumber w (read w')
   let completo = "(" ++ (rightnumber x x') ++ "," (rightnumber y y') ++ "," ++ (rightnumber z z') ++ "," ++ (rightnumber w w') ++ ")"
   putStrLn completo



rightnumber :: Int -> Int -> String
rightnumber x x' | x == x' = "CERTO"
                 | x < x' = "ALTO"
                 | x > x' = "BAIXO"




