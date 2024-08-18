from typing import Callable


def toggle_lights(orig_grid) -> list[list[str]]:
    grid = [row.copy() for row in orig_grid]
    for r in range(length):
        for c in range(length):
            light = orig_grid[r][c]
            n = calc_neighbors(r, c, orig_grid)
            if light == "#":
                grid[r][c] = "#" if n in (2, 3) else "."
            if light == ".":
                grid[r][c] = "#" if n == 3 else "."
    return grid

def calc_neighbors(row, column, grid) -> int:
    counter = 0
    for r in range(row - 1, row + 2):
        for c in range(column - 1, column + 2):
            if not (0 <= r < length) or not (0 <= c < length) or (r == row and c == column): continue
            if grid[r][c] == "#":
                counter += 1
    return counter

def iterate(fn: Callable, n: int, ls: list):
    val = ls
    for _ in range(n): 
        val = fn(val)
    return val

data = []
length: int

with open("./day_18.input") as f:
    line = f.readline().removesuffix("\n").replace(" ", "")
    length = len(line)
    while line != "":
        data.append([i for i in line])
        line = f.readline().removesuffix("\n").replace(" ", "")


for line in toggle_lights(data):
    print(line)

print('--- ---')
res = iterate(toggle_lights, 100, data)

counter = 0
for line in res:
    print(line)
    for light in line:
        if (light == "#"):
            counter += 1
print(counter)
