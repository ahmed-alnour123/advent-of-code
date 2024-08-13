import json

def traverse(root) -> int:
    total = 0
    t = type(root)

    if t == list:
        for i in root:
            total += traverse(i)
    elif t == dict:
        for v in root.values():
            total += traverse(v)
            if v == "red":
                total = 0
                break
    elif t == int:
        total += root

    return total

with open("./day_12.input") as f:
    root = json.load(f)

print(traverse(root))
