module DerivedInstances where

import Prelude

import Data.Array (sort)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Class.Console (logShow)

data SomeType = This | That | TheOther | AndYetAnother

derive instance genericSomeType :: Generic SomeType _
instance showSomeType :: Show SomeType where show = genericShow
derive instance eqSomeType :: Eq SomeType
derive instance ordSomeType :: Ord SomeType


run :: Effect Unit
run = do 
  let xs = [AndYetAnother, That, TheOther, This]
  logShow $ sort xs