-- = ETL
--
-- This module demonstrates the exact \"apples and oranges\" problem we
-- discussed earlier.
--
-- In the original Haskell answer, someone showed @map@'s /implementation/
-- (revealing laziness via the @:@ constructor) but only @sum@'s /application/
-- (@sum [1,2,3,4] = 10@). That mismatch hid the mechanism. You cannot compare
-- a function's guts with another function's skin.
--
-- Here, 'transform' is a __producer__: it builds a list of @(Char, Int)@
-- pairs using the lazy constructor @:@. Because @:@ is a data constructor,
-- the recursive call is suspended in a thunk automatically. Tail recursion
-- is honest here — we are not forcing a strict numeric reduction, we are
-- growing a lazy structure. This is the same reason @map@ handles infinite
-- lists effortlessly.
--
-- Compare this with 'Scrabble', where we reduce a string to a single 'Int'.
-- There we are a __consumer__, and the strict @+@ operator would build a
-- chain of unevaluated thunks unless we force strictness with 'seq'.
--
-- So: apples to apples. Both modules use tail recursion with an accumulator,
-- but only the consumer needs an extra strictness annotation to make the
-- comparison fair across languages.

module ETL (transform) where

import Data.Map (Map, fromList, toList)
import Data.Char (toLower)

transform :: Map Int String -> Map Char Int
transform old = fromList (transformList (toList old) [])

transformList :: [(Int, String)] -> [(Char, Int)] -> [(Char, Int)]
transformList [] acc = acc
transformList ((score, letters) : rest) acc =
    transformList rest (transformLetters letters score acc)

transformLetters :: String -> Int -> [(Char, Int)] -> [(Char, Int)]
transformLetters [] _ acc = acc
transformLetters (letter : rest) score acc =
    transformLetters rest score ((toLower letter, score) : acc)
    