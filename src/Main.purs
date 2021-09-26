module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Ch6.Typeclasses as Typeclasses
import Eq as Eq
import Place as Place
import DerivedInstances as DI
import DeriveNewtype as DN

main :: Effect Unit
main = do
  log "Run 'spago test' to run implementations"
  Typeclasses.run
  Eq.run
  Place.run
  DI.run
  DN.run
