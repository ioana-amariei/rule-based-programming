(deffacts faptele-mele
  (alpha a b c d e)
)
(defrule power-set "genereaza multimea submultimilor"
  (alpha $?beg ?x $?end)
=>
  (assert (alpha $?beg $?end))
  (printout t $?beg " " $?end crlf)
) 
 