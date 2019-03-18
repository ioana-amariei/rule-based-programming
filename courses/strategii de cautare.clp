; Strategii de aprindere a regulilor

(deffacts date
  (fapt a)
)

; daca se alege ordinea de aprindere BFS, 
; atunci ambele fapte b si c trebuie sa se regaseasca in baza.

(defrule fire-1
  (fapt a)
  =>
  (assert (fapt b))
)

(defrule fire-2
  (fapt a)
  =>
  (assert (fapt c))
)

(defrule stop-1
  (declare (salience 10))
  (fapt b)
  (fapt c)
  =>
  (printout t "BFS" crlf)
  (halt)
)

; daca se alege ordinea de aprindere DFS, 
; atunci doar faptul c trebuie sa se regaseasca in baza.

(defrule fire-3
  (fapt b)
  =>
  (assert (fapt d))
)

(defrule stop-2
  (declare (salience 10))
  (fapt d)
  =>
  (printout t "DFS" crlf)
  (halt)
)



