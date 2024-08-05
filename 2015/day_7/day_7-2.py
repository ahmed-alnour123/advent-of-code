from json import dumps
def parse_line(line: str):
    cmd_input, output = map(str.strip, line.split("->"))
    return (cmd_input, output)

def eval_line(line: tuple) -> bool:
    cmd_input, output = line
    if output == "b":
        return True

    in_len = len(cmd_input.split(" "))
    if in_len == 1:
        # it is NOT operation
        if reg_ready(cmd_input):
            set_reg(output, parse_data(cmd_input))
        else:
            return False
    elif in_len == 2:
        (_, reg) = cmd_input.split(" ")
        if reg_ready(reg):
            reg = get_reg(reg) ^ (65535)
            set_reg(output, reg)
        else:
            return False
    elif in_len == 3:
        (a, cmd, b) = cmd_input.split(' ')
        if reg_ready(a) and reg_ready(b):
            a = parse_data(a)
            b = parse_data(b)
            res = ops[cmd](a, b)
            set_reg(output, res)
        else:
            return False
    # return line
    return True

def reg_ready(reg) -> bool:
    return reg[0].isdigit() or reg in regs

def parse_data(d: str) -> int:
    if d[0].isdigit():
        return int(d)
    else:
        return get_reg(d)

def get_reg(r: str) -> int:
    if r not in regs:
        regs[r] = 0
        raise ZeroDivisionError("no value " + r)
    return regs[r]

def set_reg(r: str, d):
    regs[r] = d

ops = {
    "AND": lambda a,b: a & b,
    "OR": lambda a,b: a | b,
    "LSHIFT": lambda a,b: a << b,
    "RSHIFT": lambda a,b: a >> b,
}

regs = {
    'b': 16076
}
waiting_lines = []

with open("./day_7.input") as f:
    line = f.readline().removesuffix("\n")
    while line != "":
        waiting_lines += [parse_line(line)]
        line = f.readline().removesuffix("\n")

while len(waiting_lines) > 0:
    for line in waiting_lines.copy():
        if eval_line(line):
            waiting_lines.remove(line) 

out = {i:regs[i] for i in sorted(regs)}
print(dumps(out, indent=2))
print("Answer:", regs['a'])
