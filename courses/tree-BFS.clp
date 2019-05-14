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
  (BFS-list)
)   

(defrule input
  ?a <- (BFS-list)
  =>
  (retract ?a)
  (printout t "Numele arborelui? => ") 
  (bind ?tree (read))
  (printout t "Numele nodului? => ") 
  (bind ?rad (read))
  (assert (BFS-list ?tree)
          (queue ?rad))
)

(defrule BFS
  ?a <- (queue $?beg ?n)
  ?b <- (BFS-list ?t $?ceva)
  (node (tree ?t) (name ?n) (left ?l) (right ?r))
  =>
  (retract ?a ?b)
  (assert (queue ?l ?r $?beg)
          (BFS-list ?t $?ceva ?n))
)

(defrule delete-nil
  (declare (salience 10))
  ?a <- (queue nil $?rest)
  =>
  (retract ?a)
  (assert (queue $?rest))
)
