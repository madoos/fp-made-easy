module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import List (List(..), index, take, takeWhile, (:), (===))

main :: Effect Unit
main = do
  log "Run 'spago test' to run implementations"
  log $ show $ (1:2:3:Nil)
  log $ show $ index (1:2:3:Nil) 0
  log $ show $ take 20 (1:2:3:4:Nil)
  log $ show ((takeWhile (_==5) (1:5:4:Nil)) === (5:Nil))