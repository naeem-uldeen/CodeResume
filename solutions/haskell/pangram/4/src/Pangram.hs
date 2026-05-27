module Pangram (isPangram) where

import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text = all (`elem` lowerText) ['a'..'z']
  where lowerText = map toLower text
  