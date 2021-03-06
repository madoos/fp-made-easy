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
  index,
  (!!),
  findIndex,
  findLastIndex,
  reverse,
  concat,
  filter,
  catMaybes,
  range,
  take,
  take',
  drop,
  takeWhile,
  dropWhile,
  takeEnd,
  dropEnd,
  zip,
  unzip
) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..), fst, snd)

data List a = Head a (List a) | Nil
infixr 0 Head as :

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
infixl 8 index as !!

findIndex :: ∀ a. (a -> Boolean) -> List a -> Maybe Int
findIndex = findIndex' 0
  where
    findIndex' _ _ Nil = Nothing
    findIndex' i p (x:xs) = if p x then Just i else findIndex' (i + 1) p xs
  
findLastIndex :: ∀ a. (a -> Boolean) -> List a -> Maybe Int
findLastIndex = findLastIndex' 0 (-1)
  where 
    findLastIndex' _ (-1) _ Nil = Nothing
    findLastIndex' _ lastFindedIndex _ Nil = Just lastFindedIndex
    findLastIndex' currentIndex lastFindedIndex p (x:xs) = if p x 
                                                           then findLastIndex' (currentIndex + 1) currentIndex p xs
                                                           else findLastIndex' (currentIndex + 1) lastFindedIndex p xs
reverse :: List ~> List 
reverse Nil = Nil
reverse ol = go Nil ol 
  where
   go rl Nil = rl
   go rl (x : xs) = go (x : rl) xs  

concat :: ∀ a. List (List a) -> List a
concat Nil = Nil
concat (Nil:xs) = concat xs
concat ((x:xs):xss) = x: concat (xs:xss)

filter :: ∀ a. (a -> Boolean) -> List a -> List a
filter _ Nil = Nil
filter p (x:xs) = if p x then x: filter p xs else filter p xs

catMaybes :: ∀ a. List (Maybe a) -> List a
catMaybes Nil = Nil
catMaybes (x:xs) = case x of
                    Just a -> (a: catMaybes xs)
                    Nothing -> catMaybes xs

range :: Int -> Int -> List Int
range start end | start == end = singleton start
                | otherwise = start : range (start+1) end

take :: ∀ a. Int -> List a -> List a
take n = go Nil n >>> reverse
  where 
    go listToTake 0 _ = listToTake
    go listToTake _ Nil = listToTake
    go listToTake n' (x:xs) = go (x:listToTake) (n' - 1) xs

take' :: ∀ a. Int -> List a -> List a
take' _ Nil = Nil
take' 0 list = list
take' n (x:xs) = x: take (n-1) xs

drop :: ∀ a. Int -> List a -> List a
drop _ Nil = Nil
drop 0 list = list
drop n (_:xs) = drop (n - 1) xs

takeWhile :: ∀ a. (a -> Boolean) -> List a -> List a
takeWhile _ Nil = Nil
takeWhile p (x:xs) = if p x then x: (takeWhile p xs) else Nil

dropWhile :: ∀ a. (a -> Boolean) -> List a -> List a
dropWhile _ Nil = Nil
dropWhile p list@(x:xs) = if p x then dropWhile p xs else list

takeEnd :: ∀ a. Int -> List a -> List a
takeEnd n = reverse >>> take n >>> reverse

dropEnd :: ∀ a. Int -> List a -> List a
dropEnd n = reverse >>> drop n >>> reverse

zip :: ∀ a b. List a -> List b -> List (Tuple a b)
zip Nil _ = Nil
zip _ Nil = Nil
zip (x:xs) (y:ys) = (Tuple x y): zip xs ys

unzip :: ∀ a b. List (Tuple a b) -> Tuple (List a) (List b)
unzip Nil = Tuple Nil Nil
unzip list = (Tuple (allFst list) (allSnd list))
  where 
    allFst :: List (Tuple a b) -> List a 
    allFst Nil = Nil
    allFst (x:xs) = fst x: allFst xs
    allSnd :: List (Tuple a b) -> List b 
    allSnd Nil = Nil
    allSnd (x:xs) = snd x: allSnd xs
    allWith f (x:xs) = f x: allWith f xs
    allWith _ Nil = Nil

instance showList :: Show a => Show (List a) where
    show (x:xs) = (show x) <> ":" <> (show xs)
    show Nil = "Nil"

instance eqList :: Eq a => Eq (List a) where
  eq = equals