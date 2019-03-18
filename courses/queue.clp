; simularea unei cozi

(deffacts date
  (queue a b s c d)
)

(defrule IN-queue
  ?a <- (queue $?list)
  ?b <- (elem ?e)
  =>
  (retract ?a ?b)
  (assert (queue ?e $?list))
)

(defrule OUT-queue
  ?a <- (queue $?list ?e)
  (not (elem ?))
  =>
  (retract ?a)
  (assert (queue $?list) (elem ?e))
)
  
  