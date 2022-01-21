module Main where

import qualified AoC.Day1  as Day1
import qualified Data.Text as T

main :: IO ()
main = do
  input1 <- readFile "inputs/day1"
  putStrLn $ T.unpack $ Day1.output (T.pack input1)
