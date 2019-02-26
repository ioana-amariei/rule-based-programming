(deffacts studenti
    (student Ionel IA 10 PBR 4)
    (student Gigel IA 7)    
)

(defrule nume_studenti
    (student ?x $?)
    =>
    (printout t "Student: " ?x crlf)
)

