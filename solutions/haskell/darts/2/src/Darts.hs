module Darts (score) where

score :: Float -> Float -> Int
score x y
  | dist2 > 100 = 0
  | dist2 > 25  = 1
  | dist2 > 1   = 5
  | otherwise   = 10
  where
    dist2 = x*x + y*y
