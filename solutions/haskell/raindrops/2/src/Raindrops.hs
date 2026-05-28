module Raindrops (convert) where

sounds :: [(Int, String)]
sounds = [(3, "Pling"), (5, "Plang"), (7, "Plong")]

convert :: Int -> String
convert n
  | null result = show n
  | otherwise   = result
  where
    result = concatMap (check n) sounds

check :: Int -> (Int, String) -> String
check n (divisor, sound)
  | n `mod` divisor == 0 = sound
  | otherwise            = ""
