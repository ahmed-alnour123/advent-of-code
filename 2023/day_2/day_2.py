def get_color(rounds: list[str], color: str) -> int:
    max_count = 0
    for round in rounds:
        splitted = round.split(",")
        for cube in splitted:
            cube_color = ""
            if cube.endswith("red"): cube_color = "red"
            if cube.endswith("green"): cube_color = "green"
            if cube.endswith("blue"): cube_color = "blue"
            if cube_color != color: continue
            num_count = int(cube.removesuffix(cube_color))
            max_count = max(max_count, num_count)
    return max_count


data: list[str] = []
total = 0

with open("./day_2.input") as f:
    line = f.readline()
    while line != "":
        data.append(line)
        line = f.readline().removesuffix("\n")

for i, game_str in enumerate(data):
    game      = "".join(filter(lambda x: x != " ", game_str))
    colon_idx = game.find(":")
    game_id = int(game[:colon_idx].removeprefix("Game"))
    game_rounds = game[colon_idx+1:].removesuffix("\n").split(";")
    red = get_color(game_rounds, "red")
    green = get_color(game_rounds, "green")
    blue = get_color(game_rounds, "blue")

    is_valid = red <= 12 and green <= 13 and blue <= 14

    if is_valid:
        total += game_id
print(total)
