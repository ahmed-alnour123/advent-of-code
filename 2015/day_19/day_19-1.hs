main = do
  input <- readFile "./test.input"
  let inputData = lines input
  let (ps, [_, string]) = span (/= "") inputData
  let patterns = map parsePattern ps
  print string
  print patterns
  putStrLn ""
  print $ count ("H", "HO") [] string
  -- print $ [count p string | p <- patterns]

-- count :: (String, String) -> [String] -> String -> String
count p visited []            = []
count (p, r) visited st@(s:ss)
  | checkPattern p st = do
      let orig = s : count (p, r) visited ss
      let new = r ++ count (p, r) visited (drop n st)
      new
  | otherwise         = s : count (p, r) visited ss
    where n           = length p

checkPattern :: String -> String -> Bool
checkPattern [] _           = True
checkPattern (p:ps) []      = False
checkPattern (p:ps) (s:ss)  = p == s && checkPattern ps ss

parsePattern :: String -> (String, String)
parsePattern s = do
  let p = init $ takeWhile (/='=') s
  let r = drop 2 $ dropWhile (/='>') s
  (p, r)

