(deffacts faptele-mele
  (stack A 10 1 2 3 4 5 6 7 8 9 10)
  (stack B 0)
  (stack C 0)
  (start)
; (move <id> <sou> <dest>)
; (hanoi <id> <nr> <sou> <dest> <rez>) 
; (calls <id1> <id2> ... <idk>)
)

; procedure hanoi(n, sou, dest, rez)
; if (n==1 then move (sou, dest);
; else { hanoi(n-1, sou, rez, dest);
;        move(sou, dest);
;        hanoi(n-1, rez, dest, sou);
;      }

(defrule move 
  (declare (salience 10))
  ?c <- (calls ?id $?rest-ids)
  ?m <- (move ?id ?sou ?dest)
  ?s1 <- (stack ?sou ?n-sou ?top $?rest)
  ?s2 <- (stack ?dest ?n-dest $?discs-dest)
  =>
  (retract ?c ?m ?s1 ?s2)
  (printout t "muta disc din " ?sou " in " ?dest crlf)
  (assert (stack ?sou (- ?n-sou 1) $?rest)
          (stack ?dest (+ ?n-dest 1) ?top $?discs-dest)
          (calls $?rest-ids))
)

(defrule hanoi-1
  (calls ?id $?rest-ids)
  ?h <- (hanoi ?id 1 ?sou ?dest ?rez)
  =>
  (retract ?h)
  (assert (move ?id ?sou ?dest))
)

(defrule hanoi-n
  ?c <- (calls $?beg ?id $?end)
  ?h <- (hanoi ?id ?nr&:(neq ?nr 1) ?sou ?dest ?rez)
  =>
  (retract ?h ?c)
  (bind ?x (gensym))
  (bind ?z (gensym))
  (assert (hanoi ?x (- ?nr 1) ?sou ?rez ?dest)
          (move ?id ?sou ?dest)
          (hanoi ?z (- ?nr 1) ?rez ?dest ?sou)
          (calls $?beg ?x ?id ?z $?end))
 )
 
(defrule init
  ?s <- (start)
  =>
  (retract ?s)
  (assert (hanoi id1 10 A B C)
          (calls id1)
          (time0 (time)))
)

(defrule final
  (calls)
  (time0 ?t0)
  =>
  (printout t "Durata: " (- (time) ?t0) crlf)
)


  
  


