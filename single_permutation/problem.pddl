(define (problem sorting-three)

(:domain sorting)

(:objects
    ; possible numbers
    zero one two three - number
    ; possible registers
    reg1 reg2 reg3 - register
    swap1 - register
)

(:init
    ; initial register values
    (contains reg1 one)
    (contains reg2 two)
    (contains reg3 three)
    ; initial swap register value
    (contains swap1 zero)

    ; universal facts (additionally to the object facts)
    (less-than zero one)
    (less-than zero two)
    (less-than zero three)
    (less-than one two)
    (less-than one three)
    (less-than two three)
)

(:goal
    (and
        ; test 123,0 -> 111,0
        (contains reg1 one)
        (contains reg2 one)
        (contains reg3 one)
    )
)
)