module DeriveNewtype where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Class.Console (logShow)

newtype FirstName = FirstName String
newtype LastName = LastName String

derive instance genericFirstName :: Generic FirstName _
instance showTypeFirstName :: Show FirstName where show = genericShow


run :: Effect Unit
run = do
  logShow $ FirstName "hello" 