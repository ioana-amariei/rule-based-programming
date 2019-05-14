(deffacts fapte
  (vector 1 2 3 4 5)
)

(defrule permutare 
  (vector $?beg ?x $?med ?y $?end)
  =>
  (assert (vector $?beg ?y $?med ?x $?end))
)


