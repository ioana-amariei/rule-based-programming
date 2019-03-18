(deftemplate node
  (slot name)
  (multislot daughters)
)

(deffacts date
  (node (name A) (daughters B C))
  (node (name B) (daughters NO))
  (node (name C) (daughters D E))
  (node (name D) (daughters NO))
  (node (name E) (daughters F))
  (node (name F) (daughters NO))
  (stack A)
  (terminal)
)

(defrule no-daughters
  (declare (salience 10))
  ?s <- (stack ?top $?rest)
  ?t <- (terminal $?fr)
  (node (name ?top) (daughters NO))
  =>
  (retract ?s ?t)
  (assert (stack $?rest)
          (terminal ?top $?fr))
)

(defrule with-daughters
  ?s <- (stack ?top $?rest)
  ?n <- (node (name ?top) (daughters $?d))
  =>
  (retract ?s)
  (modify ?n (daughters NO))
  (assert (stack $?d $?rest))
)

(defrule print
  (stack)
  (terminal $?fr)
  =>
  (printout t $?fr crlf)
)
