-- Part 1 Answer: 1638
-- Part 2 Answer: 17

import Data.List (sortBy, sort, group)
import Data.Ord (comparing, Down (Down))

litres :: Int
litres = 150

main :: IO ()
main = do
  input <- readFile "./day_17.input"

  let numbers = sortBy (comparing Down) . map read $ lines input :: [Int]
  let allCombs = combs numbers
  let part1 = length $ combs numbers
  let part2 = length . head . group . sort . map length $ allCombs

  putStrLn $ "Part 1: " ++ show part1
  putStrLn $ "Part 2: " ++ show part2

combs :: [Int] -> [[Int]]
combs = combs' []
  where combs' visited [] = [visited | sum visited == litres]
        combs' visited (x:xs) = combs' (x:visited) xs ++ combs' visited xs 
