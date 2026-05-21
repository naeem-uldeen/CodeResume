module Accumulate (accumulate) where

-- accumulate takes a function (a -> b) and a list of a’s,
-- and returns a new list of b’s after applying the function to each element.
accumulate :: (a -> b) -> [a] -> [b]

-- If the list is empty, there’s nothing to apply the function to.
accumulate _ [] = []

-- Apply f to the head, then recurse on the tail.
accumulate f (x:xs) = f x : accumulate f xs
