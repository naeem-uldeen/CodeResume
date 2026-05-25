module Raindrops (convert) where

convert :: Int -> String
convert n
  | 3 `divides` n && 5 `divides` n && 7 `divides` n = "PlingPlangPlong"
  | 3 `divides` n && 7 `divides` n = "PlingPlong"
  | 3 `divides` n && 5 `divides` n = "PlingPlang"
  | 5 `divides` n && 7 `divides` n = "PlangPlong"
  | 3 `divides` n = "Pling"
  | 5 `divides` n = "Plang"
  | 7 `divides` n = "Plong"
  | otherwise = show n
  
divides :: Int -> Int -> Bool
divides m n = mod n m == 0
