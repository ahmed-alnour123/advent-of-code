main = do
  content <- readFile "./day_1.input"
  let up = length $ filter (=='(') content 
  let down = length $ filter (==')') content 
  print (up - down)
