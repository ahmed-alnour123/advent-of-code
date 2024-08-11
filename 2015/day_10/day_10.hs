import Prelude hiding (span, concatMap)

main :: IO ()
main = do
  contents <- readFile "./day_10.input"
  let input = head (lines contents)
  let generate = concatMap (\ x -> (show . length) x ++ [head x]) . group
  let part1 = length $ iterate generate input !! 40
  let part2 = length $ iterate generate input !! 50
  print $ "part1: " ++ show part1
  print $ "part2: " ++ show part2

group :: String -> [String]
group [] = []
group (x:xs) = (x:ys) : group zs
  where (ys, zs) = span x xs

span :: Char -> String -> (String, String)
span _ [] = ([], [])
span c s@(x:xs)
  | x == c = let (ys, zs) = span c xs in (x:ys, zs)
  | otherwise = ([], s)

concatMap :: (String -> String) -> [String] -> String
concatMap _ [] = []
concatMap f s = foldr ((++) . f) "" s
