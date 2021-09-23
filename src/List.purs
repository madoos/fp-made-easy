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
  tail,
  last,
  init,
  unconst,
  index
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

last :: ∀ a. List a -> Maybe a
last Nil = Nothing
last (x:xs) = if length xs == 0 
              then Just x 
              else last xs

init :: ∀ a. List a -> Maybe (List a)
init Nil = Nothing
init xs = Just (init' xs) 
  where 
   init' Nil = Nil
   init' (_:Nil) = Nil
   init' (y:ys) = y: init' ys

unconst :: ∀ a. List a -> Maybe { head :: a, list :: List a }
unconst Nil = Nothing
unconst (x:xs) = Just { head: x, list: xs}

index :: ∀ a. List a -> Int -> Maybe a
index list i = go 0 i list
  where 
    go :: ∀ a. Int -> Int -> List a -> Maybe a
    go _ _ Nil = Nothing
    go _ expectedIndex _ | expectedIndex < 0 = Nothing 
    go currentIndex expectedIndex (x:xs) = if currentIndex == expectedIndex 
                                           then Just x
                                           else go (currentIndex + 1) expectedIndex xs
          