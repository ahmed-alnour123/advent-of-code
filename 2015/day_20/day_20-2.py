from functools import reduce

def factors(n):    
    return set(reduce(list.__add__, ([i, n//i] for i in range(1, int(n**0.5) + 1) if n % i == 0)))

input = 36_000_000

fcounter = {}

for i in range(1, input + 1):
    fs = factors(i)

    for f in fs:
        if f not in fcounter:
            fcounter[f] = 0
        fcounter[f] += 1

    s = sum(filter(lambda x: fcounter[x] <= 50, fs)) * 11
    if s >= input:
        print("Answer: ", i)
        break
