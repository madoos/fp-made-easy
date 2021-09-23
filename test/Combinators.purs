module Test.Combinators (combinatorsSuite) where

import Prelude

import Control.Monad.Free (Free)
import Test.Unit (TestF, suite, test)
import Test.Unit.Assert (assert)
import Combinators as C

combinatorsSuite :: Free TestF Unit
combinatorsSuite = suite "Example Suite" do
    test "identity" do
      assert "Identitiy should return te same input" $ (C.identity 1) == 1
      assert "Identitiy should return te same input" $ (C.identity "a") == "a"
