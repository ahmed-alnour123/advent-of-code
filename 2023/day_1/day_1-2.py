# cheating here to test my haskell code

data: list[str] = []
numbers = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,

}

with open("./day_1.input") as f:
    line = f.readline()
    while line != "":
        data.append(line)
        line = f.readline().removesuffix("\n")

sum = 0
for s in data:
    nums_string = ""
    for i in range(len(s)):
        if s[i].isnumeric():
            nums_string += s[i]
        else:
            for number in numbers:
                if s.startswith(number, i):
                    nums_string += str(numbers[number])
    first_last = nums_string[0] + nums_string[-1]
    sum += int(first_last)
    # print(s, first_last, sep=": ")

print("sum is", sum)
