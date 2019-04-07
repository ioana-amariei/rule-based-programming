; informatii despre studenti
(deffacts fapte
	(student Ion IA 9)
	(student Ion PBR 10)
	(student Maria IA 10)
)

; regula care afiseaza un mesaj de fiecare data cand gaseste o nota de 10
;(defrule nota-10
;	(student ? ? 10)
;	=>	
;	(printout t "Nota 10" crlf)
;)

; (student 10) nu se potriveste deoarece trebuie sa inlocuiasca fix un camp
; ordinea in care apar activarile este ordinea inversa declararii faptelor


; vrem sa afisam numele studentilor care au nota 10
;(defrule nume-studenti-cu-nota-10
;	(student ?nume ? 10)
;	=>
;	(printout t ?nume crlf)
;)


; afisez studentii care nu au note la PBR
(defrule fara-nota-la-PBR
	(student ?nume ? ?)
	(not (student ?nume PBR ?))
	=>
	(printout t "dati nota pentru: " ?nume crlf)
	(assert (student ?nume PBR (read)))
)


; 'read' citeste o valoare de la tastatura (un field) 10 nota 10 => 10
; pentru mai multe campuri (read 1)...(read n) sau readline => citeste un string, nu o valoare
; exista functii pentru string in CLIPS sau cautam folosind patternuri
