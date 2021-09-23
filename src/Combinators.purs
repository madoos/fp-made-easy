module Combinators (
    identity,
    flip,
    const
) where 

identity :: ∀ a. a -> a
identity a = a

flip :: ∀ a b c. (a -> b -> c) -> b -> a -> c
flip f b a = f a b

const :: ∀ a b. a -> b -> a
const a _ = a