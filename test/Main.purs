module Test.Main where

import Prelude

import Effect (Effect)
import Test.Unit (suite, test)
import Test.Unit.Assert(assert)
import Test.Unit.Main (runTest)

main :: Effect Unit
main = runTest do
  suite "Example Suite" do
    test "arithmetic" do
      assert "2 + 2 should be 4" $ (2 + 2) == 4