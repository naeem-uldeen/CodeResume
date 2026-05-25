module Pangram (isPangram) where

import Data.Char (toLower, isAsciiLower, isAsciiUpper)

isPangram :: String -> Bool
isPangram phrase = all (`elem` letters) ['a'..'z']
  where
    letters = map toLower [c | c <- phrase, isAsciiLetter c]
    isAsciiLetter c = isAsciiLower c || isAsciiUpper c
