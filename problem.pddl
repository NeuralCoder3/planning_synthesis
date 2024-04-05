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

; perm1 123
(contains perm1 reg1 one)
(contains perm1 reg2 two)
(contains perm1 reg3 three)
(contains perm1 swap1 zero)

; perm2 132
(contains perm2 reg1 one)
(contains perm2 reg2 three)
(contains perm2 reg3 two)
(contains perm2 swap1 zero)

; perm3 213
(contains perm3 reg1 two)
(contains perm3 reg2 one)
(contains perm3 reg3 three)
(contains perm3 swap1 zero)

; perm4 231
(contains perm4 reg1 two)
(contains perm4 reg2 three)
(contains perm4 reg3 one)
(contains perm4 swap1 zero)

; perm5 312
(contains perm5 reg1 three)
(contains perm5 reg2 one)
(contains perm5 reg3 two)
(contains perm5 swap1 zero)

; perm6 321
(contains perm6 reg1 three)
(contains perm6 reg2 two)
(contains perm6 reg3 one)
(contains perm6 swap1 zero)


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