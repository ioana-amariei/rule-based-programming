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

(defrule init
  (not (term-fr $?))
  =>
  (printout t "tree: ")
  (bind ?tree (read))
  (printout t "root: ")
  (bind ?root (read))
  (assert (term-fr ?tree ?root))
)

 (defrule term-fr-left
  ?a <- (term-fr ?tree $?beg ?n $?end)
  (node (tree ?tree) (name ?n) (left ?l&:(neq ?l nil)) (right nil))
  =>
  (retract ?a)
  (assert (term-fr ?tree $?beg ?l $?end))
)

 (defrule term-fr-right
  ?a <- (term-fr ?tree $?beg ?n $?end)
  (node (tree ?tree) (name ?n) (left nil) (right ?r&:(neq ?r nil)))
  =>
  (retract ?a)
  (assert (term-fr ?tree $?beg ?r $?end))
)

 (defrule term-fr-left-right
  ?a <- (term-fr ?tree $?beg ?n $?end)
  (node (tree ?tree) (name ?n) (left ?l&:(neq ?l nil)) (right ?r&:(neq ?r nil)))
  =>
  (retract ?a)
  (assert (term-fr ?tree $?beg ?l ?r $?end))
)


          
  
 
 