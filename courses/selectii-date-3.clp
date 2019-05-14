(deffacts baza
; (lego <id> <material> <culoare> <grosime> <arie> <forma>)

  (lego id1 lemn alb 3 20 cerc)
  (lego id2 lemn alb 4 10 patrat)
  (lego id3 lemn alb 5 30 cerc)
  (lego id4 lemn rosu 3 20 dreptunghi)
  (lego id5 lemn rosu 5 10 patrat)
  (lego id6 lemn galben 3 10 dreptunghi)
  (lego id7 plastic galben 5 8 cerc)
  (lego id8 plastic verde 3 12 patrat)
  (lego id9 plastic verde 3 15 dreptunghi)
  (lego id10 plastic alb 4 20 cerc)
  (lego id11 plastic albastru 4 25 patrat)
  (lego id12 plastic rosu 5 20 dreptunghi)
  (lego id13 plastic verde 5 30 dreptunghi)
  (selectie)
)

(defrule sel3 "grosimea strict mai mică de 5 unităţi, dar diferită de 4"
  (lego ?id ? ? ?g&:(and (< ?g 5) (<> ?g 4)) $?)
  ?s <- (selectie $?comb)
  (test (not (member$ ?id $?comb)))
  =>
  (retract ?s)
  (assert (selectie $?comb ?id))
)

