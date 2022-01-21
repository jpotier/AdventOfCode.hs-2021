module Main where

import qualified AoC.Day1  as Day1
import qualified AoC.Day2  as Day2
import qualified Data.Text as T

main :: IO ()
main = do
  input1 <- readFile "inputs/day1"
  putStrLn $ T.unpack $ Day1.output (T.pack input1)
  input2 <- readFile "inputs/day2"
  putStrLn $ T.unpack $ Day2.part1 (T.pack input2)
  putStrLn $ T.unpack $ Day2.part2 (T.pack input2)
