(deffacts date
  (vector 1 2 3 4 5)
  (faza 1)
)

(defrule permute "generez toate permutarile"
  (faza 1)
  (vector $?beg ?x $?med ?y $?end)
  =>
  (assert (vector $?beg ?y $?med ?x $?end))
)

(defrule tranz1-2
  (declare (salience -10))
  ?a <- (faza 1)
  =>
  (retract ?a)
  (assert (faza 2))
)

(defrule check-sort "elimina vectorii care nu sunt sortati"
  (faza 2)
  ?a <- (vector $?beg ?x ?y&:(< ?x ?y) $?end)
  =>
  (retract ?a)
)

  