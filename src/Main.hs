{-# LANGUAGE ConstraintKinds, DataKinds, FlexibleContexts, GADTs,
             OverloadedStrings, PatternSynonyms, QuasiQuotes,
             ScopedTypeVariables, TemplateHaskell, TypeOperators,
             ViewPatterns #-}
module Main where

import Frames
import Frames.CSV
import qualified Pipes.Prelude as P
import Pipes hiding (Proxy)

-- reads column names from a 176 column csv with format: Text,Int,Bool,Double,Bool,Int repeated 29.333333333333332 times
tableTypes' rowGen "sample.csv"

rowStream :: Producer Row IO ()
rowStream = readTableOpt rowParser "sample.csv"

main :: IO ()
main = do
  P.length rowStream >>= print
  -- runEffect $ rowStream >-> P.print
