import Prelude hiding (traverse)

main = do
  content <- readFile "./day_3.input"
  let visited = traverse [(0, 0)] content
  print $ length $ uniques visited

traverse :: [(Int, Int)] -> String -> [(Int, Int)]
traverse p [] = p
traverse p (x:xs)
  | x == '^' = traverse ((f, s + 1) : p) xs
  | x == 'v' = traverse ((f, s - 1) : p) xs
  | x == '>' = traverse ((f + 1, s) : p) xs
  | x == '<' = traverse ((f - 1, s) : p) xs
  where
    l = head p
    f = fst l
    s = snd l

uniques :: Eq a => [a] -> [a]
uniques [] = []
uniques (x:xs)
  | x `elem` xs = uniques xs
  | otherwise = x : uniques xs
