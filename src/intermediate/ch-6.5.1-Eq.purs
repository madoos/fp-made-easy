module Eq (run) where

import Effect (Effect)
import Effect.Class.Console (logShow)
import Prelude (Ordering(..), Unit, discard, (==), (||))

class Eq a where
 eq :: a -> a -> Boolean
 compare :: a -> a -> Ordering

infix 4 eq as ===

data Option = Some | None
instance eqOption :: Eq Option where
 eq = eq'
 compare = compare'

eq' :: Option -> Option -> Boolean
eq' Some Some = true
eq' None None = true
eq' _ _ = false

compare' :: Option -> Option -> Ordering
compare' a b | eq' a b = EQ
compare' Some _ = GT
compare' None _ = LT

-- Operators

createOrEqComparator :: ∀ a. Eq a => (a -> a -> Boolean) -> a -> a -> Boolean 
createOrEqComparator comparator a b = (comparator a b) || eq a b

lt :: forall a. Eq a => a -> a -> Boolean
lt a b = (compare a b) == LT
infix 4 lt as <

lte :: forall a. Eq a => a -> a -> Boolean
lte = createOrEqComparator lt
infix 4 lte as <=

gt a b = (compare a b) == GT
infix 4 gt as >

gte :: forall a. Eq a => a -> a -> Boolean
gte = createOrEqComparator gt
infix 4 gt as >=


run :: Effect Unit
run = do
  logShow "Running Eq typeclass implementation"
  logShow (Some === None)
  logShow (Some === Some)
  logShow (Some < None)
  logShow (Some <= None)
  logShow (Some > None)
  logShow (Some >= None)
