(deffacts faptele-mele(alpha a b c d e)
)
(defrule rule3 "legare ambigua"(alpha $?beg ? $?end)
=>
(assert (alpha $?beg $?end))
)