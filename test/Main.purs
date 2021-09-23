module Test.Main where

import Prelude

import Test.Combinators(combinatorsSuite)

import Effect (Effect)
import Test.Unit.Main (runTest)

main :: Effect Unit
main = runTest do
  combinatorsSuite