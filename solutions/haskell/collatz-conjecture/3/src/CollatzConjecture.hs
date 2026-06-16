module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n <= 0    = Nothing
  | otherwise = Just (countSteps n)

countSteps :: Integer -> Integer
countSteps n = go n 0

go :: Integer -> Integer -> Integer
go 1 acc = acc
go n acc
  | even n    = go (quot n 2) (succ acc)
  | otherwise = go (3 * n + 1) (succ acc)
