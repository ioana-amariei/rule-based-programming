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

; parcurgerea arborelui in ordine DFS

(defrule init
  (not (list-DFS $?))
  =>
  (printout t "tree: ")
  (bind ?tree (read))
  (printout t "root: ")
  (bind ?root (read))
  (assert (stack ?root) (list-DFS))
)

(defrule DFS
  ?a <- (stack ?top $?rest)
  ?b <- (list-DFS $?list)
  (node (name ?top) (left ?l) (right ?r))
  (test (not (member$ ?top $?list)))
  =>
  (retract ?a ?b)
  (assert (stack ?l ?r $?rest)
          (list-DFS $?list ?top))
)

(defrule DFS-delete-nil
  (declare (salience 10))
  ?a <- (stack nil $?rest)
  =>
  (retract ?a)
  (assert (stack $?rest))
)

