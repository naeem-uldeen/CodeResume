-- foldl' forces the accumulator at each step, avoiding ₐᵢ
-- the chain of unevaluated thunks that plain foldl would ₐᵢ
-- build up on a long string. (the proper tool rather than manual seq) ₐᵢ
module Scrabble (scoreLetter, scoreWord) where

import Data.Char (toLower)
import Data.List (foldl')

scoreLetter :: Char -> Int
scoreLetter c = case toLower c of
    'a' -> 1; 'b' -> 3; 'c' -> 3; 'd' -> 2; 'e' -> 1
    'f' -> 4; 'g' -> 2; 'h' -> 4; 'i' -> 1; 'j' -> 8
    'k' -> 5; 'l' -> 1; 'm' -> 3; 'n' -> 1; 'o' -> 1
    'p' -> 3; 'q' -> 10; 'r' -> 1; 's' -> 1; 't' -> 1
    'u' -> 1; 'v' -> 4;  'w' -> 4; 'x' -> 8; 'y' -> 4
    'z' -> 10; _ -> 0


scoreWord :: String -> Int
--  score the char, then partially apply (+) to that score ₐᵢ
--  flip so the accumulator comes first, matching what foldl expects ₐᵢ
scoreWord = foldl' (flip ((+) . scoreLetter)) 0 -- ₐᵢ
