;sortare ascendenta

(deffacts date
   (numere 18 5 -4 30 0 14 -5 30 21)
   (sortate)
)

(defrule interclasare-1
 ?n <-(numere ?x $?rest)
 ?s <- (sortate)
 =>
 (retract ?n ?s)
 (assert(numere $?rest) (sortate ?x))
)

(defrule interclasare-4
 ?n <-(numere ?x $?rest)
 ?s <- (sortate $?beg ?y ?z&:(>= ?x ?y)&:(<= ?x ?z) $?end)
 =>
 (retract ?n ?s)
 (assert(numere $?rest) (sortate $?beg ?y ?x ?z $?end))
)

(defrule interclasare-5
 ?n <-(numere ?x $?rest)
 ?s <- (sortate ?y&:(<= ?x ?y) $?end)
 =>
 (retract ?n ?s)
 (assert(numere $?rest) (sortate ?x ?y $?end))
)

(defrule interclasare-6
 ?n <-(numere ?x $?rest)
 ?s <- (sortate $?beg ?y&:(>= ?x ?y))
 =>
 (retract ?n ?s)
 (assert(numere $?rest) (sortate $?beg ?y ?x))
)
