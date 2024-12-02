module Day2_1  where

main = do
  inputRaw <- readFile "./day_2.input"
  let input = map (map read . words) (lines inputRaw) :: [[Int]]
  let mapped = map (\x -> (checkInc x || checkDec x) && checkSpace x) input
  let safe = length (filter id mapped)
  print safe

checkInc :: [Int] -> Bool
checkInc [x,xx] = x < xx
checkInc (x:xx:xs) = x < xx && checkInc (xx:xs)

checkDec :: [Int] -> Bool
checkDec [x,xx] = x > xx
checkDec (x:xx:xs) = x > xx && checkDec (xx:xs)

checkSpace :: [Int] -> Bool
checkSpace [x,xx] = abs (x-xx) >= 1 && abs (x-xx) <= 3
checkSpace (x:xx:xs) = (abs (x-xx) >= 1 && abs (x-xx) <= 3) && checkSpace (xx:xs)
