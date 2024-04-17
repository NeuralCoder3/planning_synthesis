; Sorting Domain

(define (domain sorting)

(:requirements :strips)
; :negative-preconditions

; :universal-preconditions
; allows forall but only in goals and precondition
; we need k distinct variables in parameters 

<%python
import math
n = 3
use_perms = math.factorial(n)
%>

(:predicates
    (register ?r)
    (number ?n)
    (command ?c)

    (less-than ?n1 ?n2 )
    ; avoid negative preconditions
    (less-than-or-equal ?n1 ?n2 )

    ; no explicit greater than as a>b iff b<a
    <%python 
    for i in range(1, use_perms+1):
        print(f"{space}(contains_perm{i} ?r ?n )")
        print(f"{space}(less-flag_perm{i} )")
        print(f"{space}(not-less-flag_perm{i} )")
    %>

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




<%python

for i in range(1, use_perms+1):
    nextperm = f"perm{i+1}" if i < use_perms else "endperm"
    print(f"""
(:action apply_move_{i}
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
        (active perm{i})
        (number ?n1)
        (number ?n2)

        (contains_perm{i} ?r1 ?n1)
        (contains_perm{i} ?r2 ?n2)

        (chosen move ?r1 ?r2)
    )
    :effect (and
        (active {nextperm})
        (not (active perm{i}))

        (contains_perm{i} ?r1 ?n2)
        (not (contains_perm{i} ?r1 ?n1))
    )
)



(:action apply_cmp_true_{i}
    :parameters (
        ?r1
        ?r2

        ?n1
        ?n2
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (number ?n1)
        (number ?n2)

        (active perm{i})

        (contains_perm{i} ?r1 ?n1)
        (contains_perm{i} ?r2 ?n2)

        (chosen cmp ?r1 ?r2)
        (less-than ?n1 ?n2)
    )
    :effect (and
        (active {nextperm})
        (not (active perm{i}))

        (less-flag_perm{i})
        (not (not-less-flag_perm{i}))
    )
)
(:action apply_cmp_false_{i}
    :parameters (
        ?r1
        ?r2

        ?n1
        ?n2
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (number ?n1)
        (number ?n2)

        (active perm{i})

        (contains_perm{i} ?r1 ?n1)
        (contains_perm{i} ?r2 ?n2)

        (chosen cmp ?r1 ?r2)
        (less-than-or-equal ?n2 ?n1)
    )
    :effect (and
        (active {nextperm})
        (not (active perm{i}))

        (not (less-flag_perm{i}))
        (not-less-flag_perm{i})
    )
)


(:action apply_cmovl_true_{i}
    :parameters (
        ?r1
        ?r2

        ?n1
        ?n2
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (number ?n1)
        (number ?n2)

        (active perm{i})

        (contains_perm{i} ?r1 ?n1)
        (contains_perm{i} ?r2 ?n2)

        (chosen cmovl ?r1 ?r2)
        (less-flag_perm{i})
    )
    :effect (and
        (active {nextperm})
        (not (active perm{i}))

        (contains_perm{i} ?r1 ?n2)
        (not (contains_perm{i} ?r1 ?n1))
    )
)

(:action apply_cmovl_false_{i}
    :parameters (
        ?r1
        ?r2

        ?n1
        ?n2
    )
    :precondition (and
        (register ?r1)
        (register ?r2)
        (number ?n1)
        (number ?n2)

        (active perm{i})

        (contains_perm{i} ?r1 ?n1)
        (contains_perm{i} ?r2 ?n2)

        (chosen cmovl ?r1 ?r2)
        (not-less-flag_perm{i})
    )
    :effect (and
        (active {nextperm})
        (not (active perm{i}))
        ; nop
    )
)


""".strip())
%>



)
