main = do
  content <- readFile "./day_2.input"
  let inputData = lines content
  let parsed = map parseLine inputData
  let nums = map (map read) parsed
  let sizes = map getSize nums
  print $ sum sizes

parseLine :: String -> [String]
parseLine [] = []
parseLine ('x': xs) = parseLine xs
parseLine ls = x : parseLine xs
  where
    (x, xs) = break (== 'x') ls

getSize :: [Int] -> Int
getSize [a, b, c] = (2 * sum mults) + minimum mults
  where mults = [a*b, a*c, b*c]
