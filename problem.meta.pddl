(define (problem sorting-three)

(:domain sorting)

(:objects
    ; possible numbers
    zero one two three - number
    ; possible registers
    reg1 reg2 reg3 - register
    swap1 - register
    ; possible permutations
    perm1 perm2 perm3 perm4 perm5 perm6 endperm - permutation
    move cmovl cmp - command
    ; cmovg
)

(:init
    ; universal facts (additionally to the object facts)
    (less-than zero one)
    (less-than zero two)
    (less-than zero three)
    (less-than one two)
    (less-than one three)
    (less-than two three)

    (less-than-or-equal zero zero)
    (less-than-or-equal zero one)
    (less-than-or-equal zero two)
    (less-than-or-equal zero three)
    (less-than-or-equal one one)
    (less-than-or-equal one two)
    (less-than-or-equal one three)
    (less-than-or-equal two two)
    (less-than-or-equal two three)
    (less-than-or-equal three three)

    ; permutation facts
    (next_perm perm1 perm2)
    (next_perm perm2 perm3)
    (next_perm perm3 perm4)
    (next_perm perm4 perm5)
    (next_perm perm5 perm6)
    (next_perm perm6 endperm)

    ; at end/start of an instruction cycle
    (active endperm)
    ; dummy command
    (chosen cmp reg1 reg1)

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

        <%python
        for p in range(1, len(permutations)+1):
            for i in range(1, n+1):
                print(f"(contains perm{p} reg{i} {names[i]})")
            print()
        %>
    )
)
)
