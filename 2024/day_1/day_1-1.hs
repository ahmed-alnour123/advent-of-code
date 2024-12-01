import Data.List (sort)

main = do
  content <- readFile "./day_1.input"
  let inputData = map (map read . words) $ lines content :: [[Int]]
  let ls1 = sort (map head inputData)
  let ls2 = sort (map last inputData)
  let summ = foldr (\(n1, n2) acc -> acc + abs (n1 - n2)) 0 (zip ls1 ls2)
  print summ
