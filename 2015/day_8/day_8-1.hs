main :: IO ()
main = do
  contents <- readFile "./day_8.input"
  -- contents <- readFile "./test.input"
  let inputData = lines contents
  let removed   = map stripEnds inputData
  let counts    = map (countLine 2 0) removed
  let totalCode = sum $ map fst counts
  let totalMem  = sum $ map snd counts
  print $ totalCode - totalMem


countLine :: Int -> Int -> String -> (Int, Int)
countLine c m []              = (c, m)
countLine c m ('\\':'"':xs)   = countLine (c + 2) (m + 1) xs
countLine c m ('\\':'\\':xs)  = countLine (c + 2) (m + 1) xs
countLine c m ('\\':'x':d1:d2:xs) 
  | isHex d1 && isHex d2      = countLine (c + 4) (m + 1) xs
  | otherwise                 = countLine (c + 4) (m + 4) xs
countLine c m (x:xs)          = countLine (c + 1) (m + 1) xs

stripEnds :: String -> String
stripEnds [] = []
stripEnds ['"'] = []
stripEnds (x:xs) = x : stripEnds xs


isHex :: Char -> Bool
isHex x = (x `elem` ['0'..'9']) || (x `elem` ['a'..'z'])
