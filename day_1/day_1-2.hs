-- Answer is 54473
main :: IO ()
main = do
  contents <- readFile "./day_1.input"
  let inputData = lines contents
  let stringNums = filter notNull $  map parseNum inputData
  let string2Digits = map firstLast stringNums
  let nums = map read string2Digits :: [Int]
  print $ sum nums

notNull :: (Foldable t) => t a -> Bool
notNull x = not (null x)

isNumber :: Char -> Bool
isNumber c = c `elem` ['0'..'9']

firstLast :: String -> String
firstLast [] = ""
firstLast [a] = [a, a]
firstLast (x:xs) = [x, last xs]

parseNum :: String -> String
parseNum "" = []
parseNum (x:xs)
  | isNumber x = x:parseNum xs
parseNum num@('o':'n':'e':xs) = '1' : parseNum (drop 1 num)
parseNum num@('t':'w':'o':xs) = '2' : parseNum (drop 1 num)
parseNum num@('t':'h':'r':'e':'e':xs) = '3' : parseNum (drop 1 num)
parseNum num@('f':'o':'u':'r':xs) = '4' : parseNum (drop 1 num)
parseNum num@('f':'i':'v':'e':xs) = '5' : parseNum (drop 1 num)
parseNum num@('s':'i':'x':xs) = '6' : parseNum (drop 1 num)
parseNum num@('s':'e':'v':'e':'n':xs) = '7' : parseNum (drop 1 num)
parseNum num@('e':'i':'g':'h':'t':xs) = '8' : parseNum (drop 1 num)
parseNum num@('n':'i':'n':'e':xs) = '9' : parseNum (drop 1 num)
parseNum (x:xs) = parseNum xs

