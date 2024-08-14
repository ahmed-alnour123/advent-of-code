import re
from json import dumps
from itertools import permutations

def parse_line(line: str) -> tuple:
    name1, s, points, name2 = re.search(r"(\w*) would (gain|lose) (\w*) happiness units by sitting next to (\w*).", line).groups()

    points = int(points)
    points *= -1 if s == "lose" else 1

    return (name1, points, name2)

def generate_graph(lines) -> dict:
    graph = { "me": {} }

    for (name1, points, name2) in lines:
        if name1 not in graph:
            graph[name1] = { "me":0 }

        graph[name1][name2] = points
        graph["me"][name1] = 0

    return graph

def calc_graph(ls: tuple) -> int:
    summ = 0
    ln = len(ls)
    for i,name in enumerate(ls):
        prev = ls[(i-1) % ln] 
        next = ls[(i+1) % ln] 
        summ += graph[name][prev] + graph[name][next]
    return summ

lines = []
with open("./day_13.input") as f:
    line = f.readline().removesuffix("\n")
    while line != "":
        lines.append(parse_line(line))
        line = f.readline().removesuffix("\n")

graph = generate_graph(lines)
print(dumps(graph, indent=2))

maxx = 0
for p in permutations(graph.keys()):
    maxx = max(maxx, calc_graph(p))
print(maxx)
