def parse_pattern(s: str) -> tuple:
    p, r = map(str.strip, s.split("=>"))
    return (p, r)

def traverse(string: str, v, count: int = 0):
    global patterns, target

    if string in mem:
        return count + mem[string]

    if (string == target):
        # print("steps are", count)
        print(" ".join(v), string, count)
        mem[string] = count
        return count

    if len(string) > len(target):
        # print(v, string)
        mem[string] = float('inf')
        return float('inf')

    min_count = float('inf')

    for p, r in patterns:
        for c in get_combs(string, (p, r)):
            c_count = traverse(c,v + [p + "->" + r], count + 1)
            min_count = min(min_count, c_count)
    return min_count

def get_combs(string: str, pattern: tuple) -> set[str]:
    p, r = pattern
    res = set()

    for i in range(len(string)):
        part = string[i:]
        if part.startswith(p):
            res.add(string[:i] + r + part.removeprefix(p))

    return res


lines = []
mem = {}

with open('./day_19.input') as f:
    lines = list(map(lambda s: s.removesuffix("\n"), f.readlines()))
    *patterns_in, _, target = lines
    patterns = list(map(parse_pattern, patterns_in))

# patterns.append(('e', 'O'))
# patterns.append(('e', 'H'))
# target = "HOHOHO"

print(traverse('e', []))
# traverse('e', [])
# print(patterns)




_ = \
    \
[('H', 'HO'), ('H', 'OH'), ('O', 'HH'), ('e', 'O')]
'''
HHO
'''
