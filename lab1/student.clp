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

(defglobal
?*promoted_students* = 0
?*found_students* = 0
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
    (printout t "Search student (8)" crlf)
    (printout t "Exit (9)" crlf)
    (printout t "--------------END MENU-------------" crlf)
    (printout t "" crlf)
    (assert (option (read)))
)

; ################### add student ########################
(defrule retrieve_name
    ?option <- (option 1)
    =>
    (printout t "Name:" crlf)
    (assert (input_name (explode$(readline))))
)

(defrule verify_student_exists
    ?option <- (option 1)
    ?input_name <- (input_name ?name $?)
    (student (name ?name))
    =>
    (retract ?option ?input_name)
    (assert (option 1))
    (printout t "The specified student already exists" crlf)
)

(defrule add_student
    ?option <- (option 1)
    ?input_name <- (input_name ?name $?)
    =>
    (retract ?option ?input_name)
    (assert (student (name ?name)))
)

; ################### add laboratory grades ########################
(defrule retrieve_lab_grade
    ?option <- (option 2)
    =>
    (printout t "Lab grades: <student name> [<lab><grade>]+" crlf)
    (assert (input_lab_grade (explode$(readline))))
)

(defrule verify_student_exists_lab_grade
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
    (student (name ?name)(laboratory_grades ~nil))
    =>
    (retract ?option ?input_lab_grade)
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
    (student (name ?name)(project_grade ~nil))
    =>
    (retract ?option ?input_project_grade)
    (printout t "The student already has project grade" crlf)
)

(defrule add_project_grade
    ?option <- (option 3)
    ?input_project_grade <- (input_project_grade ?name ?project_grade $?)
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
    (not (student (name ?name)))
    =>
    (retract ?option ?input_exam_grade)
    (assert (option 4))
    (printout t "The specified student does not exist" crlf)
)

(defrule verify_exam_grade_exists
    ?option <- (option 4)
    ?input_exam_grade <- (input_exam_grade ?name ?exam_grade $?)
    (student (name ?name)(exam_grade ~nil))
    =>
    (retract ?option ?input_exam_grade)
    (printout t "The student already has exam grade" crlf)
)

(defrule add_exam_grade
    ?option <- (option 4)
    ?input_exam_grade <- (input_exam_grade ?name ?exam_grade $?)
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
    (printout t "Promoted students: " ?*promoted_students* crlf)
)

; ################ display the list of promoted students ###################
(defrule display_list_promoted_students
    ?option <- (option 7)
    (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades ?laboratory_grades))
    (test (> ?exam_grade 4))
    (test (> ?project_grade 4))
    (forall (student (laboratory_grades $? ? ?grade $?))(> ?grade 4))
    =>
    (printout t "Name: " ?name crlf)
    (bind ?*promoted_students* (+ ?*promoted_students* 1))
)

(defrule finish_displaying_list_promoted_students
    ?option <- (option 7)
    =>
    (retract ?option)
)

; ################ search student ###################
(defrule search_retrieve_exam_grade
    ?option <- (option 8)
    =>
    (printout t "Exam grade:" crlf)
    (assert (input_search_exam_grade (explode$(readline))))
)

(defrule search_exam_grade_exists
    ?option <- (option 8)
    ?input_search_exam_grade <- (input_search_exam_grade ?exam_grade $?)
    (not (student (exam_grade ?exam_grade)))
    =>
    (retract ?option ?input_search_exam_grade)
    (printout t "There is no student with exam grade: " ?exam_grade crlf)
)

(defrule search_retrieve_project_grade
    ?option <- (option 8)
    =>
    (printout t "Project grade:" crlf)
    (assert (input_search_project_grade (explode$(readline))))
)

(defrule search_project_grade_exists
    ?option <- (option 8)
    ?input_search_project_grade <- (input_search_project_grade ?project_grade $?)
    (not (student (project_grade ?project_grade)))
    =>
    (retract ?option ?input_search_project_grade)
    (printout t "There is no student with project grade: " ?project_grade crlf)
)

(defrule search_student_not_found
    ?option <- (option 8)
    ?input_search_exam_grade <- (input_search_exam_grade $? ?exam_grade $?)
    ?input_search_project_grade <- (input_search_project_grade $? ?project_grade $?)
    (not (student (exam_grade ?exam_grade)(project_grade ?project_grade)))
    =>
    (retract ?option ?input_search_exam_grade ?input_search_project_grade)
    (printout t "There is no student that has exam grade: " ?exam_grade " and project grade: " ?project_grade crlf)
)

(defrule search_more_than_one_student
    ?option <- (option 8)
    (logical (test (> ?*found_students* 1)))
    =>
    (retract ?option)
    (printout t "There are " ?*found_students* " students that satisfy the conditions." crlf)
)

(defrule search_display_found_student
    ?option <- (option 8)
    ?input_search_exam_grade <- (input_search_exam_grade $? ?exam_grade $?)
    ?input_search_project_grade <- (input_search_project_grade $? ?project_grade $?)
    ; (forall (student (exam_grade ?exam_grade) (project_grade ?project_grade)))
    (student (name ?name)(project_grade ?project_grade) (exam_grade ?exam_grade))
    =>
    (retract ?option ?input_search_exam_grade ?input_search_project_grade)
    (bind ?*found_students* (+ ?*found_students* 1))
    (printout t "Student: " ?name " has exam grade: " ?exam_grade " and project grade: " ?project_grade crlf)
)

; ################ exit ###################
(defrule exit
    ?option <- (option 9)
    =>
    ; do nothing 
)