(define (problem sorting-three)

(:domain sorting)

(:objects
    ; possible numbers
    zero one two three - number
    ; possible registers
    reg1 reg2 reg3 - register
    swap1 - register
    ; possible permutations
    perm1 perm2 perm3 perm4 perm5 perm6 - permutation
)

(:init
    ; universal facts (additionally to the object facts)
    (less-than zero one)
    (less-than zero two)
    (less-than zero three)
    (less-than one two)
    (less-than one three)
    (less-than two three)

<%python
import itertools
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
%>
)

(:goal
    (and
        ; all to 123
        (contains perm1 reg1 one)
        (contains perm1 reg2 two)
        (contains perm1 reg3 three)

        (contains perm2 reg1 one)
        (contains perm2 reg2 two)
        (contains perm2 reg3 three)

        (contains perm3 reg1 one)
        (contains perm3 reg2 two)
        (contains perm3 reg3 three)

        (contains perm4 reg1 one)
        (contains perm4 reg2 two)
        (contains perm4 reg3 three)

        (contains perm5 reg1 one)
        (contains perm5 reg2 two)
        (contains perm5 reg3 three)

        (contains perm6 reg1 one)
        (contains perm6 reg2 two)
        (contains perm6 reg3 three)
    )
)
)
