main = do
  contents <- readFile "./day_5.input"
  let inputData = lines contents
  let nice = filter id $ map validateString inputData
  print $ length nice

validateString :: String -> Bool
validateString s = do
  let containPair = hasPairs s
  let containSandwitch = hasSandwitch s
  containPair && containSandwitch

hasPairs :: String -> Bool
hasPairs [] = False
hasPairs [_] = False
hasPairs [_, _] = False
hasPairs [_, _, _] = False
hasPairs [a, b, c, d] = a == c && b == d
hasPairs (a:b:xs) = checkPair [a,b] xs || hasPairs (b:xs)

checkPair :: String -> String -> Bool
checkPair _ [] = False
checkPair _ [_] = False
checkPair [a1, b1] [a2, b2] = a1 == a2 && b1 == b2
checkPair pair@[a1, b1] (a2:b2:xs) = checkPair pair [a2,b2] || checkPair pair (b2:xs)

hasSandwitch :: String -> Bool
hasSandwitch [] = False
hasSandwitch [a] = False
hasSandwitch [a, b] = False
hasSandwitch [a, _, b] = a == b
hasSandwitch (a:b:c:xs) = hasSandwitch [a,b,c] || hasSandwitch (b:c:xs)
