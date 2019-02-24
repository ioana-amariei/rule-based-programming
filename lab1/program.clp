(deffacts fapte
    (minge rosie)
    (minge mare)
)

(defrule unu
    (mare)
    =>
    (assert (rosie))
)

(defrule doi
    (minge mare)
    =>
    (assert (mare))
)
