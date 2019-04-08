
; https://www.dcode.fr/game-of-life

(defrule meniu
	(not (optiune ?x))
	=>
	(printout t "1. Initializeaza matrice" crlf)
	(printout t "2. Mergi la generatia urmatoare" crlf)
	(printout t "5. Iesire" crlf)
    (assert (optiune (read)))
)

; template petnru fiecare celula din matrice
(deftemplate celula
	(slot x)
	(slot y)
	(slot vecini-vii) 
    (multislot vecini-procesati) ; lista identificatorilor vecinilor procesati (stanga sus: 1, sus: 2 etc)
	(slot stare) ; starea celulei 1 viu, 0 mort
)

(defrule citire-dimensiune-matrice
	?a <- (optiune 1)
	=>
	(printout t "Numarul de linii: ") (bind ?linii (read))
	(printout t "Numarul de coloane: ") (bind ?coloane (read))
	(assert (matrice ?linii ?coloane))
	(assert (celula-curenta 1 1))
)

(defrule initializare-matrice
	(matrice ?linii ?coloane)
	?a <-(celula-curenta ?linie&:(<= ?linie ?linii) ?coloana&: (<= ?coloana ?coloane))
	=>
	(retract ?a)
	(printout t "Introduce starea celulei " ?linie " " ?coloana ": ")
	(bind ?stare (read))
	(assert (celula (x ?linie) (y ?coloana) (vecini-vii 0) (vecini-procesati nil) (stare ?stare)))
	(assert (celula-curenta ?linie (+ ?coloana 1)))	
)

(defrule trecere-la-linie-noua
	(matrice ?linii ?coloane)
	?a <-(celula-curenta ?linie&:(<= ?linie ?linii) ?coloana)
	=>
	(retract ?a)
	(assert (celula-curenta (+ ?linie 1) 1))
)

(defrule sterge-fapte
	?a <- (matrice ?linii ?coloane)
	?b <- (celula-curenta ?linie&:(> ?linie ?linii) ?coloana)
	=>
	(retract ?b)
)

; reguli pentru calcularea numarului de vecini pentru fiecare celula

(defrule verifica-vecin-stanga-sus
    (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 1 $?)))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 (- ?y 1))) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 1)(stare ?stare)))
    (printout t "verifica-vecin-stanga-sus" crlf)
)	

(defrule verifica-vecin-sus
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 2 $?)))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 ?y)) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 2)(stare ?stare)))
    (printout t "verifica-vecin-sus" crlf)
)	


(defrule verifica-vecin-dreapta-sus
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 3 $?)))
	(celula (x ?x2&:(eq ?x2 (- ?x 1))) (y ?y2&:(eq ?y2 (+ ?y 1))) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 3)(stare ?stare)))
    (printout t "verifica-vecin-dreapta-sus" crlf)
)	


(defrule verifica-vecin-dreapta
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 4 $?)))
	(celula (x ?x2&:(eq ?x2 ?x)) (y ?y2&:(eq ?y2 (+ ?y 1))) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 4)(stare ?stare)))
    (printout t "verifica-vecin-dreapta" crlf)
)	

(defrule verifica-vecin-dreapta-jos
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 5 $?)))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 (+ ?y 1))) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 5)(stare ?stare)))
    (printout t "verifica-vecin-dreapta-jos" crlf)
)	


(defrule verifica-vecin-jos
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 6 $?)))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 ?y)) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 6)(stare ?stare)))
    (printout t "verifica-vecin-jos" crlf)
)	

(defrule verifica-vecin-stanga-jos
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 7 $?)))
	(celula (x ?x2&:(eq ?x2 (+ ?x 1))) (y ?y2&:(eq ?y2 (- ?y 1))) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 7)(stare ?stare)))
    (printout t "verifica-vecin-stanga-jos" crlf)
)	

(defrule verifica-vecin-stanga
  (optiune 2)
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n) (vecini-procesati $?vecini-procesati)(stare ?stare))
    (not (celula (x ?x) (y ?y) (vecini-procesati $? 8 $?)))
	(celula (x ?x2&:(eq ?x2 ?x)) (y ?y2&:(eq ?y2 (- ?y 1))) (stare ?stare-vecin))
	=>
	(retract ?a)
	(assert (celula (x ?x) (y ?y) (vecini-vii (+ ?n ?stare-vecin))(vecini-procesati $?vecini-procesati 8)(stare ?stare)))
    (printout t "verifica-vecin-stanga" crlf)
)



(defrule next-underpopulated-generation
    ?a <- (celula (x ?x) (y ?y) (vecini-vii ?n&:(< ?n 2))(vecini-procesati $?)(stare 1))
    (optiune 2)
    =>
    (modify ?a (stare 0))
    (printout t "Underpopulated: " ?x " " ?y crlf)
)

(defrule next-overpopulated-generation
    ?a <- (celula (x ?x) (y ?y) (vecini-vii ?n&:(> ?n 3))(vecini-procesati $?)(stare 1))
    (optiune 2)
    =>
    (modify ?a (stare 0))
    (printout t "Overpopulated: " ?x " " ?y crlf)
)


(defrule next-reproduced-generation
    ?a <- (celula (x ?x) (y ?y) (vecini-vii ?n&:(eq ?n 3))(vecini-procesati $?)(stare 0))
    (optiune 2)
    =>
    (modify ?a (stare 1))
    (printout t "Reproduced: " ?x " " ?y crlf)
)

(defrule remove-option2
    ?a <- (optiune 2)
    =>
    (retract ?a)
    (assert (optiune 4))
)

(defrule prepare-for-next-generation
	?a <- (celula (x ?x) (y ?y) (vecini-vii ?n)(vecini-procesati nil ? $?)(stare ?stare))
    ?b <- (optiune 4)
	=>
    (retract ?a)
    (assert (celula (x ?x) (y ?y) (vecini-vii 0)(vecini-procesati nil)(stare ?stare)))
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
	?b <- (celula (x ?x) (y ?y) (vecini-vii ?n)(vecini-procesati $?vp)(stare ?stare))
	=>
    (retract ?a)
	(printout t ?stare " ")
	(assert (celula-curenta-de-afisat ?x (+ ?y 1)))	
)

; trecere la linie nou pentru afisare matrice
(defrule next-line-2
    (optiune 4)
	(matrice ?linii ?coloane)
	?a <-(celula-curenta-de-afisat ?linie&:(<= ?linie ?linii) ?coloana)
	=>
	(retract ?a)
	(assert (celula-curenta-de-afisat (+ ?linie 1) 1))
    (printout t crlf)
)

(defrule sterge-fapte-afisare
	?a <- (matrice ?linii ?coloane)
	?b <- (celula-curenta-de-afisat ?linie&:(> ?linie ?linii) ?coloana)
	=>
	(retract ?b)
)

(defrule remove-option
    ?a <- (optiune ?x&:(< ?x 5))
    =>
    (retract ?a)
)