# Part 1 Answer = 282749
# Part 2 Answer = 9962624
import hashlib

i = 0
zeros = 6
while True:
    # s = "abcdef609043"
    s = "yzbqklnj" + str(i)
    hash = hashlib.md5(s.encode()).hexdigest()
    if hash[0:zeros] == "0" * zeros:
        print(i, hash)
        break
    i += 1
