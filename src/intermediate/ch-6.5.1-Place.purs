module Place (run) where

import Prelude

import Data.Array (sort)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Class.Console (logShow)

data Place = First | Second | Thirt

derive instance genericPlace :: Generic Place _
instance showPlace :: Show Place where show = genericShow

instance eqPlace :: Eq Place where 
  eq First First = true
  eq Second Second = true
  eq Thirt Thirt = true
  eq _ _ = false

instance ordPlace ::  Ord Place where
 compare First First = EQ
 compare Second Second = EQ
 compare Thirt Thirt = EQ
 compare First Second = LT
 compare Second First = GT
 compare First Thirt = LT
 compare Thirt First = GT
 compare Second Thirt = LT
 compare Thirt Second = GT

run :: Effect Unit
run = do
  let xs = [Thirt, Second, First]
  logShow $ sort xs