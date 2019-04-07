; sistem expert de simulare
; intrebam utilizatorul dimensiunea tablei
; cerem intrare pentru starea fiecarei celule
; intrebam daca simulam si urmatorul pas, etc

; retinem fiecare celula din matrice ca un fapt de genul acesta
(deftemplate celula
	(slot x)
	(slot y)
	(slot vecini) ; 8 reguli pentru fiecare vecin (adauga unu pentru fiecare vecin)
	(slot viu) ; actualizam starea celulei cu ce se va intampla la nivelul urmator
)

; etape
; 1 initializare matricii nivel prioritate
; 2 calculul numarului de vecini alt nivel de prioritate
; 3 calcul generatie urmatoare inca un nivel de prioritate
; reluare simulare (true -> pas 2, false-> exit)


; citim dimensiunea matricii
(defrule citire-dimensiune-matrice
	(not (initializare))
	=>
	(printout t "Numarul de linii: ")
	(bind ?linii (read))
	(printout t "Numarul de coloane: ")
	(bind ?coloane (read))
	(assert (matrice ?linii ?coloane))
	(assert (celula-curenta 1 1))
	(assert (initializare))
)


; initializare matriciei
(defrule initializare-matrice
	(matrice ?linii ?coloane)
	?a <-(celula-curenta ?linie&:(<= ?linie ?linii) ?coloana&: (<= ?coloana ?coloane))
	=>
	(retract ?a)
	(printout t "Introduce starea celulei " ?linie " " ?coloana ": ")
	(bind ?stare (read))
	(assert (celula (x ?linie) (y ?coloana) (vecini 0) (viu ?stare)))
	(assert (celula-curenta ?linie (+ ?coloana 1)))	
)


; trecere la linie nou
(defrule trecere-la-linie-noua
	(matrice ?linii ?coloane)
	?a <-(celula-curenta ?linie&:(<= ?linie ?linii) ?coloana)
	=>
	(retract ?a)
	(assert (celula-curenta (+ ?linie 1) 1))
)

; stergem faptele
(defrule sterge-fapte
	?a <- (matrice ?linii ?coloane)
	?b <- (celula-curenta ?linie&:(> ?linie ?linii) ?coloana)
	=>
	(retract ?a ?b)
)


; calcularea numarului de vecini pentru fiecare celula
(defrule verifica-vecin-stanga-sus
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 (- ?y 1))) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)	


(defrule verifica-vecin-sus
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 ?y)) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)	


(defrule verifica-vecin-dreapta-sus
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 (+ ?y 1))) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)	


(defrule verifica-vecin-dreapta
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 ?x )) (y ?y2&:(eq ?y2 (+ ?y 1))) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)	


(defrule verifica-vecin-dreapta-jos
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 (+ ?y 1))) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)	


(defrule verifica-vecin-jos
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 ?y)) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)	


(defrule verifica-vecin-stanga-jos
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 (- ?y 1))) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)	



(defrule verifica-vecin-stanga
	?a <- (celula (x ?x) (y ?y) (vecini ?n))
	(celula (x ?x2&:(eq ?x2 ?x)) (y ?y2&:(eq ?y2 (- ?y 1))) (viu 1))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n 1))))
)

; definirea meniu
(defrule meniu
	(not (optiune ?x))
	=>
	(printout t "1. Initializeaza matrice" crlf)

)