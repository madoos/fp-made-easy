module List (
  List(..),
  (:),
  (===),
  equals,
  singleton,
  null,
  snoc
) where

import Prelude

data List a = Head a (List a) | Nil
infixr 0 Head as :

instance showList :: Show a => Show (List a) where
  show = show'
   where
    show' :: ∀ a. (Show a) => List a -> String
    show' (x:xs) = (show x) <> ":" <> (show' xs)
    show' Nil = "Nil"

equals :: forall a. Eq a => List a -> List a -> Boolean
equals Nil Nil = true
equals _ Nil = false
equals Nil _ = false
equals (x:xs) (y:ys) = if x == y then equals xs ys else false
infix 0 equals as ===

singleton :: ∀ a. a -> List a
singleton a = a:Nil

null :: ∀ a. List a -> Boolean
null Nil = true
null _ = false

snoc :: ∀ a. List a -> a -> List a
snoc Nil a = singleton a
snoc (x:xs) a = x: snoc xs a