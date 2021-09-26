module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Ch6.Typeclasses as Typeclasses

main :: Effect Unit
main = do
  log "Run 'spago test' to run implementations"
  Typeclasses.run