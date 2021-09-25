module Test.List (
 listSuite
) where
  
import Prelude

import Control.Monad.Free (Free)
import Data.Maybe (Maybe(..), fromMaybe)
import List (List(..), findIndex, head, index, init, last, length, null, singleton, snoc, tail, (!!), (:), (===), findLastIndex, reverse, concat, filter, catMaybes, range, take, take', drop, takeWhile)
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
    
    test "last" do
      equal (last (1:2:3:Nil)) (Just 3)
      equal (last Nil :: Maybe Unit) Nothing
    
    test "init" do
      assert "should get init of list" $ ((fromMaybe Nil (init (1:2:3:Nil))) === (1:2:Nil))
    
    test "index" do
      equal (index (1:2:3:Nil) 0) (Just 1)
      equal (index (1:2:3:Nil) 10) (Nothing)
      equal (index (1:2:3:Nil) (-12)) (Nothing)
    
    test "index as !!" do
      equal ((1:2:3:Nil)!!0) (Just 1)
      equal ((1:2:3:Nil)!!10) (Nothing)
      equal ((1:2:3:Nil)!!(-12)) (Nothing)

    test "finIndex" do
      equal (findIndex (_==3) (1:2:3:Nil)) (Just 2)
      equal (findIndex (_==3) (1:2:Nil)) (Nothing)
      equal (findIndex (_==3) Nil) (Nothing)
    
    test "findLastIndex" do
      equal (findLastIndex (_==3) (3:3:3:Nil)) (Just 2)
      equal (findLastIndex (_==10) (10:10:3:Nil)) (Just 1)
      equal (findLastIndex (_==10) (1:2:3:Nil)) (Nothing)
    
    test "reverse" do
      assert "should reverse the list" ((reverse (1:2:3:Nil)) === (3:2:1:Nil))
    
    test "concat" do
      assert "should concat list of lists" ((concat ((1:2:Nil):(3:4:Nil):Nil)) ===  (1:2:3:4:Nil) )
    
    test "filter" do
      assert "should filter items" ((filter (_ >= 4) (1:2:3:4:5:Nil)) === (4:5:Nil))
    
    test "catMaybies" do
      assert "catMaybes should remove Nothing and unwrap Just" (catMaybes ((Just 1):(Nothing):(Just 2):Nil) === (1:2:Nil)) 
    
    test "range" do
      assert "range" ((range 1 3) ===  (1:2:3:Nil))
    
    test "take" do
      assert "take should take n items" ( (take 3 (1:2:3:4:5:Nil)) === (1:2:3:Nil) )
      assert "take should take n items" ( (take 3 (Nil :: List Unit)) === (Nil :: List Unit) )
   
    test "take'" do
      assert "take' should take' n items" ( (take' 3 (1:2:3:4:5:Nil)) === (1:2:3:Nil) )
      assert "take' should take' n items" ( (take' 3 (Nil :: List Unit)) === (Nil :: List Unit) )

    test "drop'" do
      assert "drop' should remove' n items" ( (drop 4 (1:2:3:4:5:Nil)) === (5:Nil) )
      assert "drop' should remove' n items" ( (drop 3 (Nil :: List Unit)) === (Nil :: List Unit) )
    
    test "takeWhile" do
      assert "takeWhile" $ (takeWhile (_==1) (1:2:3:Nil) === (1:Nil))
      assert "takeWhile" $ (takeWhile (_==1) Nil === Nil)
