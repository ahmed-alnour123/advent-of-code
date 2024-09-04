import GHC.Float (roundFloat, ceilingFloat)
import Data.List (findIndex)
import qualified Data.Set as Set (fromList, toList)
import qualified Data.IntMap as Map (fromList, toList, insert, lookup, member, empty, traverseWithKey)
import Data.Set (Set)
import Data.IntMap (IntMap)
import Data.Maybe (fromJust)


input = 36_000_000
limit = 50
-- limit = 1

main = do
  let fs = map factors [1..input]
  print $ count' fs
  -- print $ count 0 fs Map.empty

count' ls = count 1 ls Map.empty
-- count :: Int -> [[Int]] -> IntMap Int -> Int

-- count i [] acc = Map.empty
-- count i [] acc = Map.toList acc
count i [] acc = 0
count i (x:xs) acc = do
  let addAcc = addList acc x
  let s = summ addAcc x * 11
  -- count (i + 1) xs addAcc
  if s >= input
    then i
    else count (i + 1) xs addAcc

summ :: IntMap Int -> [Int] -> Int
summ m = foldr (\ x -> (+) (if fromJust (Map.lookup x m) > limit then 0 else x)) 0

factors :: Int -> [Int]
factors n = Set.toList . Set.fromList $ concat [[x, n `div` x] | x <- filter ((== 0) . (n `mod`)) [1..(isqrt $ fromIntegral n)]]

isqrt :: Float -> Int
isqrt n = ceilingFloat $ sqrt n

addList :: IntMap Int -> [Int] -> IntMap Int
addList = foldl addNum

addNum :: IntMap Int -> Int -> IntMap Int
addNum m n = Map.insert n val m
  where
  val = case Map.lookup n m of
      Just n  -> n + 1
      Nothing -> 1
