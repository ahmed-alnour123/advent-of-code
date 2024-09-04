# Answer = 207
def parse_pattern(s: str) -> tuple:
    p, r = map(str.strip, s.split("=>"))
    return (r, p)

def traverse(string: str, count: int = 0):
    global patterns

    if string in visited:
        return mem[string]
    else:
        visited.add(string)
        l = len(visited)
        if l % 10_000 == 0:
            print(len(visited))

    if string in mem:
        return count + mem[string]

    if (string == 'e'):
        # print("steps are", count)
        # print(" ".join(v), string, count)
        mem[string] = count
        return count

    if string == "":
        # print(v, string)
        mem[string] = float('inf')
        return float('inf')

    min_count = float('inf')

    combos = set()
    for p, r in patterns:
        for c in get_combs(string, (p, r)):
           combos.add(c)
           # c_count = traverse(c,v + [p + "->" + r], count + 1)
           # c_count = traverse(c, count + 1)
           # min_count = min(min_count, c_count)
    for c in combos:
        c_count = traverse(c, count + 1)
        min_count = min(min_count, c_count)


    mem[string] = min_count
    # print(string)
    return min_count

def get_combs(string: str, pattern: tuple) -> set[str]:
    p, r = pattern
    res = set()

    idx = string.find(p)
    while idx != -1:
        res.add(string[:idx] + r + string[idx+len(p):])
        idx = string.find(p, idx + 1)
    return res


lines = []
mem = {}
visited = set()

with open('./day_19.input') as f:
    lines = list(map(lambda s: s.removesuffix("\n"), f.readlines()))
    *patterns_in, _, target = lines
    patterns = list(map(parse_pattern, patterns_in))

# patterns.append(('O', 'e'))
# patterns.append(('H', 'e'))
# target = "HOHOHO"

print("Answer: ", traverse(target))
# print(visited)
print(len(visited))
# traverse('e', [])
# print(patterns)




_ = \
    \
[('H', 'HO'), ('H', 'OH'), ('O', 'HH'), ('e', 'O')]
'''
HHO
'''
