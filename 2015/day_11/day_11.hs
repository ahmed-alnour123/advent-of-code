main = do
  let input = "hxbxwxba"
  let [part1, part2] = take 2 . filter isValid $ iterate next input
  putStrLn $ "part1 answer: " ++ part1
  putStrLn $ "part2 answer: " ++ part2


next :: String -> String
next s@['z', 'z', 'z', 'z', 'z', 'z', 'z', 'z'] = s
next s@[l, 'z', 'z', 'z', 'z', 'z', 'z', 'z']   = succ l : "aaaaaaa"
next s@[_, l, 'z', 'z', 'z', 'z', 'z', 'z']     = take 1 s ++ [succ l] ++ "aaaaaa"
next s@[_, _, l, 'z', 'z', 'z', 'z', 'z']       = take 2 s ++ [succ l] ++ "aaaaa"
next s@[_, _, _, l, 'z', 'z', 'z', 'z']         = take 3 s ++ [succ l] ++ "aaaa"
next s@[_, _, _, _, l, 'z', 'z', 'z']           = take 4 s ++ [succ l] ++ "aaa"
next s@[_, _, _, _, _, l, 'z', 'z']             = take 5 s ++ [succ l] ++ "aa"
next s@[_, _, _, _, _, _, l, 'z']               = take 6 s ++ [succ l] ++ "a"
next s@[_, _, _, _, _, _, _, l]                 = take 7 s ++ [succ l]

isValid :: String -> Bool
isValid s = checkSequence s && checkForbidden s && checkPairs s

checkSequence :: String -> Bool
checkSequence s
  | length s < 3 = False
checkSequence [a,b,c] = (a == pred b) && (b == pred c)
checkSequence (a:b:c:xs) = checkSequence [a,b,c] || checkSequence (b:c:xs)

checkForbidden :: String -> Bool
checkForbidden s = foldr ((&&) . (`notElem` s)) True ['i', 'o', 'l']

checkPairs :: String -> Bool
checkPairs s = length ((unique . getPairs) s) > 1

getPairs :: String -> [String]
getPairs s
  | length s < 2      = []
getPairs s@(x:xx:xs)  = filter (not . null) (test : getPairs (drop d s))
  where same  = x == xx
        test  = [x | same]
        d     = if same then 2 else 1

unique :: [String] -> [String]
unique ls = unique' ls []
  where unique' [] found      = found
        unique' (x:xs) found
          | x `notElem` found = unique' xs (x:found)
          | otherwise         = unique' xs found
