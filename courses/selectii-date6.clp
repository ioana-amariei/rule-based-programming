(deffacts baza
; (lego <id> <material> <culoare> <grosime> <arie> <forma>)

  (lego id1 lemn alb 3 20 cerc)
  (lego id2 lemn alb 4 10 patrat)
  (lego id3 lemn alb 5 30 cerc)
  (lego id4 lemn rosu 6 20 dreptunghi)
  (lego id5 lemn rosu 5 10 patrat)
  (lego id6 lemn galben 3 10 dreptunghi)
  (lego id6 lemn verde 3 10 dreptunghi)
  (lego id7 plastic galben 5 8 cerc)
  (lego id8 plastic verde 3 12 patrat)
  (lego id9 plastic verde 3 15 dreptunghi)
  (lego id10 plastic alb 4 20 cerc)
  (lego id11 plastic albastru 4 25 patrat)
  (lego id12 plastic rosu 5 20 dreptunghi)
  (lego id13 plastic verde 4 30 dreptunghi)
)

(defrule sel6 "cele mai groase piese dintre cele de aceeaşi arie   "
  (lego ?id ? ? ?g ?a $?)
  (not (grupa ?a ? ?))
  =>
  (assert (grupa ?a ?g ?id))
)

(defrule sel6-1
  ?s <- (grupa ?a ?g1 ?)
  (lego ?id ? ? ?g2&:(> ?g2 ?g1)  ?a $?)
  =>
  (retract ?s)
  (assert (grupa ?a ?g2 ?id))
)

