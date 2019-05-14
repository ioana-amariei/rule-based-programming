; reprezentarea unui arbore
; un arbore binar
(deftemplate node
  (slot tree)
  (slot name)
  (slot right)
  (slot left)
)

(deffacts my-tree 
  (node (tree T1) (name A) (left B) (right C))
  (node (tree T1) (name B) (left D) (right E))
  (node (tree T1) (name C))
  (node (tree T1) (name D))
  (node (tree T1) (name E) (left SS) (right G))
  (node (tree T1) (name SS))
  (node (tree T1) (name G))
  (node (tree T2) (name SS) (left B2) (right C2))
  (node (tree T2) (name B2) (left D2) (right E2))
  (node (tree T2) (name C2) (left F2) (right G2))
  (node (tree T2) (name D2))
  (node (tree T2) (name E2))
  (node (tree T2) (name F2))
  (node (tree T2) (name G2))
  (tree T2 A2)
)   

(deffacts data
  (term)
  (faza 1)
)

(defrule input
  ?a <- (term)
  (faza 1)
  =>
  (retract ?a)
  (printout t "Numele arborelui? => ") 
  (bind ?tree (read))
  (printout t "Numele nodului? => ") 
  (bind ?rad (read))
  (assert (term ?tree ?rad))
)

(defrule subst
  (term ?t ?)
  ?b <- (faza 1)
  ?a <- (node (tree ?t) (name SS))
  (node (tree ?t1&:(neq ?t1 ?t)) (name SS) (left ?l) (right ?r))
  =>
  (retract ?a ?b)
  (assert (node (tree ?t) (name SS) (left ?l) (right ?r)) (faza 2))
)

(defrule term-fr-init
  (faza 2)
  (term ?tree ?rad)
  =>
  (assert (frontier ?rad))
)
  
(defrule term-fr-left-right
  (faza 2)
  ?a <- (frontier $?beg ?x $?end)
  (node (tree ?t) (name ?x) (left ?l&:(neq ?l nil)) (right ?r&:(neq ?r nil)))
  =>
  (retract ?a)
  (assert (frontier $?beg ?l ?r $?end))
)

(defrule term-fr-left
  (faza 2)
  ?a <- (frontier $?beg ?x $?end)
  (node (tree ?t) (name ?x) (left ?l&:(neq ?l nil)) (right nil))
  =>
  (retract ?a)
  (assert (frontier $?beg ?l $?end))
)

(defrule term-fr-right
  (faza 2)
  ?a <- (frontier $?beg ?x $?end)
  (node (tree ?t) (name ?x) (left nil) (right ?r&:(neq ?r nil)))
  =>
  (retract ?a)
  (assert (frontier $?beg ?r $?end))
)

(defrule print
  (declare (salience -10))
  (faza 2)
  (frontier $?nodes)
  =>
  (printout t "Frontiera este: " $?nodes crlf)
)


  