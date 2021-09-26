module Ch6.Typeclasses (
  Direction,
  Address,
  getDirection,
  run
) where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Class.Console (logShow)

type Address = { 
  street :: String, 
  city :: String, 
  state :: String, 
  zip :: String
}

newtype Direction = Direction String
derive newtype instance eqDirection :: Eq Direction
derive newtype instance showDirection :: Show Direction

data Person = Person { name :: String, age :: Int, adress :: Address }
derive instance genericPerson :: Generic Person _
instance showPerson :: Show Person where show = genericShow
derive instance eqPerson :: Eq Person

data Company = Company { name :: String, adress :: Address }
derive instance genericCompany :: Generic Company _
instance showCompany :: Show Company where show = genericShow
derive instance eqCompany :: Eq Company

data Residence = Home Address | Facility Address
derive instance genericResidence :: Generic Residence _
instance showResidence :: Show Residence where show = genericShow
derive instance eqResidence :: Eq Residence

getDirection :: Address -> Direction
getDirection { street, city, state, zip } = Direction (street <> ", " <> city <> ", " <> state <> ", " <> zip)

run :: Effect Unit
run = do
  let direction = Direction "Av Embajadores, Los Llanos, Madrid, 28001" 
  logShow direction
  logShow $ direction == direction

  let home = { 
    street: "Sol", 
    city: "Madrid", 
    state: "Madrid", 
    zip: "28001"
  }

  let person = Person { name: "Maurice", age: 32, adress: home }
  logShow person
  logShow $ person == person

  let company = Company { name: "crazzy Dog", adress: home }
  logShow company
  logShow $ company == company

  let homeResidence = Home home
  logShow homeResidence
  logShow $ homeResidence == homeResidence

  logShow $ getDirection home
