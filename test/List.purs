module Test.List (
 listSuite
) where
  
import Prelude

import Control.Monad.Free (Free)
import Data.Maybe (Maybe(..), fromMaybe)
import List (List(..), (:), (===), singleton, null, snoc, length, head, tail)
import Test.Unit (TestF, suite, test)
import Test.Unit.Assert (assert, assertFalse, equal)

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
    
    test "snoc" do
      assert "snoc should put item in the las of list" (snoc (1:Nil) 2 === (1:2:Nil))

    test "length" do
      equal 3 $ length (1:2:3:Nil)
    
    test "head" do
      equal (Just 1) $ head (1:2:3:Nil)
      equal Nothing $ (head Nil :: Maybe Unit) 
    
    test "tail" do
      assert "should return the tail of list" $ ((fromMaybe Nil (tail (1:2:3:Nil))) === (2:3:Nil))