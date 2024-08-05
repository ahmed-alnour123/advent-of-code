def parseLine(line: str):
    commands = ["turnon", "turnoff", "toggle"]
    command: str = ""
    for c in commands:
        if line.startswith(c):
            command = c
            line = line.removeprefix(c)
            break

    ranges = line.split("through")
    ranges = [list(map(int,i)) for i in [r.split(",") for r in ranges]]
    start, end = ranges
    return (command, start, end)

def apply_command(cmd, r, c):
    if cmd == "turnon":
        return grid[r][c] + 1
    elif cmd == "turnoff":
        return max(grid[r][c] - 1, 0)
    else:
        return grid[r][c] + 2


data = []
grid = [[ 0 for _ in range(1000) ] for _ in range(1000)]

with open("./day_6.input") as f:
    line = f.readline().removesuffix("\n").replace(" ", "")
    while line != "":
        data += [parseLine(line)]
        line = f.readline().removesuffix("\n").replace(" ", "")

for line in data:
    (cmd, start, end) = line
    for r in range(start[0], end[0] + 1):
        for c in range(start[1], end[1] + 1):
            grid[r][c] = apply_command(cmd, r, c)


total = 0
for row in grid:
    for c in row:
        total += c

print(total)
