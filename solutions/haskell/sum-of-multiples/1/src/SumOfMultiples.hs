module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer

sumOfMultiples factors limit =
  sum $ filter (\n -> any (\f -> f /= 0 && n `mod` f == 0) factors) [1..limit-1]
