; simularea unei stive

(deffacts date
  (stack a b s c d)
)

(defrule PUSH
  ?a <- (stack $?list)
  ?b <- (elem ?e)
  =>
  (retract ?a ?b)
  (assert (stack ?e $?list))
)

(defrule POP
  ?a <- (stack ?top $?list)
  (not (elem ?))
  =>
  (retract ?a)
  (assert (stack $?list) (elem ?top))
)
  
  