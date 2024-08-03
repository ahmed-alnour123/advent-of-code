-- Answer is 54990

main :: IO ()
main = do
  contents <- readFile "./day_1.input"
  let inputData = lines contents
  let stringNums = map (firstLast . filterNums) inputData
  let nums = map read stringNums :: [Int]
  print (sum nums)

isNumber :: Char -> Bool
isNumber c = c `elem` ['0'..'9']

filterNums :: String -> String
filterNums xs = filter isNumber xs

firstLast :: String -> String
firstLast []      = ""
firstLast [a]     = [a, a]
firstLast (x:xs)  = [x, last xs]
