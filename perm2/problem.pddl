(define (problem sorting-three)

(:domain sorting)

(:objects
    ; possible numbers
    zero one two three - number
    ; possible registers
    reg1 reg2 reg3 - register
    swap1 - register
    ; possible permutations
    ; perm1 perm2 perm3 perm4 perm5 perm6 - permutation
    perm1 perm2 - permutation
)

(:init
    ; universal facts (additionally to the object facts)
    (less-than zero one)
    (less-than zero two)
    (less-than zero three)
    (less-than one two)
    (less-than one three)
    (less-than two three)

    ; perm1 123
    ; initial register values
    (contains perm1 reg1 one)
    (contains perm1 reg2 two)
    (contains perm1 reg3 three)
    ; initial swap register value
    (contains perm1 swap1 zero)

    ; perm2 321
    (contains perm2 reg1 three)
    (contains perm2 reg2 two)
    (contains perm2 reg3 one)
    (contains perm2 swap1 zero)
)

(:goal
    (and
        ; all to 123
        ; needed: 
        ; conditional swap 1 <-> 3
        ; mov 4 3
        ; cmp 1 3
        ; cmovg 3 1 // if 3>1, write 1 to 3
        ; cmovg 1 4 // complete swap by writing 3 to 1

        (contains perm1 reg1 one)
        (contains perm1 reg2 two)
        (contains perm1 reg3 three)

        (contains perm2 reg1 one)
        (contains perm2 reg2 two)
        (contains perm2 reg3 three)
    )
)
)