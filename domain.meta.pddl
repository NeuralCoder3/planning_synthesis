; Sorting Domain

(define (domain sorting)

(:requirements :strips)
; :negative-preconditions

; :universal-preconditions
; allows forall but only in goals and precondition
; we need k distinct variables in parameters 

(:predicates
    (register ?r)
    (number ?n)
    (permutation ?p)
    (command ?c)

    (less-than ?n1 ?n2 )
    ; avoid negative preconditions
    (less-than-or-equal ?n1 ?n2 )
    (next_perm ?p1 ?p2 )

    ; no explicit greater than as a>b iff b<a
    (contains ?p ?r ?n )
    (less-flag ?p )
    (not-less-flag ?p )
    ; (greater-flag ?p )
    (active ?p )
    (chosen ?c ?r1 ?r2 )
)

(:action choose_command
    :parameters (
        ?c
        ?r1
        ?r2

        ?c_old
        ?r1_old
        ?r2_old
    )
    :precondition (and 
        (command ?c)
        (register ?r1)
        (register ?r2)
        (command ?c_old)
        (register ?r1_old)
        (register ?r2_old)

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
        ?r1 ; to
        ?r2 ; from

        ?p
        ?n1
        ?n2
        ?pn
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (permutation ?p)
        (number ?n1)
        (number ?n2)
        (permutation ?pn)

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
        ?r1
        ?r2

        ?p
        ?n1
        ?n2
        ?pn
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (permutation ?p)
        (number ?n1)
        (number ?n2)
        (permutation ?pn)

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
        (not (not-less-flag ?p))
    )
)
(:action apply_cmp_false
    :parameters (
        ?r1
        ?r2

        ?p
        ?n1
        ?n2
        ?pn
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (permutation ?p)
        (number ?n1)
        (number ?n2)
        (permutation ?pn)

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
        (not-less-flag ?p)
    )
)


(:action apply_cmovl_true
    :parameters (
        ?r1
        ?r2

        ?p
        ?n1
        ?n2
        ?pn
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (permutation ?p)
        (number ?n1)
        (number ?n2)
        (permutation ?pn)

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
        ?r1
        ?r2

        ?p
        ?n1
        ?n2
        ?pn
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (permutation ?p)
        (number ?n1)
        (number ?n2)
        (permutation ?pn)

        (next_perm ?p ?pn)
        (active ?p)

        (contains ?p ?r1 ?n1)
        (contains ?p ?r2 ?n2)

        (chosen cmovl ?r1 ?r2)
        (not-less-flag ?p)
    )
    :effect (and
        (active ?pn)
        (not (active ?p))
        ; nop
    )
)




)
