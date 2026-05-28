module Isogram (isIsogram) where

import Data.List (nubBy)
import Data.Char (isAlpha, toLower)

isIsogram :: String -> Bool
isIsogram phrase = nubBy equalLetters phrase == phrase
  where
    equalLetters c1 c2 = isAlpha c1 &&
      toLower c1 == toLower c2
