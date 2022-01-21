{-# LANGUAGE OverloadedStrings #-}

module AoC.Day2 where

import           Data.Text (Text)
import           Data.Maybe (catMaybes)
import           Text.Read (readMaybe)
-- import           Debug.Trace
import qualified Data.Text as T

-- {{{ Part 1
part1 :: Text -> Text
part1 = T.pack . show . result1 . walk . parse

data Position = Position
  { depth      :: Int
  , horizontal :: Int
  }
  deriving Show

result1 :: Position -> Int
result1 (Position d h) = d * h

walk :: Ops -> Position
walk ops = foldr step pos0 ops

step :: Op -> Position -> Position
step (OpForward n) (Position d h) = Position d (h+n)
step (OpDown n)    (Position d h) = Position (d+n) h
step (OpUp n)      (Position d h) = Position (d-n) h

pos0 :: Position
pos0 = Position 0 0

data Op = OpForward  Int
        | OpDown     Int
        | OpUp       Int
  deriving (Show)

type Ops = [ Op ]

parse :: Text -> Ops
parse txt = catMaybes $ fmap toOps $ T.lines txt
  where
    toOps :: Text -> Maybe Op
    toOps = toOps' . T.words

    toOps' :: [Text] -> Maybe Op
    toOps' ("forward":n:[]) = Just . OpForward =<< readMaybe (T.unpack n)
    toOps' ("down":n:[]) = Just . OpDown =<< readMaybe (T.unpack n)
    toOps' ("up":n:[]) = Just . OpUp =<< readMaybe (T.unpack n)
    toOps' _ = Nothing

testInput1 :: Text
testInput1 = "forward 5\ndown 5\nforward 8\nup 3\ndown 8\nforward 2\n"
-- }}}


-- {{{ Part 2
part2 :: Text -> Text
part2 = T.pack . show . result2 . walk2 . parse

data Position2 = Position2
  { depth2      :: Int
  , horizontal2 :: Int
  , aim         :: Int
  }
  deriving Show

result2 :: Position2 -> Int
result2 (Position2 d h _a) = d * h

walk2 :: Ops -> Position2
walk2 ops = foldr step2 pos0' (reverse ops)

pos0' :: Position2
pos0' = Position2 0 0 0

step2 :: Op -> Position2 -> Position2
step2 (OpForward n) (Position2 d h a) = Position2 (d+a*n) (h+n)  a
step2 (OpDown n)    (Position2 d h a) = Position2  d       h    (a+n)
step2 (OpUp n)      (Position2 d h a) = Position2  d       h    (a-n)
-- }}}
