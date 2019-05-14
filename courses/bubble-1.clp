(deffacts date
  (vector 1 -2 3 -44 5 3 22 10 12)
)

(defrule bubble
  ?a <- (vector $?beg ?x ?y&:(> ?y ?x) $?end)
  =>
  (retract ?a)
  (assert (vector $?beg ?y ?x $?end))
)



