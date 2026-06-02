module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
  | n <= 0    = Nothing
  | otherwise = Just (countSteps n)
  where
    countSteps 1 = 0
    countSteps n
      | even n    = succ (countSteps (quot n 2))
      | otherwise = succ (countSteps (3 * n + 1))
