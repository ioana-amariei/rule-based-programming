(deffacts date
  (vector 4 2 -3 100 -5 7 11 22 98 100)
)

(defrule max
  (vector $? ?x $?)
  (not (vector $? ?y&:(> ?y ?x) $?))
  =>
  (printout t ?x crlf)
  (halt)
)
  