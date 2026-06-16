module Darts (score) where

data Zone = Inner | Middle | Outer | Outside

score :: Float -> Float -> Int
score x y = points . circle $ radius x y

radius :: Float -> Float -> Float
radius x y = sqrt (x*x + y*y)

circle :: Float -> Zone
circle r
  | r <= 1    = Inner
  | r <= 5    = Middle
  | r <= 10   = Outer
  | otherwise = Outside

points :: Zone -> Int
points Inner   = 10
points Middle  = 5
points Outer   = 1
points Outside = 0
