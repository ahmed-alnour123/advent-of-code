import Prelude hiding (traverse)

main = do
  content <- readFile "./day_3.input"
  let evens = [s | (i, s) <- zip [0..] content, even i]
  let odds = [s | (i, s) <- zip [0..] content, odd i]
  let santaVisited = traverse [(0, 0)] evens
  let robotVisited = traverse [(0, 0)] odds
  let total = santaVisited ++ robotVisited
  print $ length (uniques total)

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
