'''
Day 3, Part 2, Answer = 84159075
'''

def check_number(number: str, row:int, last_idx: int):
    global stars

    start_idx = last_idx - len(number) + 1
    results: list[tuple] = []

    # check left and right
    results.append(check_cell(row, start_idx - 1))
    results.append(check_cell(row, last_idx + 1))

    # check diagonals
    results.append(check_cell(row-1, start_idx - 1))
    results.append(check_cell(row-1, last_idx + 1))
    results.append(check_cell(row+1, start_idx - 1))
    results.append(check_cell(row+1, last_idx + 1))

    # check up and down
    for c in range(start_idx, last_idx + 1):
        results.append(check_cell(row-1, c))
        results.append(check_cell(row+1, c))

    for r in results:
        val, coords = r
        if val:
            add_star(coords, int(number))

def check_cell(row, column) -> tuple[bool, tuple]:
    if not (0 <= row < row_size):
        return (False, (0, 0))
    if not (0 <= column < row_size):
        return (False, (0, 0))

    c = matrix[row][column]
    return (c == "*", (row, column))

def add_star(key, num):
    global stars
    if key not in stars:
        stars[key] = []
    stars[key].append(num)

# -----------

matrix: list[str] = []
stars: dict[tuple, list[int]] = {}

with open("./day_3.input") as f:
    line = f.readline().removesuffix("\n")
    while line != "":
        matrix.append(line)
        line = f.readline().removesuffix("\n")

row_size = len(matrix)
total = 0

for r, row in enumerate(matrix):
    current_num = ""
    for i, c in enumerate(row):
        if c.isdigit():
            current_num += c
        else:
            if current_num != "":
                check = check_number(current_num, r, i-1)
            current_num = ""

    # add the last number (if existed)
    if current_num != "":
        check = check_number(current_num, r, row_size-1)

two_stars = {i:(stars[i][0] * stars[i][1]) for i in filter(lambda x: len(stars[x]) == 2, stars)}

for k in two_stars:
    mult = two_stars[k]
    total += mult 

print("Answer is:", total)
