(deffacts faptele-mele
  (alpha a b c)
)
(defrule rule1 "legare neambigua"
  (alpha ?x $?)
  =>
  (printout t "x=" ?x crlf)
)
 
 
 