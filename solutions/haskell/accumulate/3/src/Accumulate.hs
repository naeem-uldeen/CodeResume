module Accumulate (accumulate) where

-- Apply a -> b to every element of [a], producing [b].
-- map takes the function f and applies it to each element of the list.
accumulate :: (a -> b) -> [a] -> [b]
accumulate f xs = map f xs
