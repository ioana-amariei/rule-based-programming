;doua fapte care contin niste liste de numere
;nici un pattern nu poate avea pe prima pozitie un wildcard
;faptele nu au un tip anume, dar sunt etichetate de prima eticheta
(deffacts liste
	(lista 1 2)
	(lista 5 8 3)
)

;regula ce afiseaza continutul listelor curente
; $? - wildcard ce se potriveste peste mai multe campuri
: ? - wildcard ce se potriveste peste un camp
;(defrule afiseaza-lista
;	(lista $?all)
;	=>
;	(printout t $?all crlf)
;)


; motorul de inferente este algoritmul nostru
; noi trebuie sa ghidam motorul de inferente
; diferit de programarea iterativa


; regula ce parcurge o lista element cu element
(defrule parcurge-lista
	(lista $? ?n $?)
	=>
	(printout t ?n " ");
)