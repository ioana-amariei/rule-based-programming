(deffacts faptele-mele(alpha a b c)
(alpha e b a))
(defrule rule3 "legare ambigua"(alpha $? ?x $?)
=>
(printout t "x= ?" x crlf))