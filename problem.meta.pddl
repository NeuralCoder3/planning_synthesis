(define (problem sorting-three)

(:domain sorting)

<%python
import math
import itertools
swap = 1

names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
n = 3
use_perms = -1
permutations = list(itertools.permutations(range(1, n+1)))
if use_perms == -1:
    use_perms = len(permutations)
else:
    permutations = permutations[:use_perms]
%>

(:objects
    ; possible numbers
    <%python
    for i in range(0, n+1):
        print(f"{names[i]} ", end="")
    print()
    %>
    ; possible registers
    <%python
    for i in range(1, n+1):
        print(f"reg{i} ", end="")
    print()
    %>
    swap1
    ; possible permutations
    <%python
    print(space, end="")
    for i in range(1, use_perms+1):
        print(f"perm{i} ", end="")
    print("endperm")
    %>

    move cmovl cmp
    ; cmovg
)

(:init
    ; numbers
    <%python
    for i in range(0, n+1):
        print(f"{space}(number {names[i]})")
    %>
    <%python
    for i in range(1, n+1):
        print(f"{space}(register reg{i})")
    %>
    (register swap1)
    (command move)
    (command cmovl)
    (command cmp)
    <%python
    for i in range(1, use_perms+1):
        print(f"{space}(permutation perm{i})")
    print(f"{space}(permutation endperm)")
    %>


    ; universal facts (additionally to the object facts)
    <%python
    for a in range(0, n+1):
        for b in range(0, n+1):
            if a < b:
                print(f"{space}(less-than {names[a]} {names[b]})")
            if a <= b:
                print(f"{space}(less-than-or-equal {names[a]} {names[b]})")
    %>

    ; permutation facts
    <%python
    for i in range(1, use_perms):
        print(f"{space}(next_perm perm{i} perm{i+1})")
    print(f"{space}(next_perm perm{use_perms} endperm)")
    %>

    ; at end/start of an instruction cycle
    (active endperm)
    ; dummy command
    (chosen cmp reg1 reg1)
    <%python
    for i in range(1, use_perms+1):
        print(f"{space}(not-less-flag perm{i})")
    %>


    <%python
    for k, perm in enumerate(permutations):
        print(f"{space}; perm{k+1} "+"".join(map(str, perm)))
        for i, p in enumerate(perm):
            print(f"{space}(contains perm{k+1} reg{i+1} {names[p]})")
        for i in range(swap):
            print(f"{space}(contains perm{k+1} swap{i+1} zero)")
        print()
    %>
    )

(:goal
    (and
        ; all to 123
        (active endperm)

        <%python
        for p in range(1, len(permutations)+1):
            for i in range(1, n+1):
                print(f"{space}(contains perm{p} reg{i} {names[i]})")
            print()
        %>
    )
)
)
