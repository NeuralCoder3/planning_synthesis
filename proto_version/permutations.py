import itertools

# create the following output

# ; perm1 123
# (contains perm1 reg1 one)
# (contains perm1 reg2 two)
# (contains perm1 reg3 three)
# (contains perm1 swap1 zero)

# ; perm2 321
# (contains perm2 reg1 three)
# (contains perm2 reg2 two)
# (contains perm2 reg3 one)
# (contains perm2 swap1 zero)

n = 3
swap = 1
permutations = list(itertools.permutations(range(1, n+1)))

names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

for k, perm in enumerate(permutations):
    print(f"; perm{k+1} "+"".join(map(str, perm)))
    for i, p in enumerate(perm):
        print(f"(contains perm{k+1} reg{i+1} {names[p]})")
    for i in range(swap):
        print(f"(contains perm{k+1} swap{i+1} zero)")
    print()