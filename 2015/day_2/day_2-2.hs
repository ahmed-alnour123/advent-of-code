main = do
  content <- readFile "./day_2.input"
  let inputData = lines content
  let parsed = map parseLine inputData
  let nums = map (quickSort . map read) parsed
  let sizes = map getSize nums
  print $ sum sizes
  -- print $ quickSort [5, 13, 23]

parseLine :: String -> [String]
parseLine [] = []
parseLine ('x': xs) = parseLine xs
parseLine ls = x : parseLine xs
  where
    (x, xs) = break (== 'x') ls

getSize :: [Int] -> Int
getSize ls@[a, b, c] = (2 * (a + b)) + product ls
  where mults = [a*b, a*c, b*c]

quickSort :: [Int] -> [Int]
quickSort [] = []
quickSort (x:xs) = quickSort smallers ++ [x] ++ quickSort biggers
  where
    smallers = filter (<= x) xs
    biggers = filter (> x) xs
