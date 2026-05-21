module Accumulate (accumulate) where
-- point-free version
-- map already has the exact type (a -> b) -> [a] -> [b],
-- so accumulate can simply reuse it.
accumulate :: (a -> b) -> [a] -> [b]
accumulate = map
