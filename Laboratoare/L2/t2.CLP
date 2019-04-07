; meniu CLIPS
; ne intereseaza mecanismul (un fel de bucla)
; daca exista un fapt optiune atunci nu afisez meniul, altfel da
; (assert (optiune (read)))
; stergere fapt (retract)
; ?x <-(optiune 1)
; (retract ?x)
; fapte a, b, c, d......fielduri x, y, z...
; (not (optiune ?))

; ultima regula care termina optiunea 1 trebuie sa stearga faptul optiunea 1, adaugata anterior din meniu
; definesc un set de reguli pentru fiecare optiune existenta, iar la sfarsit sterg optiunea
; din meniu creez optiunea aferenta

; exista un singur student cu nota 10 la PBR
;(student ?nume PBR 10)
;(not (student ?y&: (neq ?y ?nume) PBR 10))



; definim sabonul pentru un fapt de tip film
(deftemplate film
	(multislot titlu)
	(multislot regizori)
	(multislot actori)
	(slot gen)
)

;definim cateva fapte de tip film
(deffacts filme-cunoscute
	(film (titlu "Iron Man") (regizori "Michael Jackson") (actori "Vaca alba" "Caine turbat") (gen comedie))
	(film (titlu "Iron Man 2") (regizori "Michael Jackson") (actori "O Pisica") (gen drama))
	(film (titlu "Iron Man 3") (regizori "Michael Jackson") (actori "Un Caine" "O Pisica Turbata") (gen romance))
	(film (titlu "San Andreas") (regizori "Ileana") (actori "Un Sarpe" "MoChisa") (gen actiune))
	(film (titlu "Academia de Politie") (regizori "Audrey Gigel" "Pisica Americana") (actori "Hilo Holilo" "Placintescu Andrei") (gen drama))
)


; meniu principal
(defrule afiseaza-meniu
	(not (optiune ?x))
	=>
	(printout t crlf);
	(printout t "1. Afiseaza" crlf)
	(printout t "2. Adauga" crlf)
	(printout t "3. Ghiceste" crlf)
	(printout t "Optiunea ta: ")
	(assert (optiune (read)))
)

; ---------------
; adaugare film
(defrule adauga-film
	?a <-(optiune 2)
	=>
	(retract ?a)

	(printout t "titlu: ")
	(bind ?titlu (explode$(readline)))

	(printout t "regizor: ")
	(bind ?regizori (explode$(readline)))
	
	(printout t "actori: ")
	(bind ?actori (explode$(readline)))
	
	(printout t "gen: ")
	(bind ?gen (read))
	
	(assert (film (titlu ?titlu) (regizori ?regizori) (actori ?actori) (gen ?gen)))
)


; ------------------
; afisarea filmelor existente in baza de cunostinte
(defrule afiseaza-filme
	(optiune 1)
	(film (titlu $?titlu) (regizori $?regizori) (actori $?actori) (gen ?gen))
	=>
	(printout t  "titlu: " $?titlu " regizori: " $?regizori " actori: " $?actori " gen: " ?gen crlf)
)

; am afisat toate filmele deci pot sa sterg faptul aferent optiunii de afisare
(defrule sterge-opiune-1
	?a <- (optiune 1)
	=>
	(retract ?a)	
)


; ----------------------
; reguli pentru ghicirea unui film
(defrule preia-regizori
	(optiune 3)
	(not (regizori $?))
	=>
	(printout t "Care sunt/este regizorii/regizorul filmului?" crlf)
	(assert (regizori (explode$(readline))))
)

(defrule ghiceste-folosind-regizori
	?o <- (optiune 3)
	?a <- (regizori $?regizori)
	(film (titlu $?titlu) (regizori $?regizori))
	(not (film (titlu $?titlu2&:(neq ?titlu ?titlu2)) (regizori $?regizori)))
	=>
	(retract ?o)
	(retract ?a)	
	(printout t "Filmul la care va ganditi este: " $?titlu crlf)
)


(defrule preia-actori
	(optiune 3)
	(not (actori $?))
	=>
	(printout t "Care sunt actorii din film?" crlf)
	(assert (actori (explode$(readline))))
)

(defrule ghiceste-folosind-regizori-si-actori
	?o <- (optiune 3)
	?a <- (regizori $?regizori)
	?b <- (actori $?actori)
	(film (titlu $?titlu) (regizori $?regizori) (actori $?actori))
	(not (film (titlu $?titlu2&:(neq ?titlu ?titlu2)) (regizori $?regizori) (actori $?actori)))
	=>
	(retract ?o)
	(retract ?a)
	(retract ?b)	
	(printout t "Filmul la care va ganditi este: " $?titlu crlf)
)


(defrule preia-gen
	(optiune 3)
	(not (gen ?))
	=>
	(printout t "Care este genul filmului?" crlf)
	(assert (gen (read)))
)

(defrule ghiceste-folosind-regizori-si-actori-si-gen
	?o <- (optiune 3)
	?a <- (regizori $?regizori)
	?b <- (actori $?actori)
	?c <- (gen ?gen)
	(film (titlu $?titlu) (regizori $?regizori) (actori $?actori) (gen ?gen))
	(not (film (titlu $?titlu2&:(neq ?titlu ?titlu2)) (regizori $?regizori) (actori $?actori) (gen ?gen)))
	=>
	(retract ?o)
	(retract ?a)
	(retract ?b)	
	(retract ?c)	
	(printout t "Filmul la care va ganditi este: " $?titlu crlf)
)

;daca am ajuns aici inseamna ca nu putem ghici filmul
(defrule sterge-date
	?o <- (optiune 3)
	?a <- (actori $?)
	?b <- (regizori $?)
	?c <- (gen $?)
	=> 
	(retract ?o ?a ?b ?c)
	(printout t "Nu putem ghici filmul, ne pare rau!" crlf);
)



