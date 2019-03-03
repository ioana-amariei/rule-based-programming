(defrule show_menu
    (not (option ?x))
    =>
    (printout t "Add student info (1)" crlf)
    (printout t "Add exam info (2)" crlf)
    (printout t "Add student grades (3)" crlf)
    (printout t "Add exam grades (4)" crlf)
    (printout t "Display student info (5)" crlf)
    (printout t "Display exam info (6)" crlf)
    (printout t "Exit (7)" crlf)
    (assert (option (read)))
)

(deftemplate student
    (slot name)
    (multislot grades)
)

(defrule add_student
    ?option <- (option 1)
    =>
    (retract ?option)
    
    (printout t "Student name: " crlf)
    (bind ?name (readline))

    (printout t "Student grades: [<exame> <grade>]+" crlf)
    (bind ?grades (explode$(readline)))
    
    (assert (student (name ?name) (grades ?grades)))
)

(defrule add_exam
    ?option <- (option 2)
    =>
    (retract ?option)
    (printout t "Exam: " crlf)
    (assert (exam (read)))
    (assert (show_menu))
)

(defrule add_student_grades
    ?option <- (option 3)
    =>
    (retract ?option)
    (printout t "Grades: <studentName> <grade1 grade2...>" crlf)
    ;(assert (grades (read)) (explode $ (readline))))
    (assert (show_menu))
)

(defrule display_student_info
    ?option <- (option 5)
    (student (name ?name) (grades $?grades))
    =>
    (printout t "Name: " ?name crlf)
    (printout t "Grades: " ?grades crlf)
)

; am afisat studentii, acum pot sa sterg optiunea
(defrule remove_display_student_info_option
    ?option <- (option 5)
    =>
    (retract ?option)
)

(defrule exit
    ?option <- (option 7)
    =>
    ; do nothing 
)

