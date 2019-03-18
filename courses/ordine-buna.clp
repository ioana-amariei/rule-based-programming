; Importanta ordinii patternurilor in viteza de aprindere a regulilor
; Asezarea eficienta

(deffacts fapte
  (fapt a)
  (fapt b)
  (fapt c)
  (fapt d)
  (fapt e)
  (fapt f)
  (fapt g)
  (fapt h)
  (combinatii a b c d e f g h)
  (start)
)

(defrule start
  ?s <- (start)
  =>
  (retract ?s)
  (assert (start (time)))
)

(defrule r2
  (start ?t0)
  (combinatii ?a ?b ?c ?d ?e ?f ?g ?h)
  (fapt ?a)
  (fapt ?b)
  (fapt ?c)
  (fapt ?d)
  (fapt ?e)
  (fapt ?f)
  (fapt ?g)
  (fapt ?h)
  =>
  (printout t "timp = " (- (time) ?t0) crlf)
)



 