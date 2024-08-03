main = do
  content <- readFile "./day_1.input"
  let ans = runSum 1 0 content
  print ans

runSum :: Int -> Int -> String -> Int
runSum _ _ [] = 0
runSum i n (x:xs) = if acc == -1
  then i
  else runSum (i + 1) acc xs
  where acc = n + getValue x

getValue :: Char -> Int
getValue '(' = 1
getValue ')' = -1
getValue _ = 0
