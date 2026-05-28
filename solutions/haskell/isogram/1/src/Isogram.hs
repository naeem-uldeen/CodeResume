module Isogram (isIsogram) where
import Data.List (nubBy)
import Data.Char (isAlpha, toLower)

isIsogram :: String -> Bool
isIsogram cs = (length $ nubBy isEqualAlpha cs) == length cs

isEqualAlpha :: Char -> Char -> Bool
isEqualAlpha x y
  | isAlpha x && isAlpha y = toLower x == toLower y
  | otherwise = False
