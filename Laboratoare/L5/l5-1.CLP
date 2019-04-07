; facem niste clase pentru gestiunea studentilor de la facultatea de informatica
; 3 tipuri de studenti
; zi (an-studiu, nume)
; master (nume, an-studiu, master, an-absolvire-zi)
; doctorat (nume, an-studiu, master, an-absolvire-masterat)
; creare student nou
; afisare informatii despre un student nou dupa nume
; posibilitate transfer student
; sterge instanta dintr-o parte si adaugare in alta plus cerere informatii suplimentare ce nu exista

; definire clasa in CLIPS
; o clasa are o serie de parametrii ce pot fi precizati
; doi sunt obligatorii
; toate clasele in CLIPS trebuie sa mosteneasca o alta clasa
(defclass student
	(is-a user) ; obligatoriu
	(role concrete) ; sau ABSTRACT
	; definire atribute
	(slot nume (access read-write)
				(create accessor read-write) ; am niste functii implicite in CLIPS care imi permit sa scriu si sa citesc din slotul respectiv
				(default Gigle))
)

; o clasa sau o instantiere nu este un fapt (sunt lucruri total diferite)
; creare instanta clasa
(make-instance a of student
	; daca vrem sa afisam instanta respectiva
	; toate apelurile de metode pe clase se fac prin send
	; ne intereseaza instanta la care ne referim [nume-instanta]
	(send [a] read) ;afiseaza continutul instantei
)

; definirea unei reguli
; schimbarea numelui unui student
(defrule nume_student
	; pattern pe instantle clasei student
	; toate patternurile care se potrives pe instante incep cu object
	; ma intereseaza instantele clasei student
	; se potriveste peste instantle clasei student care au numele gigel
	?a <- (object (is-a student) (nume Gigel))
	=>
	(send ?a put-nume (read)) ; print-nume		
)

; nu mai sunt probleme cu bucle infinite aici

; crearea mai multor fapte
(definstances instante
	(a of student) (nume ...)
	(b of student)
)