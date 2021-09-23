module List (
  List(..),
  (:),
  (===),
  equals,
  singleton,
  null,
  snoc,
  length,
  head,
  tail
) where

import Prelude

import Data.Maybe (Maybe(..))

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

length :: ∀ a. List a -> Int
length = go 0
  where 
   go acc Nil = acc
   go acc (_:xs) = go (acc + 1) xs

head :: ∀ a. List a -> Maybe a
head Nil = Nothing
head (x:_) = Just x

tail :: ∀ a. List a -> Maybe (List a)
tail Nil = Nothing
tail (_:xs) = Just xs