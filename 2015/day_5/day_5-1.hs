main = do
  contents <- readFile "./day_5.input"
  let inputData = lines contents
  let nice = filter id $ map validateString inputData
  print $ length nice

validateString :: String -> Bool
validateString s = do
  let hasVowels = countVowels s >= 3
  let hasDouble = checkDoubles s
  let containForbidden = hasForbidden s
  hasVowels && hasDouble && not containForbidden

countVowels :: String -> Int
countVowels [] = 0
countVowels (x:xs) = letterCount + countVowels xs where
  letterCount
    | x `elem` ['a', 'e', 'i', 'o', 'u'] = 1
    | otherwise = 0

checkDoubles :: String -> Bool
checkDoubles [] = False
checkDoubles [a] = False
checkDoubles [a, b] = a == b
checkDoubles (a:b:xs) = a == b || checkDoubles (b:xs)

hasForbidden :: String -> Bool
hasForbidden [] = False
hasForbidden ('a': 'b': xs) = True
hasForbidden ('c': 'd': xs) = True
hasForbidden ('p': 'q': xs) = True
hasForbidden ('x': 'y': xs) = True
hasForbidden (x:xs) = hasForbidden xs
