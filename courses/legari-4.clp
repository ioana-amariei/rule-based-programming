(deffacts faptele-mele
  (alpha a b c)
  (beta e b a)
)
(defrule rule4 "legare ambigua"
  (alpha $? ?x $?)
  (beta $?beg ?x $?end)
  =>
  (printout t "x= " ?x) 
  (printout t "$?beg= " $?beg "$?end= " $?end crlf))
 