(deffacts faptele-mele
  (alpha a b c)
)
(defrule rule3 "legare ambigua"
  (alpha $? ?x $?)
  =>
  (printout t "x=" ?x crlf)
)
 
 
 