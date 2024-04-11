(define (problem sorting-three)

(:domain sorting)

<%python
import math
n = 3
use_perms = -1
if use_perms == -1:
    use_perms = math.factorial(n)
%>

(:objects
    ; possible numbers
    zero one two three - number
    ; possible registers
    reg1 reg2 reg3 - register
    swap1 - register
    ; possible permutations
    <%python
    print(space, end="")
    for i in range(1, use_perms+1):
        print(f"perm{i} ", end="")
    print("endperm - permutation")
    %>

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
    import itertools
    swap = 1
    permutations = list(itertools.permutations(range(1, n+1)))
    permutations = permutations[:use_perms]

    names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

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

        <%python
        for p in range(1, len(permutations)+1):
            for i in range(1, n+1):
                print(f"{space}(contains perm{p} reg{i} {names[i]})")
            print()
        %>
    )
)
)
