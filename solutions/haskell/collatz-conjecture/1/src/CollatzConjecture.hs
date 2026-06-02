module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n <= 0    = Nothing
  | otherwise = Just (countSteps n)

countSteps :: Integer -> Integer
countSteps 1 = 0
countSteps n
  | even n    = 1 + countSteps (div n 2)
  | otherwise = 1 + countSteps (3 * n + 1)
