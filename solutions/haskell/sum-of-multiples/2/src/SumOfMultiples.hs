module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit =
  sum $ filter ((`any` validFactors) . divides) [1..limit-1]
  where
    validFactors = filter (/= 0) factors
    divides n f  = n `mod` f == 0
