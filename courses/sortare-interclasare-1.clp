(deffacts date
  (vector 19 2 5 18 -3 24 -15 35 60)
)

(defrule sortare-interchimbare
  ?v <- (vector $?beg ?x $?mid ?y&:(> ?y ?x) $?end)
  =>
  (retract ?v)
  (assert (vector $?beg ?y $?mid ?x $?end))
)

