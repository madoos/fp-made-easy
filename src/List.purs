module List (
  List(..),
  (:)
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


