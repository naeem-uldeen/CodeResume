module Pangram (isPangram) where

import Data.Char (toUpper)

isPangram :: String -> Bool
isPangram text =
  let in_text c = c `elem` text || toUpper c `elem` text
  in all in_text ['a'..'z']