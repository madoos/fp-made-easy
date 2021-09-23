module Test.Combinators (combinatorsSuite) where

import Prelude

import Combinators as C
import Control.Monad.Free (Free)
import Test.Unit (TestF, suite, test)
import Test.Unit.Assert (assert)

combinatorsSuite :: Free TestF Unit
combinatorsSuite = suite "Example Suite" do
    test "identity" do
      assert "identitiy should return te same input" $ (C.identity 1) == 1
      assert "identitiy should return te same input" $ (C.identity "a") == "a"
    
    test "flip" do
      assert "flip should call function with args in fliped order" $ C.flip (<>) "Hello" "world " == "world Hello"
    
    test "const" do
      assert "const should return constant value" $ C.const 1 2 == 1
    
    test "apply" do
      assert "apply should apply a function" $ C.apply (_ + 1) 1 == 2
    
    test "apply infixr as $" do
      assert "$ should apply a function as infix rigth asociative" $ ((_ * 2) C.$ 2) == 4
    
    test "flipedApply" do
      assert "flipedApply should apply a function fliped" $ C.flipedApply 3 (_ * 3) == 9
    
    test "flipedApply infixl as #" do
      assert "# should apply a function as infix left asociative" $ (2 C.# (_ * 2)) == 4


