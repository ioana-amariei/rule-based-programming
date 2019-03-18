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

; parcurgerea arborelui in ordine BFS

(defrule init
  (not (list-BFS $?))
  =>
  (printout t "tree: ")
  (bind ?tree (read))
  (printout t "root: ")
  (bind ?root (read))
  (assert (queue ?root) (list-BFS))
)

(defrule BFS
  ?a <- (queue $?beg ?e)
  ?b <- (list-BFS $?list)
  (node (name ?e) (left ?l) (right ?r))
  (test (not (member$ ?e $?list)))
  =>
  (retract ?a ?b)
  (assert (queue ?r ?l $?beg)
          (list-BFS $?list ?e))
)

(defrule BFS-delete-nil
  (declare (salience 10))
  ?a <- (queue $?rest nil)
  =>
  (retract ?a)
  (assert (queue $?rest))
)

