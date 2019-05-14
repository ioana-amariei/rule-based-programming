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
  (lego id9 plastic verde 5 10 dreptunghi)
  (lego id10 plastic alb 3 20 cerc)
  (lego id11 plastic albastru 4 20 patrat)
  (lego id12 plastic rosu 5 20 dreptunghi)
  (lego id13 plastic verde 5 30 dreptunghi)
  (lego id14 plastic verde 5 10 cerc)
)

(defrule sel7 "cele mai groase piese dintre cele de aceeaşi forma"
; mai intai fac atatea grupe cate forme distincte sunt
; incluzand in grupe id-urile primelor piese gasite de respectiva forma
;  (declare (salience 10))
  (lego ?id ? ? ? ? ?f)
  (not (grupa ?f $?))
  =>
  (assert (grupa ?f ?id))
)

(defrule sel7-1 "includ intr-o grupa o piesa mai grosa decat cele de acolo"
; in grupe asignata unei forme vor fi notate toate id-urile pieselor de grosime maxima  
  ?x <- (grupa ?a ?id $?)
  (lego ?id ? ? ?g ? ?f)
  (lego ?id-new ? ? ?g-new&:(> ?g-new ?g) ? ?f)
  =>
  (retract ?x)
  (assert (grupa ?f ?id-new))
)

(defrule sel7-2 "includ intr-o grupa o piesa de grosime egala cu cea mai groasa"
  ?x <- (grupa ?a ?id $?) 
; imi trebuie un id oarecare din grupa ca sa identific grosimea maxima
; (aceeasi pt toate piesele din grupa)
  (grupa ?a $?all-ids)
  (lego ?id ? ? ?g ? ?f)
  (lego ?id-new ? ? ?g ? ?f)
  (test (not (member$ ?id-new $?all-ids)))
  =>
  (retract ?x)
  (assert (grupa ?f $?all-ids ?id-new))
)
