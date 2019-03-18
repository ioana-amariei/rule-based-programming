; definim sabonul pentru un fapt de tip student
(deftemplate student
    (slot name)
    (slot project_grade)
    (slot exam_grade)
    (multislot laboratory_grades)
)

; definim fapte despre studenti
(deffacts existing_add_student_grades
    (student (name "Ioana Birsan") (project_grade 10) (exam_grade 9) (laboratory_grades 1 3 2 6 3 5 4 10))
    (student (name "Daniel Amariei") (project_grade 10) (exam_grade 10) (laboratory_grades 1 10 2 3 3 5))
    (student (name "Maria Popescu") (project_grade 4) (exam_grade 8) (laboratory_grades 1 3 2 3))
    (student (name "Ion Radu") (project_grade 5) (exam_grade 4) (laboratory_grades 1 10 2 9 3 9 4 8))
)

; meniu principal
(defrule show_menu
    (not (option ?x))
    =>
    (printout t "" crlf)
    (printout t "----------------MENU---------------" crlf)
    (printout t "Add student (1)" crlf)
    (printout t "Add laboratory grades (2)" crlf)
    (printout t "Add project grade (3)" crlf)
    (printout t "Add exam grade (4)" crlf)
    (printout t "Display student info (5)" crlf)
    (printout t "Display the number of promoted students (6)" crlf)
    (printout t "Display the list of promoted students (7)" crlf)
    (printout t "Exit (8)" crlf)
    (printout t "--------------END MENU-------------" crlf)
    (printout t "" crlf)
    (assert (option (read)))
)

(defrule add_student
    ?option <- (option 1)
    =>
    (retract ?option)
    (printout t "Name: " crlf)
    (bind ?name (readline))
    (assert (student (name ?name)))
)

; add laboratory grades
(defrule retrieve_lab_grade
    ?option <- (option 2)
    =>
    (printout t "Lab grades: <student name> [<lab><grade>]+" crlf)
    (assert (input_lab_grade (explode$(readline))))
)

(defrule verify_student_exists_lab_grades
    ?option <- (option 2)
    ?input_lab_grade <- (input_lab_grade ?name $?)
    (not (student (name ?name)))
    =>
    (retract ?option ?input_lab_grade)
    (assert (option 2))
    (printout t "The specified student does not exist" crlf)
)

(defrule verify_lab_grade_exists
    ?option <- (option 2)
    ?input_lab_grade <- (input_lab_grade ?name ?laboratory_grades $?)
    (student (name ?name)(laboratory_grades $?grades))
    =>
    (retract ?option ?input_lab_grade)
    (assert (option 2))
    (printout t "The student already has laboratory grades" crlf)
)

(defrule add_laboratory_grades
    ?option <- (option 2)
    ?input_lab_grade <- (input_lab_grade ?name $?laboratory_grades)
    ?student <- (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?))
    =>
    (retract ?option ?input_lab_grade ?student)
    (assert (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades)))
)

; ################### add project grade ########################
(defrule retrieve_project_grade
    ?option <- (option 3)
    =>
    (printout t "Project grade: <student name> <grade>" crlf)
    (assert (input_project_grade (explode$(readline))))
)

(defrule verify_student_exists_project_grade
    ?option <- (option 3)
    ?input_project_grade <- (input_project_grade ?name $?)
    (not (student (name ?name)))
    =>
    (retract ?option ?input_project_grade)
    (assert (option 3))
    (printout t "The specified student does not exist" crlf)
)

(defrule verify_project_grade_exists
    ?option <- (option 3)
    ?input_project_grade <- (input_project_grade ?name ?project_grade $?)
    (student (name ?name)(project_grade ?))
    =>
    (retract ?option ?input_project_grade)
    (printout t "The student already has project grade" crlf)
)

(defrule add_project_grade
    ?option <- (option 3)
    ?input_project_grade <- (input_project_grade ?name ?project_grade)
    ?student <- (student (name ?name) (project_grade ?) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades))
    =>
    (retract ?option ?input_project_grade ?student)
    (assert (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades)))
)

; ################## add exam grade ############################
(defrule retrieve_exam_grade
    ?option <- (option 4)
    =>
    (printout t "Exam grade: <student name> <exam_grade>" crlf)
    (assert (input_exam_grade (explode$(readline))))
)

(defrule verify_student_exists_exam_grade
    ?option <- (option 4)
    ?input_exam_grade <- (input_exam_grade ?name $?)
    (not (exists (student (name ?name))))
    =>
    (retract ?option ?input_exam_grade)
    (assert (option 4))
    (printout t "The specified student does not exist" crlf)
)

(defrule verify_exam_grade_exists
    ?option <- (option 4)
    ?input_exam_grade <- (input_exam_grade ?name ?exam_grade $?)
    (exists (student (name ?name)(exam_grade ?)))
    =>
    (retract ?option ?input_exam_grade)
    (printout t "The student already has exam grade" crlf)
)

(defrule add_exam_grade
    ?option <- (option 4)
    ?input_exam_grade <- (input_exam_grade ?name ?exam_grade)
    ?student <- (student (name ?name) (project_grade ?project_grade) (exam_grade ?) (laboratory_grades $?laboratory_grades))
    =>
    (retract ?option ?input_exam_grade ?student)
    (assert (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades)))
)

; ################### display student information ###################
(defrule retrieve_student_info
    ?option <- (option 5)
    =>
    (printout t "Student: <student name>" crlf)
    (assert (input_name (explode$(readline))))
)

(defrule verify_student_exists_name
    ?option <- (option 5)
    ?input_name <- (input_name ?name $?)
    (not (exists (student (name ?name))))
    =>
    (retract ?option ?input_name)
    (assert (option 5))
    (printout t "The specified student does not exist" crlf)
)

(defrule display_student_info
    ?option <- (option 5)
    ?input_name <- (input_name ?name)
    ?student <- (student (name ?) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades))
    =>
    (retract ?option ?input_name)
    (printout t "Name: " ?name crlf)
    (printout t "Project grade: " ?project_grade crlf)
    (printout t "Exam grade: " ?exam_grade crlf)
    (printout t "Laboratory grades: " ?laboratory_grades crlf)
)

; ################### am afisat studentii, acum pot sa sterg optiunea ###################
(defrule remove_display_student_info_option
    ?option <- (option 5)
    =>
    (retract ?option)
)

; ################### display the number of promoted students ###################
(defrule display_number_promoted_students
    ?option <- (option 6)
    =>
    (retract ?option)
)

; ################ display the list of promoted students ###################
(defrule display_list_promoted_students
    ?option <- (option 7)
    (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades))
    (test (> ?exam_grade 4))
    (test (> ?project_grade 4))
    (forall (laboratory_grades $? ? ?grade $?)
    (> ?grade 4)
    )
    =>
    (printout t "Name: " ?name crlf)
)

(defrule finish_displaying_list_promoted_students
    ?option <- (option 7)
    =>
    (retract ?option)
)

; exit
(defrule exit
    ?option <- (option 8)
    =>
    ; do nothing 
)