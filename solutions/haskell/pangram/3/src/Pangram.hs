module Pangram (isPangram) where

import Data.Char (toLower)
import Data.List (nub, (\\))

isPangram :: String -> Bool
isPangram text =
  let alphabet = ['a'..'z']
      lettersUsed = nub [toLower c | c <- text, c `elem` ['A'..'Z'] ++ ['a'..'z']]
  in null (alphabet \\ lettersUsed)
  