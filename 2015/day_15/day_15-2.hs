main = do
  input <- readFile "./day_15.input"
  let inputLines = lines input
  let filtered = map (filter (/= ',') ) inputLines
  let weights = map (parseLine . words) filtered
  let rng = [0..100]
  let combs = [ zip weights [n1, n2, n3, n4] | n1 <- rng, n2 <- rng, n3 <- rng, n4 <- rng, n1+n2+n3+n4==100]
  let calculated = map calcCombo combs
  let ff = filter (\ ls -> ls !! 4 == 500) calculated
  let scores = map score ff
  print $ maximum scores


parseLine :: [String] -> [Int]
parseLine [name,"capacity",capacity,
           "durability", durability,"flavor", flavor,
           "texture", texture,"calories",calories]
          = [read capacity, read durability, read flavor, read texture, read calories]

calcCombo :: [([Int], Int)] -> [Int]
calcCombo = foldr (add . mult') (repeat 0)
  where mult' (l, n) =  mult n l

score :: [Int] -> Int
score ls
  | any (< 0) ls = 0
  | otherwise = product $ map (ls !!) [0..3]

mult :: Int -> [Int] -> [Int]
mult n = map (* n) 

add :: [Int] -> [Int] -> [Int]
add = zipWith (+)
