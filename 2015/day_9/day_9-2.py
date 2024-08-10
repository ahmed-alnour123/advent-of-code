from json import dumps
def parse_line(line: str) -> tuple[str,str,int]:
    city1, _, city2, _, distance = line.split(" ")
    distance = int(distance)
    return (city1, city2, distance)

def generate_graph(trips: list[tuple]):
    graph = {}
    for trip in trips:
        (city1, city2, distance) = trip
        if city1 not in graph:
            graph[city1] = {}
        if city2 not in graph:
            graph[city2] = {}

        graph[city1][city2] = distance
        graph[city2][city1] = distance
    return graph

def traverse_graph(root, visited, length) -> int:
    all_cities = graph[root]
    cities = list(filter(lambda x: x not in visited,  all_cities))

    if len(cities) == 0:
        # I reached the end
        print("length is", length)
        return length

    max_length = 0
    for city in cities:
        city_length = traverse_graph(city, visited + [root], length + graph[root][city])
        max_length = max(city_length, max_length)

    return max_length



data = []
with open("./day_9.input") as f:
    line = f.readline().removesuffix("\n")
    while line != "":
        data.append(parse_line(line))
        line = f.readline().removesuffix("\n")

graph = generate_graph(data)
print(dumps(graph, indent=2))


maxx = 0
for city in graph:
    city_length = traverse_graph(city, [city], 0)
    maxx = max(city_length, maxx)

print(maxx)
