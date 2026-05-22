-- The \"apples and oranges\" problem, revisited.
--
-- The original claim was that tail recursion is \"generally not needed\" in
-- Haskell because laziness avoids stack growth. But that argument showed
-- @map@ (a __producer__, returning @:@ constructors) while hiding @sum@
-- (a __consumer__, forcing strict @+@). You cannot judge tail recursion
-- relevance by comparing a lazy constructor with a hidden strict reducer.
--
-- 'scoreWord' is a consumer: it collapses a string into a single 'Int'.
-- In Elixir, the accumulator is strictly evaluated at every step. In
-- Haskell, @acc + scoreLetter x@ would be suspended into a thunk. The tail
-- call avoids growing the /call/ stack, but the /evaluation/ stack still
-- grows as a nested chain of additions: @(...((0 + 1) + 1) + ...)@.
--
-- We restore honesty by forcing evaluation with 'seq' at each step:
--
-- > let acc' = acc + scoreLetter x in acc' `seq` scoreWord' xs acc'
--
-- This makes the Haskell implementation structurally equivalent to the
-- Elixir one. Without 'seq', we would be hiding the true cost — the same
-- way the original answer hid @sum@'s implementation behind its application.

module Scrabble (scoreLetter, scoreWord) where

import Data.Char (toLower)

scoreLetter :: Char -> Int
scoreLetter c = case toLower c of
    'a' -> 1
    'b' -> 3
    'c' -> 3
    'd' -> 2
    'e' -> 1
    'f' -> 4
    'g' -> 2
    'h' -> 4
    'i' -> 1
    'j' -> 8
    'k' -> 5
    'l' -> 1
    'm' -> 3
    'n' -> 1
    'o' -> 1
    'p' -> 3
    'q' -> 10
    'r' -> 1
    's' -> 1
    't' -> 1
    'u' -> 1
    'v' -> 4
    'w' -> 4
    'x' -> 8
    'y' -> 4
    'z' -> 10
    _   -> 0

scoreWord :: String -> Int
scoreWord word = scoreWord' word 0

scoreWord' :: String -> Int -> Int
scoreWord' [] acc = acc
scoreWord' (x : xs) acc =
    let acc' = acc + scoreLetter x
    in  acc' `seq` scoreWord' xs acc'
