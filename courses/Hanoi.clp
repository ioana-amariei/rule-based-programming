(deffacts stive
  (stack A 1 2 3 4)
  (stack B)
  (stack C)
  (nd 4)
)

(deffacts date
  (calls)
)

(defrule Hanoi-init
  ?a <- (calls)
  (nd ?n)
  =>
  (bind ?id (gensym))
  (retract ?a)
  (assert (Hanoi ?id ?n A B C)
          (calls ?id))
)

(defrule Hanoi-move
  ?a <- (calls ?id $?rest)
  ?b <- (move ?id ?start ?dest)
  ?c <- (stack ?start ?top $?alte-start)
  ?d <- (stack ?dest $?alte-dest)
  =>
  (retract ?a ?b ?c ?d)
  (printout t "mode disk from " ?start " to " ?dest crlf)
  (assert (calls $?rest)
          (stack ?start $?alte-start)
          (stack ?dest ?top $?alte-dest))
)

(defrule Hanoi-stop
  ?a <- (calls $?beg ?id $?end)
  ?b <- (Hanoi ?id 1 ?start ?dest ?)
  =>
  (retract ?a ?b)
  (bind ?id1 (gensym))
  (assert (move ?id1 ?start ?dest)
          (calls $?beg ?id1 $?end))
)

(defrule Hanoi-rec
  ?a <- (calls $?beg ?id $?end)
  ?b <- (Hanoi ?id ?n ?start ?dest ?rez)
  =>
  (retract ?a ?b)
  (bind ?id1 (gensym))
  (bind ?id2 (gensym))
  (bind ?id3 (gensym))
  (assert (Hanoi ?id1 (- ?n 1) ?start ?rez ?dest)
          (move ?id2 ?start ?dest)
          (Hanoi ?id3 (- ?n 1) ?rez ?dest ?start)
          (calls $?beg ?id1 ?id2 ?id3 $?end)
  )
)


  
  