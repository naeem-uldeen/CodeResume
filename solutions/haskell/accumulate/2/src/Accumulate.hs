module Accumulate (accumulate) where

-- accumulate takes a function (a -> b) and a list of a’s,
-- and returns a new list of b’s after applying the function to each element.
accumulate :: (a -> b) -> [a] -> [b]

-- Use foldr to rebuild the list, applying f to each element (x)
-- and cons it onto the accumulated result.
--   \      starts the anonymous function
--   x acc  are the parameters
--   f x : acc  is the result expression
accumulate f = foldr (\x acc -> f x : acc) []
