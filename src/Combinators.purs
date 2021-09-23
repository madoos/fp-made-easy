module Combinators (
    identity,
    flip
) where 

identity :: ∀ a. a -> a
identity a = a

flip :: ∀ a b c. (a -> b -> c) -> b -> a -> c
flip f b a = f a b