"ans = 213"
from itertools import dropwhile 
class Aunt:
    def __init__(self) -> None:
        self.number = 0
        self.children = None
        self.cats = None
        self.samoyeds = None
        self.pomeranians = None
        self.akitas = None
        self.vizslas = None
        self.goldfish = None
        self.trees = None
        self.cars = None
        self.perfumes = None

    def __str__(self) -> str:
        return "\nnumber: " + str(self.number) + \
        "\nchildren: " + str(self.children) + \
        "\ncats: " + str(self.cats) + \
        "\nsamoyeds: " + str(self.samoyeds) + \
        "\npomeranians: " + str(self.pomeranians) + \
        "\nakitas: " + str(self.akitas) + \
        "\nvizslas: " + str(self.vizslas) + \
        "\ngoldfish: " + str(self.goldfish) + \
        "\ntrees: " + str(self.trees) + \
        "\ncars: " + str(self.cars) + \
        "\nperfumes: " + str(self.perfumes)

def parse_line(line: str) -> Aunt:
    a = Aunt()

    # line = "Sue 490: goldfish: 8, perfumes: 2, akitas: 2"
    (num, *_) = line.split(":")
    num = int(num.removeprefix("Sue "))
    a.number = num

    ls = "".join(dropwhile(lambda x: x != ":", line))[1:]
    for pair in ls.split(","):
        (name, count) = map(str.strip, pair.split(":"))
        count = int(count)
        a.__setattr__(name, count)

    return a

def test(a1: Aunt, a2: Aunt) -> bool:
    return compare(a1.children, a2.children) \
            and compare(a1.cats, a2.cats) \
            and compare(a1.samoyeds , a2.samoyeds ) \
            and compare(a1.pomeranians , a2.pomeranians  ) \
            and compare(a1.akitas , a2.akitas  ) \
            and compare(a1.vizslas , a2.vizslas  ) \
            and compare(a1.goldfish , a2.goldfish  ) \
            and compare(a1.trees , a2.trees  ) \
            and compare(a1.cars , a2.cars  ) \
            and compare(a1.perfumes , a2.perfumes  )

def compare(val1, val2):
    if val1 == None or val2 == None:
        res = True
    else: res = val1 == val2
    # print("comparing", val1, val2, "res: ", res)

    if val1 == None or val2 == None:
        return True
    return val1 == val2


aunts = []
with open("./day_16.input") as f:
    line = f.readline().removesuffix("\n")
    while line != "":
        aunts.append(parse_line(line))
        line = f.readline().removesuffix("\n")

aunt_sue = Aunt()
aunt_sue.children = 3
aunt_sue.cats = 7
aunt_sue.samoyeds = 2
aunt_sue.pomeranians = 3
aunt_sue.akitas = 0
aunt_sue.vizslas = 0
aunt_sue.goldfish = 5
aunt_sue.trees = 3
aunt_sue.cars = 2
aunt_sue.perfumes = 1

print(aunt_sue)

for a in aunts:
    print(a.number, test(aunt_sue, a))
