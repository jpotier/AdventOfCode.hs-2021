{-# LANGUAGE OverloadedStrings #-}

module AoC.Day1 where

import           Data.Text (Text)
import           Data.Maybe (catMaybes)
import           Text.Read (readMaybe)
import qualified Data.Text as T

output :: Text -> Text
output = T.pack . show . countGT . compare2 . rollingAverage3 . parse

countGT :: [Ordering] -> Int
countGT = length . filter (== GT)

compare2 :: [Int] -> [Ordering]
compare2 xs = fmap (\(a,b) -> compare b a) $ zip xs1 xs2
  where
    xs1 = xs
    xs2 = tail xs

rollingAverage3 :: [Int] -> [Int]
rollingAverage3 xs = fmap (\(a,b,c) -> a+b+c) $ zip3 xs1 xs2 xs3
  where
    xs1 = xs
    xs2 = tail xs
    xs3 = tail $ tail $ xs

parse :: Text -> [Int]
parse txt = catMaybes
  $ fmap ((readMaybe :: String -> Maybe Int) . T.unpack)
  $ T.lines . T.strip
  $ txt

testInput :: Text
testInput = "199\n200\n208\n210\n200\n207\n240\n269\n260\n263\n"
