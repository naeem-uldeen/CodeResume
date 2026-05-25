module ReverseString (reverseString) where

reverseString :: String -> String
reverseString [] = []   
reverseString (x:xs) = reverseString xs ++ [x] 
