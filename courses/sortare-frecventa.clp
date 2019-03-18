(deffacts date
  (vector 19 2 5 2 18 -3 18 24 18 -15 19 35 60)
  (faza 1)
)

(defrule sortare-frecventa
  (faza 1)
  ?v <- (vector ?x $?rest)
  (not (frecventa ?x ?))
  =>
  (retract ?v)
  (assert (frecventa ?x 1)
          (vector $?rest))
)

(defrule sf-2
  (faza 1)
  ?v <- (vector ?x $?rest)
  ?a <- (frecventa ?x ?f)
  =>
  (retract ?v ?a)
  (assert (frecventa ?x (+ ?f 1))
          (vector $?rest))
)

(defrule tranz
  ?a <- (faza 1)
  (vector)
  =>
  (retract ?a)
  (assert (faza 2))
)
  
(defrule sf-3
  (faza 2)
  ?a <- (frecventa ?x ?f&:(> ?f 0))
  (not (frecventa ?y&:(> ?y ?x) ?))
  ?b <- (vector $?beg)
  =>
  (retract ?a ?b)
  (assert (vector $?beg ?x)
          (frecventa ?x (- ?f 1)))
)

(defrule sf-4
  (declare (salience 10))
  (faza 2)
  ?a <- (frecventa ?x 0)
  =>
  (retract ?a)
)

