module Main where

import           Exercises

-- | Play with the main method to see the different behaviors `parent` and
-- `tidyParent`.
main :: IO ()
main = do
  --parent
  --tidyParent
  xs <- listsLengths2 (replicate 5000 "!")
  putStrLn $ show (length xs)

