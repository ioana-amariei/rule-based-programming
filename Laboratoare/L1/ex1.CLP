(deffacts fapte
	(mar rosu)
	(mar mare)	
)

(defrule reg1
	(mar rosu)
	=>
	(assert (culoare))
) 

(defrule reg2
	(culoare)
	=>
	(assert (bine))
)
	
(defrule reg3
	(mar rosu)
	=>
	(assert (ok))
)	
