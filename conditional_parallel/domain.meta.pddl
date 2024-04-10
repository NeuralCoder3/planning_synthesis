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

<%python
pairs = [(f"perm{i}", f"p{i}") for i in range(1, 6+1)]
%>

(:action move
    :parameters (
        ?r1 - register ; to
        ?r2 - register ; from

        <%python
        for perm, short in pairs:
            print(f"?n1_{short} - number")
            print(f"?n2_{short} - number")
        %>
    )
    :precondition (and
        <%python
        for perm, short in pairs:
            print(f"(contains {perm} ?r1 ?n1_{short})")
            print(f"(contains {perm} ?r2 ?n2_{short})")
        %>
    )
    :effect (and
        <%python
        for perm, short in pairs:
            print(f"(contains {perm} ?r1 ?n2_{short})")
            print(f"(not (contains {perm} ?r1 ?n1_{short}))")
        %>
    )
)

; we could have a compare_true and compare_false or a single compare with a conditional effect
(:action compare
    :parameters (
        ?r1 - register
        ?r2 - register

        <%python
        for perm, short in pairs:
            print(f"?n1_{short} - number")
            print(f"?n2_{short} - number")
        %>
    )
    :precondition (and
        <%python
        for perm, short in pairs:
            print(f"(contains {perm} ?r1 ?n1_{short})")
            print(f"(contains {perm} ?r2 ?n2_{short})")
        %>
    )
    :effect (and
        <%python
        for perm, short in pairs:
            print(f"(when (     less-than ?n1_{short} ?n2_{short} ) (     less-flag    {perm} ))")
            print(f"(when (not (less-than ?n1_{short} ?n2_{short})) (not (less-flag    {perm} )))")
            print(f"(when (     less-than ?n2_{short} ?n1_{short} ) (     greater-flag {perm} ))")
            print(f"(when (not (less-than ?n2_{short} ?n1_{short})) (not (greater-flag {perm} )))")
        %>
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

        <%python
        for perm, short in pairs:
            print(f"?n1_{short} - number")
            print(f"?n2_{short} - number")
        %>
    )
    :precondition (and
        <%python
        for perm, short in pairs:
            print(f"(contains {perm} ?r1 ?n1_{short})")
            print(f"(contains {perm} ?r2 ?n2_{short})")
        %>
    )
    :effect (and
        <%python
        for perm, short in pairs:
            print(f"(when (less-flag {perm} ) (and ")
            print(f"      (contains {perm} ?r1 ?n2_{short})")
            print(f"      (not (contains {perm} ?r1 ?n1_{short}))))")
        %>
    )
)

(:action cmovg
    :parameters (
        ?r1 - register
        ?r2 - register

        <%python
        for perm, short in pairs:
            print(f"?n1_{short} - number")
            print(f"?n2_{short} - number")
        %>
    )
    :precondition (and
        <%python
        for perm, short in pairs:
            print(f"(contains {perm} ?r1 ?n1_{short})")
            print(f"(contains {perm} ?r2 ?n2_{short})")
        %>
    )
    :effect (and
        <%python
        for perm, short in pairs:
            print(f"(when (greater-flag {perm} ) (and ")
            print(f"      (contains {perm} ?r1 ?n2_{short})")
            print(f"      (not (contains {perm} ?r1 ?n1_{short}))))")
        %>
    )
)




)
