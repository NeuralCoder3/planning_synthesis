; Sorting Domain

(define (domain sorting)

(:requirements :strips :typing :negative-preconditions :conditional-effects)

; :universal-preconditions
; allows forall but only in goals and precondition
; we need k distinct variables in parameters 

(:types
    register number permutation
)

(:predicates
    (less-than ?n1 - number ?n2 - number)
    ; no explicit greater than as a>b iff b<a
    (contains ?p - permutation ?r - register ?n - number)
    (less-flag ?p - permutation)
    (greater-flag ?p - permutation)
)

(:action move
    :parameters (
        ?r1 - register ; to
        ?r2 - register ; from

        ?n1_$PERM - number
        ?n2_$PERM - number
    )
    :precondition (and
        (contains $PERMUTATION ?r1 ?n1_$PERM)
        (contains $PERMUTATION ?r2 ?n2_$PERM)
    )
    :effect (and
        (     contains $PERMUTATION ?r1 ?n2_$PERM )
        (not (contains $PERMUTATION ?r1 ?n1_$PERM))
    )
)

; we could have a compare_true and compare_false or a single compare with a conditional effect
(:action compare
    :parameters (
        ?r1 - register
        ?r2 - register

        ?n1_$PERM - number
        ?n2_$PERM - number
    )
    :precondition (and
        (contains $PERMUTATION ?r1 ?n1_$PERM)
        (contains $PERMUTATION ?r2 ?n2_$PERM)
    )
    :effect (and
        (when (     less-than ?n1_$PERM ?n2_$PERM ) (     less-flag    $PERMUTATION))
        (when (not (less-than ?n1_$PERM ?n2_$PERM)) (not (less-flag    $PERMUTATION)))
        (when (     less-than ?n2_$PERM ?n1_$PERM ) (     greater-flag $PERMUTATION))
        (when (not (less-than ?n2_$PERM ?n1_$PERM)) (not (greater-flag $PERMUTATION)))
    )
)

; we could have a working cmovl and noop cmovl
; that are the same as move with less-flag as additional precondition
; or a single cmovl with conditional effect
; importantly: cmovl should also be applicable when less-flag is false
; => intuitively every instruction is always possible 
; => all same precondition that to not restrict but just establish the values
(:action cmovl
    :parameters (
        ?r1 - register
        ?r2 - register

        ?n1_$PERM - number
        ?n2_$PERM - number
    )
    :precondition (and
        (contains $PERMUTATION ?r1 ?n1_$PERM)
        (contains $PERMUTATION ?r2 ?n2_$PERM)
    )
    :effect (and
        (when (less-flag $PERMUTATION) (and (contains $PERMUTATION ?r1 ?n2_$PERM) (not (contains $PERMUTATION ?r1 ?n1_$PERM))))
    )
)

(:action cmovg
    :parameters (
        ?r1 - register
        ?r2 - register

        ?n1_$PERM - number
        ?n2_$PERM - number
    )
    :precondition (and
        (contains $PERMUTATION ?r1 ?n1_$PERM)
        (contains $PERMUTATION ?r2 ?n2_$PERM)
    )
    :effect (and
        (when (greater-flag $PERMUTATION) (and (contains $PERMUTATION ?r1 ?n2_$PERM) (not (contains $PERMUTATION ?r1 ?n1_$PERM))))
    )
)




)