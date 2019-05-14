(deffacts date
  (vector 4 2 -3 -5 7 11 22 98 100)
)

(defrule init-max
  (not (max ?))
  ?a <- (vector ?x $?rest)
  =>
  (assert (max ?x)
          (vector $?rest))
)

(defrule compute-max
  ?a <- (vector ?x $?rest)
  ?b <- (max ?y&:(> ?x ?y))
  =>
  (retract ?a ?b)
  (assert (vector $?rest)
          (max ?x))
)

 (defrule compute-max-2
   (declare (salience -10))
   ?a <- (vector ?x $?rest)
   =>
   (retract ?a)
   (assert (vector $?rest))
 )
 
  