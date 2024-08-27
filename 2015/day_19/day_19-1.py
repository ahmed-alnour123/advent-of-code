def parse_pattern(s: str) -> tuple:
    p, r = map(str.strip, s.split("=>"))
    return (p, r)

def get_combs(string: str, pattern: tuple) -> list[str]:
    p, r = pattern
    res = []

    for i in range(len(string)):
        part = string[i:]
        if part.startswith(p):
            res.append(string[:i] + r + part.removeprefix(p))

    return res


lines = []

with open('./day_19.input') as f:
    lines = list(map(lambda s: s.removesuffix("\n"), f.readlines()))
    *patterns_in, _, string = lines
    patterns = list(map(parse_pattern, patterns_in))

all_patterns = set()
for p in patterns:
    for c in get_combs(string, p):
        all_patterns.add(c)

print(all_patterns)
print("Answer: ", len(all_patterns))
