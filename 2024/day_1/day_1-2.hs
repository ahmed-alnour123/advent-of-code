import Data.List (nub, sort)

main = do
  content <- readFile "./day_1.input"
  let inputData = map (map read . words) $ lines content :: [[Int]]
  let ls1 = nub (map head inputData)
  let ls2 = map last inputData
  let summ = getSum ls1 ls2
  print summ

getSum :: [Int] -> [Int] -> Int
getSum [] _ = 0
getSum (x : xs) ls = (count x ls * x) + getSum xs ls
  where
    count n lst = length $ filter (n ==) lst
