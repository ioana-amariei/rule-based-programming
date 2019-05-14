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
  (node (tree T1) (name E) (left F) (right G))
  (node (tree T1) (name F))
  (node (tree T1) (name G))
  (node (tree T2) (name A2) (left B2) (right C2))
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
)

(defrule input
  ?a <- (term)
  =>
  (retract ?a)
  (printout t "Numele arborelui? => ") 
  (bind ?tree (read))
  (printout t "Numele nodului? => ") 
  (bind ?rad (read))
  (assert (term ?tree ?rad))
)

(defrule fr-right
  ?a <- (term ?t $?beg ?down)
  (node (tree ?t) (name ?down) (right ?r&:(neq ?r nil)))
  =>
  (retract ?a)
  (assert (term ?t $?beg ?down ?r))
)

(defrule print
  (declare (salience -10))
  (term ? $?all)
  =>
  (printout t "Frontiera dreapta: " $?all crlf)
)
