(deffacts lista
    (lista 3 5  2 1)
)

(defrule iterez
    (lista $? ?x $?)
    =>
    (printout t ?x crlf)
)