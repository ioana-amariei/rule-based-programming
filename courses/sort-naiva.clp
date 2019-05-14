(deffacts fapte
  (vector 3 2 5 1 4)
  (faza 1)
)

(defrule permutare 
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

(defrule save-vector-in-buffer-tranz2-3
  ?f <- (faza 2)
  ?a <- (vector $?all)
  =>
  (retract ?a ?f)
  (assert (buffer $?all)
          (saved-vector $?all)
          (faza 3))
)

(defrule check-buffer
  (faza 3)
  ?a <- (buffer ?x ?y&:(> ?x ?y) $?rest)
  =>
  (retract ?a)
  (assert (buffer ?y $?rest))
)

(defrule fail-buffer
  (declare (salience -10))
  ?f <- (faza 3)
  ?a <- (buffer ? ? $?)
  ?b <- (saved-vector $?all)
  =>
  (printout t "fail " $?all crlf)
  (retract ?a ?b ?f)
  (assert (faza 2))
)

(defrule success-buffer
  (faza 3)
  ?a <- (buffer ?)
  (saved-vector $?all)
  =>
  (retract ?a)
  (printout t "sorted: " $?all crlf)
)





