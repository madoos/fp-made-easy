module Test.List (
 listSuite
) where
  
import Prelude

import Control.Monad.Free (Free)
import Test.Unit (TestF, suite, test)
import Test.Unit.Assert (assert)

import List(List(..), (:))

listSuite :: Free TestF Unit
listSuite = suite "List" do
    test "List should to be instance of Show" do
      assert "show list return an String" $ show (1:2:3:Nil) == "1:2:3:Nil"
      assert "show list return an String" $ show ("a":Nil) == "\"a\":Nil"