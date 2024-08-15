import Data.List (maximumBy)
raceTime  = 2503

main = do
  contents <- readFile "./day_14.input"
  let inputData = lines contents
  let parsed = map (calcDist . parseLine . words) inputData
  print $ maximumBy comparePairs parsed

parseLine :: [String] -> (String, Int, Int, Int)
parseLine [name,"can","fly",flyDist,
  "km/s","for",flyTime,
  "seconds,","but","then",
  "must","rest","for",
  restTime,"seconds."] = (name, read flyDist, read flyTime, read restTime)

calcDist :: (String, Int, Int, Int) -> (String, Int)
calcDist (name, flyDist, flyTime, restTime) = do
  let cycleTime = flyTime + restTime
  let n = raceTime `div` cycleTime
  let remCycle = raceTime `mod` cycleTime 
  let remTime = min flyTime remCycle
  let totalDist = (n * flyTime + remTime) * flyDist
  (name, totalDist)

comparePairs :: (a, Int) -> (a, Int) -> Ordering
comparePairs x y = snd x `compare` snd y
