main :: IO ()
main = do
  contents <- readFile "./day_8.input"
  -- contents <- readFile "./test.input"
  let inputData = lines contents
  let encoded   = map (addEnds . encodeLine) inputData
  let counts    = zipWith getLengths inputData encoded
  let totalCode = sum $ map fst counts
  let totalMem  = sum $ map snd counts
  print $ totalMem - totalCode

encodeLine :: String -> String
encodeLine []   = []
encodeLine (x:xs)
  | isSpecial x = '\\' : x : encodeLine xs
  | otherwise   = x : encodeLine xs

getLengths :: String -> String -> (Int, Int)
getLengths a b = (length a, length b)

addEnds :: String -> String
addEnds s = "\"" ++ s ++ "\""

isSpecial :: Char -> Bool
isSpecial c = c `elem` ['\\', '"']
