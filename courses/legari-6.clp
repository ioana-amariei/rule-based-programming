(deffacts faptele-mele
  (alpha a b c)
  (alpha e b a)
  (beta e b a)
)
(defrule rule6 "legare ambigua"
  (alpha $? ?x $?)
  (beta $?beg ?x $?end)
  =>
  (printout t "x= " ?x) 
  (printout t " $?beg= " $?beg " $?end= " $?end crlf))
 