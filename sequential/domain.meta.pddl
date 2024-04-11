; Sorting Domain

(define (domain sorting)

(:requirements :strips :typing :negative-preconditions)

; :universal-preconditions
; allows forall but only in goals and precondition
; we need k distinct variables in parameters 

(:types
    register number permutation command
)

(:predicates
    (less-than ?n1 - number ?n2 - number)
    ; avoid negative preconditions
    (less-than-or-equal ?n1 - number ?n2 - number)
    (next_perm ?p1 - permutation ?p2 - permutation)

    ; no explicit greater than as a>b iff b<a
    (contains ?p - permutation ?r - register ?n - number)
    (less-flag ?p - permutation)
    (greater-flag ?p - permutation)
    (active ?p - permutation)
    (chosen ?c - command ?r1 - register ?r2 - register)
)

(:action choose_command
    :parameters (
        ?c - command
        ?r1 - register
        ?r2 - register 

        ?c_old - command
        ?r1_old - register
        ?r2_old - register
    )
    :precondition (and 
        (active endperm)
        (chosen ?c_old ?r1_old ?r2_old)
    )
    :effect (and 
        (chosen ?c ?r1 ?r2)
        (active perm1)
        (not (active endperm))
        (not (chosen ?c_old ?r1_old ?r2_old))
    )
)


(:action apply_move
    :parameters (
        ?r1 - register ; to
        ?r2 - register ; from

        ?p - permutation
        ?n1 - number
        ?n2 - number
        ?pn - permutation
    )
    :precondition (and
        (next_perm ?p ?pn)
        (active ?p)

        (contains ?p ?r1 ?n1)
        (contains ?p ?r2 ?n2)

        (chosen move ?r1 ?r2)
    )
    :effect (and
        (active ?pn)
        (not (active ?p))

        (contains ?p ?r1 ?n2)
        (not (contains ?p ?r1 ?n1))
    )
)



(:action apply_cmp_true
    :parameters (
        ?r1 - register ; to
        ?r2 - register ; from

        ?p - permutation
        ?n1 - number
        ?n2 - number
        ?pn - permutation
    )
    :precondition (and
        (next_perm ?p ?pn)
        (active ?p)

        (contains ?p ?r1 ?n1)
        (contains ?p ?r2 ?n2)

        (chosen cmp ?r1 ?r2)
        (less-than ?n1 ?n2)
    )
    :effect (and
        (active ?pn)
        (not (active ?p))

        (less-flag ?p)
    )
)
(:action apply_cmp_false
    :parameters (
        ?r1 - register ; to
        ?r2 - register ; from

        ?p - permutation
        ?n1 - number
        ?n2 - number
        ?pn - permutation
    )
    :precondition (and
        (next_perm ?p ?pn)
        (active ?p)

        (contains ?p ?r1 ?n1)
        (contains ?p ?r2 ?n2)

        (chosen cmp ?r1 ?r2)
        (less-than-or-equal ?n2 ?n1)
    )
    :effect (and
        (active ?pn)
        (not (active ?p))

        (not (less-flag ?p))
    )
)


(:action apply_cmovl_true
    :parameters (
        ?r1 - register ; to
        ?r2 - register ; from

        ?p - permutation
        ?n1 - number
        ?n2 - number
        ?pn - permutation
    )
    :precondition (and
        (next_perm ?p ?pn)
        (active ?p)

        (contains ?p ?r1 ?n1)
        (contains ?p ?r2 ?n2)

        (chosen cmovl ?r1 ?r2)
        (less-flag ?p)
    )
    :effect (and
        (active ?pn)
        (not (active ?p))

        (contains ?p ?r1 ?n2)
        (not (contains ?p ?r1 ?n1))
    )
)

(:action apply_cmovl_false
    :parameters (
        ?r1 - register ; to
        ?r2 - register ; from

        ?p - permutation
        ?n1 - number
        ?n2 - number
        ?pn - permutation
    )
    :precondition (and
        (next_perm ?p ?pn)
        (active ?p)

        (contains ?p ?r1 ?n1)
        (contains ?p ?r2 ?n2)

        (chosen cmovl ?r1 ?r2)
        (not (less-flag ?p))
    )
    :effect (and
        (active ?pn)
        (not (active ?p))
        ; nop
    )
)




)
