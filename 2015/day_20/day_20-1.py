from functools import reduce

def factors(n):    
    return set(reduce(list.__add__, ([i, n//i] for i in range(1, int(n**0.5) + 1) if n % i == 0)))

input = 36_000_000

for i in range(1, input + 1):
    s = sum(factors(i)) * 10
    if s >= input:
        print("Answer: ", i)
        break
