'''
Day 3, Part 1, Answer = 539713
'''
def check_number(number: str, row:int, last_idx: int) -> bool:
    start_idx = last_idx - len(number) + 1
    results: list[bool] = []

    results.append(check_cell(row, start_idx - 1))
    results.append(check_cell(row, last_idx + 1))

    results.append(check_cell(row-1, start_idx - 1))
    results.append(check_cell(row-1, last_idx + 1))
    results.append(check_cell(row+1, start_idx - 1))
    results.append(check_cell(row+1, last_idx + 1))

    for c in range(start_idx, last_idx + 1):
        results.append(check_cell(row-1, c))
        results.append(check_cell(row+1, c))

    return any(results)

def check_cell(row, column) -> bool:
    if not (0 <= row < 140):
        return False
    if not (0 <= column < 140):
        return False

    c = matrix[row][column]
    return (c != ".") and (not c.isdigit())

matrix: list[str] = []

with open("./day_3.input") as f:
    line = f.readline().removesuffix("\n")
    while line != "":
        matrix.append(line)
        line = f.readline().removesuffix("\n")

ii = 0
total = 0
for r, row in enumerate(matrix):
    ii += 1
    current_num = ""
    for i, c in enumerate(row):
        if c.isdigit():
            current_num += c
        else:
            if current_num != "":
                check = check_number(current_num, r, i-1)
                if check:
                    total += int(current_num)
            current_num = ""
    if current_num != "":
        check = check_number(current_num, r, 139)
        if check:
            total += int(current_num)

print("Answer is:", total)
