(deffacts date
  (vector 10 -2 3 10 3 3 -2 10 12 10 -2 3 10 3 3 -2 10 12)
  (faza 1)
)

(defrule gen-freq1
  (faza 1)
  ?a <- (vector ?x $?rest)
  (not (number ?x ?))
  =>
  (retract ?a)
  (assert (vector $?rest)
          (number ?x 1))
)

(defrule gen-freq2
  (faza 1)
  ?a <- (vector ?x $?rest)
  ?b <- (number ?x ?f)
  =>
  (retract ?a ?b)
  (assert (vector $?rest)
          (number ?x (+ ?f 1)))
)

(defrule tranz1-1
  (declare (salience -1))
  ?a <- (faza 1)
  =>
  (retract ?a)
  (assert (faza 2))
)
  
(defrule build-vec1
  (faza 2)
  ?a <- (vector $?all)
  ?b <- (number ?y ?f&:(> ?f 0))
  (not (number ?z&:(< ?z ?y) ?f1&:(> ?f1 0)))
  =>
  (retract ?a ?b)
  (assert (number ?y (- ?f 1))
          (vector ?y $?all))
)


  