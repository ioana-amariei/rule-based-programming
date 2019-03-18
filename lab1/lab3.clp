; putem preciza valori default
; in clips-ul curent pune default nil pe toate sloturile
(deftemplate student
    (slot nume)
    (multislot note_lab)
    (slot nota_proiect)
    (slot nota_examen)
)

(deffacts studenti
    (student (nume Ionel))
    (student (nota_proiect 10) (nume Gigel))
)

; nu ma intereseaza decat numele, nu si celelalte sloturi
(defrule nume_studenti
    (student (nume ?x))
    =>
    (printout t ?x crlf)
)

; fara not -> pattern
; cu not conditie booleana, la fel test
(defrule adauga_proiect
    ?a <- (student (nume ?x))
    ; (not (student (nume ?x) (nota_proiect ?)))
    (student (nume ?x) (nota_proiect nil))
    =>
    (modify ?a (nota_proiect (read)))
)

(test (> ?x 5))

; toate faptele care se potrivesc cu prima conditie tb sa satisfaca si pe a 2-a
(forall ((student (nume ?)) (student (nota_proiect ?)))

; se activeaza cel mult o data, limitez la o singura activare
; (exists)

(meniu)

(defrule afiseaza_meniu
    ?a <- (meniu)
    =>
    (printout t crlf)
    (retract ?a)
    (assert optiune (read))
)

; apoi creez cu assert din nou meniu




