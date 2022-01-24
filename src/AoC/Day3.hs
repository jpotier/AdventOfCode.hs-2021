{-# LANGUAGE OverloadedStrings #-}

module AoC.Day3 where

import           Data.Text (Text)
import           Data.Bits (complement)
-- import           Data.Maybe (catMaybes)
-- import           Text.Read (readMaybe)
import           Debug.Trace
import qualified Data.Text as T
import           Data.Char (digitToInt)
import           Data.List (transpose, sort)
import Data.List (foldl')

toDec :: [Int] -> Int
toDec = foldl' (\acc x -> acc * 2 + x) 0

testInput :: Text
testInput = "00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010"

toInt :: String -> [Int]
toInt = map digitToInt

parseInput :: Text -> [[Int]]
parseInput = fmap toInt . lines . T.unpack

gamma :: [[Int]] -> [Int]
gamma xxs = map (\xs -> xs !! (l `div` 2)) xxst
  where
    l = traceShowId $ length (xxst !! 1)
    xxst = traceShowId $ fmap sort (transpose xxs)

epsilon :: Int -> Int
epsilon = complement

-- {{{ Part 1
part1 :: Text -> Text
part1 _ = T.pack $ show $ result1 $ toDec $ gamma $ parseInput testInput

result1 :: Int -> Int
result1 xs = xs * epsilon xs
-- }}}

-- {{{ Part 2
part2 :: Text -> Text
part2 = const "Day 3 - part 2"
-- }}}
