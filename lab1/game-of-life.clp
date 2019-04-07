; sistem expert de simulare
; intrebam utilizatorul dimensiunea tablei
; cerem intrare pentru starea fiecarei celule
; intrebam daca simulam si urmatorul pas, etc

; retinem fiecare celula din matrice ca un fapt de genul acesta
(deftemplate celula
	(slot x)
	(slot y)
	(slot vecini) ; 8 reguli pentru fiecare vecin (adauga unu pentru fiecare vecin)
    (multislot vecini-procesati)
	(slot viu) ; actualizam starea celulei cu ce se va intampla la nivelul urmator
)

; etape
; 1 initializare matricii nivel prioritate
; 2 calculul numarului de vecini alt nivel de prioritate
; 3 calcul generatie urmatoare inca un nivel de prioritate
; reluare simulare (true -> pas 2, false-> exit)


; citim dimensiunea matricii
(defrule citire-dimensiune-matrice
	?a <- (optiune 1)
	=>
	(printout t "Numarul de linii: ")
	(bind ?linii (read))
	(printout t "Numarul de coloane: ")
	(bind ?coloane (read))
	(assert (matrice ?linii ?coloane))
	(assert (celula-curenta 1 1))
    ; (retract ?a)
)


; initializare matriciei
(defrule initializare-matrice
	(matrice ?linii ?coloane)
	?a <-(celula-curenta ?linie&:(<= ?linie ?linii) ?coloana&: (<= ?coloana ?coloane))
	=>
	(retract ?a)
	(printout t "Introduce starea celulei " ?linie " " ?coloana ": ")
	(bind ?stare (read))
	(assert (celula (x ?linie) (y ?coloana) (vecini 0) (vecini-procesati nil) (viu ?stare)))
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
	;(retract ?a ?b)
	(retract ?b)
)


; calcularea numarului de vecini pentru fiecare celula
(defrule verifica-vecin-stanga-sus
    (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 1 $?)))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 (- ?y 1))) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 1)(viu ?viu)))
    (printout t "verifica-vecin-stanga-sus" crlf)
    ; (modify ?a (vecini (+ ?n 1)))
)	


(defrule verifica-vecin-sus
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 2 $?)))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 ?y)) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 2)(viu ?viu)))
    (printout t "verifica-vecin-sus" crlf)
    ; (modify ?a (vecini (+ ?n 1)))
)	


(defrule verifica-vecin-dreapta-sus
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 3 $?)))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 (+ ?y 1))) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 3)(viu ?viu)))
    (printout t "verifica-vecin-dreapta-sus" crlf)
    ;(modify ?a (vecini (+ ?n 1)))
)	


(defrule verifica-vecin-dreapta
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 4 $?)))
	(celula (x ?x2&:(eq ?x2 ?x)) (y ?y2&:(eq ?y2 (+ ?y 1))) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 4)(viu ?viu)))
    (printout t "verifica-vecin-dreapta" crlf)
    ;(modify ?a (vecini (+ ?n 1)))
)	

(defrule verifica-vecin-dreapta-jos
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 5 $?)))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 (+ ?y 1))) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 5)(viu ?viu)))
    (printout t "verifica-vecin-dreapta-jos" crlf)
    ;(modify ?a (vecini (+ ?n 1)))
)	


(defrule verifica-vecin-jos
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 6 $?)))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 ?y)) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 6)(viu ?viu)))
    (printout t "verifica-vecin-jos" crlf)
    ;(modify ?a (vecini (+ ?n 1)))
)	

(defrule verifica-vecin-stanga-jos
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 7 $?)))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 (- ?y 1))) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 7)(viu ?viu)))
    (printout t "verifica-vecin-stanga-jos" crlf)
    ;(modify ?a (vecini (+ ?n 1)))
)	

(defrule verifica-vecin-stanga
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini ?n) (vecini-procesati $?vecini-procesati)(viu ?viu))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 8 $?)))
	(celula (x ?x2&:(eq ?x2 ?x)) (y ?y2&:(eq ?y2 (- ?y 1))) (viu ?v))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini (+ ?n ?v))(vecini-procesati $?vecini-procesati 8)(viu ?viu)))
    (printout t "verifica-vecin-stanga" crlf)
    ;(modify ?a (vecini (+ ?n 1)))
)

; definirea meniu
(defrule meniu
	(not (optiune ?x))
	=>
	(printout t "1. Initializeaza matrice" crlf)
	(printout t "2. Mergi la generatia urmatoare" crlf)
	(printout t "3. Iesire" crlf)
    (assert (optiune (read)))
)

(defrule next-underpopulated-generation
    ?a <- (celula (x ?x) (y ?y) (vecini ?n&:(< ?n 2))(vecini-procesati $?)(viu 1))
    (optiune 2)
    =>
    (modify ?a (viu 0))
    (printout t ?x " " ?y crlf)
)

(defrule next-overpopulated-generation
    ?a <- (celula (x ?x) (y ?y) (vecini ?n&:(> ?n 3))(vecini-procesati $?)(viu 1))
    (optiune 2)
    =>
    (modify ?a (viu 0))
    (printout t ?x " " ?y crlf)
)


(defrule next-reproduced-generation
    ?a <- (celula (x ?x) (y ?y) (vecini ?n&:(eq ?n 3))(vecini-procesati $?)(viu 0))
    (optiune 2)
    =>
    (modify ?a (viu 1))
    (printout t ?x " " ?y crlf)
)

; (defrule prepare-for-next-generation
; 	?a <- (celula (x ?x) (y ?y) (vecini ?n)(vecini-procesati 8)(viu ?))
;     ?b <- (optiune 2)
; 	=>
;     (retract ?b)
;     (modify ?a (vecini-procesati nil))
; )

(defrule remove-option2
    ?a <- (optiune 2)
    =>
    (retract ?a)
    (assert (optiune 4))
)

(defrule prepare-for-next-generation
	?a <- (celula (x ?x) (y ?y) (vecini ?n)(vecini-procesati nil ? $?)(viu ?v))
    ?b <- (optiune 4)
	=>
    (retract ?a)
    (assert (celula (x ?x) (y ?y) (vecini 0)(vecini-procesati nil)(viu ?v)))
)

(defrule afisare-inceput
    (optiune 4)
    (matrice ?linii ?coloane)
    =>
    (assert (celula-curenta-de-afisat 1 1))
)

(defrule afisare-stare
    (optiune 4)
	(matrice ?linii ?coloane)
    ?a <- (celula-curenta-de-afisat ?x ?y)
	?b <- (celula (x ?x) (y ?y) (vecini ?n)(vecini-procesati $?vp)(viu ?v))
	=>
    (retract ?a)
	(printout t ?v " ")
	(assert (celula-curenta-de-afisat ?x (+ ?y 1)))	
)


; trecere la linie nou
(defrule next-line-2
    (optiune 4)
	(matrice ?linii ?coloane)
	?a <-(celula-curenta-de-afisat ?linie&:(<= ?linie ?linii) ?coloana)
	=>
	(retract ?a)
	(assert (celula-curenta-de-afisat (+ ?linie 1) 1))
    (printout t crlf)
)

; stergem faptele
(defrule sterge-fapte-afisare
	?a <- (matrice ?linii ?coloane)
	?b <- (celula-curenta-de-afisat ?linie&:(> ?linie ?linii) ?coloana)
	=>
	;(retract ?a ?b)
	(retract ?b)
)


(defrule remove-option
    ?a <- (optiune ?x&:(< ?x 5))
    =>
    (retract ?a)
)