; facem niste clase pentru gestiunea studentilor de la facultatea de informatica
; 3 tipuri de studenti
; zi (an-studiu, nume)
; master (nume, an-studiu, master, an-absolvire-zi)
; doctorat (nume, an-studiu, master, an-absolvire-masterat)
; creare student nou
; afisare informatii despre un student nou dupa nume
; posibilitate transfer student
; sterge instanta dintr-o parte si adaugare in alta plus cerere informatii suplimentare ce nu exista



; student la zi
(defclass student
	(is-a USER) 
	(role concrete)
	
	; definire atribute
	(slot nume 
				(access read-write)
				(create-accessor read-write) 
				(default fara-nume))
	(slot an-studiu 
					(access read-write)
					(create-accessor read-write)
					(default fara-an))	
)


(defclass student-master
	(is-a student) 
	(role concrete)
	
	; definire atribute
	(slot master 
				(access read-write)
				(create-accessor read-write)
				(default fara-master))
	(slot an-absolvire-zi 
					(access read-write)
					(create-accessor read-write)
					(default fara-an-absolvire-zi))	
)


(defclass student-doctorat
	(is-a student) 
	(role concrete)
	
	; definire atribute
	(slot master 
				(access read-write)
				(create-accessor read-write)
				(default fara-master))
	(slot an-absolvire-masterat 
					(access read-write)
					(create-accessor read-write)
					(default fara-an-absolvire-masterat))	
)


(definstances instante
	((gensym) of student)
	((gensym) of student-master)
	((gensym) of student-doctorat)
)


(defrule meniu
	(not (optiune ?))
	=>
	(printout t "1. Afiseaza studenti" crlf)
	(printout t "2. Afiseaza studenti dupa nume" crlf)
	(printout t "3. Adauga student zi" crlf)
	(printout t "4. Adauga student master" crlf)
	(printout t "5. Adauga student doctorat" crlf)`
	
	(bind ?raspuns (read))
	(assert (optiune ?raspuns))
)


(defrule afisare-studenti
	(optiune 1)
	?s <- (object (is-a student))
	=>
	(printout t crlf)
	(send ?s print)
	(printout t crlf)
)


(defrule curatentie
	(declare (salience -5))
	?a <- (optiune 1)
	=>
	(retract ?a)
)

(defrule preia-nume
	?a <- (optiune 2)
	=>
	(retract ?a)
	(printout t "Introduceti numele studentului: ") 
	(assert (nume (read)))
)


(defrule afisare-studenti-dupa-nume
	(nume ?nume)
	?s <- (object (is-a student) (nume ?nume))
	=>
	(printout t crlf)
	(send ?s print)
	(printout t crlf)
)


(defrule curatenie2
	?a <- (nume ?)
	=>
	(retract ?a)
)


(defrule adauga-student-zi
	?a <-(optiune 3)
	=>
	 (retract ?a)
	 (printout t "Nume student: ")
	 (bind ?nume (read))
	 (printout t "An student: ")
	 (bind ?an (read))
	 (make-instance (gensym) of student (nume ?nume) (an-studiu ?an))
)


(defrule adauga-student-master
	?a <-(optiune 4)
	=>
	 (retract ?a)
	 (printout t "Nume student: ")
	 (bind ?nume (read))
	 (printout t "An student: ")
	 (bind ?an (read))
	 (printout t "Master: ")
	 (bind ?master (read))
	 (printout t "An absolvire zi: ")
	 (bind ?an-absolvire (read))
	 (make-instance (gensym) of student-master (nume ?nume) (an-studiu ?an) (master ?master) (an-absolvire-zi ?an-absolvire))
)


(defrule adauga-student-doctorat
	?a <-(optiune 5)
	=>
	 (retract ?a)
	 (printout t "Nume student: ")
	 (bind ?nume (read))
	 (printout t "An student: ")
	 (bind ?an (read))
	 (printout t "Master absolvit: ")
	 (bind ?master-absolvit (read))
	 (printout t "An absolvire master: ")
	 (bind ?an-absolvire-master (read))
	 (make-instance (gensym) of student-doctorat (nume ?nume) (an-studiu ?an) (master ?master-absolvit) (an-absolvire-masterat ?an))
)

(defrule nume-stude-zi-master
	
)

(defrule transfer-student-zi-master
	
)