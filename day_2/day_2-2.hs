main :: IO ()
main = do
  contents <- readFile "./day_2.input"
  let inputData = lines contents
  let games = map (wordsWhen (== ';')) inputData
  let results = map (pow . parseGame) games
  print (sum results)

-- parseGame :: [String] -> Bool
parseGame game = do
  let triplets = map parseRound game
  let maxRed = maximum $ map fst' triplets
  let maxGreen = maximum $ map snd' triplets
  let maxBlue = maximum $ map trd' triplets
  (maxRed, maxGreen, maxBlue)
  -- lessThan (maxRed, maxGreen, maxBlue) (12, 13, 14)

parseRound :: String -> (Int, Int, Int)
parseRound s = do
  let withOutColon = splitColon s
  let cubes = wordsWhen (== ',') $ filter (/= ' ') withOutColon
  let pairs = map parseCubes cubes
  -- pairs = [ (1, "red"), (4, "blue") ]
  let reds = sum $ map (getColor "red") pairs
  let greens = sum $ map (getColor "green") pairs
  let blues = sum $ map (getColor "blue") pairs
  (reds, greens, blues)

parseCubes :: String -> (Int, String)
parseCubes s = (read $ takeWhile isNumber s, dropWhile isNumber s)

splitColon :: String -> String
splitColon "" = ""
splitColon (':' : xs) = xs
splitColon s@(x : xs) =
  if hasColon
    then splitColon xs
    else s
  where
    hasColon = ':' `elem` xs

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s = case dropWhile p s of
  "" -> []
  s' -> w : wordsWhen p s''
    where
      (w, s'') = break p s'

isNumber :: Char -> Bool
isNumber c = c `elem` ['0' .. '9']

getColor :: (Eq a, Num b) => a -> (b, a) -> b
getColor s pair =
  if s == snd pair
    then fst pair
    else 0

getGameName :: String -> Int
getGameName s = do
  let strip = drop 5 s
  let numStr = takeWhile (/= ':') strip
  read numStr

pow :: (Int, Int, Int) -> Int
pow (a, b, c) = a * b * c

lessThan :: (Int, Int, Int) -> (Int, Int, Int) -> Bool
lessThan (a1, a2, a3) (b1, b2, b3) = (a1 <= b1) && (a2 <= b2) && (a3 <= b3)

fst' :: (a, b, c) -> a
fst' (a, _, _) = a

snd' :: (a, b, c) -> b
snd' (_, a, _) = a

trd' :: (a, b, c) -> c
trd' (_, _, a) = a
