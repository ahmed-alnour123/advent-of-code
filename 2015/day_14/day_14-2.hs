import Data.List (maximumBy, group, sortBy)
import Data.Function (on)

raceTime  = 2503

main = do
  contents <- readFile "./day_14.input"
  let inputData = lines contents
  let parsed = map (parseLine . words) inputData
  let seconds = map (flip calcDist) [1..raceTime]
  let snapshots = splitList (length inputData) [f i | f <- seconds, i <- parsed]
  let sorted = quickSort $ concatMap getFirsts snapshots
  let res = sortBy (flip compare `on` snd) $ map (\ ls -> (head ls, length ls)) $ group sorted
  print res
  print $ "Answer: " ++ (fst . head) res ++ ", points: " ++ (show . snd . head) res

parseLine :: [String] -> (String, Int, Int, Int)
parseLine [name,"can","fly",flyDist,
  "km/s","for",flyTime,
  "seconds,","but","then",
  "must","rest","for",
  restTime,"seconds."] = (name, read flyDist, read flyTime, read restTime)

calcDist :: (String, Int, Int, Int) -> Int -> (String, Int)
calcDist (name, flyDist, flyTime, restTime) time = do
  let cycleTime = flyTime + restTime
  let n = time `div` cycleTime
  let remCycle = time `mod` cycleTime 
  let remTime = min flyTime remCycle
  let totalDist = (n * flyTime + remTime) * flyDist
  (name, totalDist)

filterPairs :: Int -> [(String, Int)] -> [String]
filterPairs _ []  = []
filterPairs n (x:xs)
  | snd x == n  = fst x : filterPairs n xs
  | otherwise   = filterPairs n xs

getFirsts :: [(String, Int)] -> [String]
getFirsts ls = filterPairs maxCount ls
  where maxCount = snd $ maximumBy (compare `on` snd) ls

splitList :: Int -> [a] -> [[a]]
splitList _ []  = []
splitList n l   = take n l : splitList n (drop n l)

quickSort :: [String] -> [String]
quickSort []      = []
quickSort (x:xs)  = quickSort minn ++ [x] ++ quickSort maxx
  where minn  = filter (<= x) xs
        maxx  = filter (> x) xs
