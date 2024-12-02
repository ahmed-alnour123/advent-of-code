module Day2_2 where

main = do
  inputRaw <- readFile "./day_2.input"
  let input = map (map read . words) (lines inputRaw) :: [[Int]]
  let mapped = map isSafe input
  let safe = length (filter snd mapped)
  let unsafe = map fst $ filter (not . snd) mapped
  let fixed = sum $ map tryFix unsafe
  print $ safe + fixed

tryFix :: [Int] -> Int
tryFix ls = fromEnum $ foldr ((||) . snd . isSafe) False $ generateLists ls

isSafe :: [Int] -> ([Int], Bool)
isSafe x = (x, (checkInc x || checkDec x) && checkSpace x)

generateLists :: [Int] -> [[Int]]
generateLists ls = filter (\x -> length x == len - 1) lists
  where
    lists = getLists [] ls
    len = length ls

getLists :: [Int] -> [Int] -> [[Int]]
getLists acc [] = [acc]
getLists acc (x : xs) = getLists (acc ++ [x]) xs ++ getLists acc xs

checkInc :: [Int] -> Bool
checkInc [x, xx] = x < xx
checkInc (x : xx : xs) = x < xx && checkInc (xx : xs)

checkDec :: [Int] -> Bool
checkDec [x, xx] = x > xx
checkDec (x : xx : xs) = x > xx && checkDec (xx : xs)

checkSpace :: [Int] -> Bool
checkSpace [x, xx] = abs (x - xx) >= 1 && abs (x - xx) <= 3
checkSpace (x : xx : xs) = (abs (x - xx) >= 1 && abs (x - xx) <= 3) && checkSpace (xx : xs)
