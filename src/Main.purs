module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import List(List(..), (:), index)

main :: Effect Unit
main = do
  log "Run 'spago test' to run implementations"
  log $ show $ (1:2:3:Nil)
  log $ show $ index (1:2:3:Nil) 0
