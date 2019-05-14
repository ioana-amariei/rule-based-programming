(deffacts date
  (vector1 1 2 3 4 5 -3 2)
  (vector2 12 3 0 2 -4 -5 -7 -10)
)

(defrule inter-1
  ?a <- (vector1 ?x $?rest)
  ?b <- (vector2 $?beg ?y ?z&:(and (<= ?x ?y) (>= ?x ?z)) $?end)
  =>
  (retract ?a ?b)
  (assert (vector2 $?beg ?y ?x ?z $?end)
          (vector1 $?rest))
)

(defrule inter2
  ?a <- (vector1 ?x $?rest)
  ?b <- (vector2)
  =>
  (retract ?a ?b)
  (assert (vector2 ?x)
          (vector1 $?rest))
)

(defrule inter3
  ?a <- (vector1 ?x $?rest)
  ?b <- (vector2 ?y&:(>= ?x ?y) $?end)
  =>
  (retract ?a ?b)
  (assert (vector2 ?x ?y $?end)
          (vector1 $?rest))
)

(defrule inter4
  ?a <- (vector1 ?x $?rest)
  ?b <- (vector2 $?beg ?y&:(<= ?x ?y))
  =>
  (retract ?a ?b)
  (assert (vector2 $?beg ?y ?x)
          (vector1 $?rest))
)


