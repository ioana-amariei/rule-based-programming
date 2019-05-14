(deffacts baza
; (lego <id> <material> <culoare> <grosime> <arie> <forma>)

  (lego id1 lemn alb 3 20 cerc)
  (lego id2 lemn alb 4 10 patrat)
  (lego id3 lemn alb 5 30 cerc)
  (lego id4 lemn rosu 4 20 dreptunghi)
  (lego id5 lemn rosu 5 10 patrat)
  (lego id6 lemn galben 3 10 dreptunghi)
  (lego id7 plastic galben 5 8 cerc)
  (lego id8 plastic verde 3 20 patrat)
  (lego id9 plastic verde 3 10 dreptunghi)
  (lego id10 plastic alb 3 20 cerc)
  (lego id11 plastic albastru 4 20 patrat)
  (lego id12 plastic rosu 5 20 dreptunghi)
  (lego id13 plastic verde 5 30 dreptunghi)
  (selectie)
)

(defrule sel7 "cele mai groase piese dintre cele de aceeaşi arie"
  (declare (salience 10))
  (lego ? ? ? ? ?a $?)
  (not (grupa ?a $?))
  =>
  (assert (grupa ?a))
)

(defrule sel7-1
  (declare (salience 5))
  ?x <- (grupa ?a $?ceva)
  (lego ?id ? ? ? ?a $?)
  (test (not (member$ ?id $?ceva)))
  =>
  (retract ?x)
  (assert (grupa ?a $?ceva ?id))
)

(defrule sel7-2
  ?x <- (grupa ?a $? ?id1 $?)
  (grupa ?a $?beg ?id2 $?end)
  (lego ?id1 ? ? ?g1 ?a $?)
  (lego ?id2 ? ? ?g2&:(< ?g2 ?g1) ?a $?)
  =>
  (retract ?x)
  (assert (grupa ?a $?beg $?end))
)


  