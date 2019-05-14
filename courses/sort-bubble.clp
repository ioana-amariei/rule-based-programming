(deffacts date
  (vector 3 4 1 -2 10 -4 -3 4 2 3 6 7)
)

(defrule bubble
  ?v <- (vector $?beg ?x ?y&:(> ?y ?x) $?end)
  =>
  (retract ?v)
  (assert (vector $?beg ?y ?x $?end))
)

