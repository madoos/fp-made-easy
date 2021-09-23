module Test.List (
 listSuite
) where
  
import Prelude

import Control.Monad.Free (Free)
import List (List(..), (:), (===), singleton, null)
import Test.Unit (TestF, suite, test)
import Test.Unit.Assert (assert, assertFalse)

listSuite :: Free TestF Unit
listSuite = suite "List" do
    test "List should to be instance of Show" do
      assert "show list return an String" $ show (1:2:3:Nil) == "1:2:3:Nil"
      assert "show list return an String" $ show ("a":Nil) == "\"a\":Nil"
    test "equals" do
      assert "list should to be equals" $ ((1:2:3:Nil) === (1:2:3:Nil)) == true
      assert "list should to be diferents" $ ((2:2:3:Nil) === (1:2:3:Nil)) == false
    test "singleton" do
      assert "singleton should put a into list context" (singleton 1 === (1:Nil))
    test "null" do
      assert "null should return true for empty list" $ null Nil
      assertFalse "null should return false for not empty list" $ null (1:Nil)