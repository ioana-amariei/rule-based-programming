; definim sabonul pentru un fapt de tip student
(deftemplate student
    (slot name)
    (slot project_grade)
    (slot exam_grade)
    (multislot laboratory_grades)
)

; definim fapte despre studenti
(deffacts existing_add_student_grades
    (student (name "Ioana Birsan") (project_grade 25) (exam_grade 10) (laboratory_grades 4 5 2 3 4))
    (student (name "Ioana Popescu") (project_grade 25) (exam_grade 10) (laboratory_grades 4 5 2 3 4))
    (student (name "Daniel Amariei") (project_grade 15) (exam_grade 20) (laboratory_grades 3 3 3 4 5 2))
    (student (name "Ana Popa") (project_grade 33) (exam_grade 10) (laboratory_grades))
    (student (name "Maria Popescu") (project_grade 5) (exam_grade 12) (laboratory_grades 3 3 4))
    (student (name "Ion Radu") (project_grade 22) (exam_grade 30) (laboratory_grades 4 2 2 4 5 5))
    (student (name "Andrei Radu") (project_grade 25) (exam_grade 33) (laboratory_grades 4 2 2 4 5 5))
)

(defglobal
?*promoted_students* = 0
?*found_students* = 0
?*total_grade* = 0
?*partial_grade* = 0
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
(defrule check_number_promoted_students
    ?option <- (option 6)
    (not (promoted ?number))
    =>
    (retract ?option)
)

(defrule display_number_promoted_students
    ?option <- (option 6)
    (promoted ?number)
    =>
    (retract ?option)
    (printout t "Promoted students: " ?number crlf)
)

; ################ display the list of promoted students ###################
(defrule compute_grade
    ?option <- (option 7)
    (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades))
    ; (forall (student (laboratory_grades $? ?grade $?))(> ?grade 0))
    =>
    (bind ?*total_grade* (+ ?exam_grade ?project_grade))
    (assert (student_name ?name ?*total_grade*))
    ; (bind ?*partial_grade* (+ ?grade ?*partial_grade*))
    ; (bind ?*total_grade* (+ ?exam_grade ?project_grade ?*partial_grade*))
    
)

(defrule display_list_promoted_students
    ?option <- (option 7)
    (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades))
    (student_name ?name ?total)
    (test (> ?total 49))
    =>
    (bind ?*promoted_students* (+ ?*promoted_students* 1))
    (assert (promoted ?*promoted_students*))
    (printout t "Name: " ?name " final grade: " ?*total_grade* crlf)
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
    (assert (search_input_exam_grade (explode$(readline))))
)

(defrule search_exam_grade_exists
    ?option <- (option 8)
    ?search_input_exam_grade <- (search_input_exam_grade ?exam_grade $?)
    (not (student (exam_grade ?exam_grade)))
    =>
    (retract ?option ?search_input_exam_grade)
    (printout t "There is no student with exam grade: " ?exam_grade crlf)
)

(defrule search_retrieve_project_grade
    ?option <- (option 8)
    =>
    (printout t "Project grade:" crlf)
    (assert (search_input_project_grade (explode$(readline))))
)

(defrule search_project_grade_exists
    ?option <- (option 8)
    ?search_input_project_grade <- (search_input_project_grade ?project_grade $?)
    (not (student (project_grade ?project_grade)))
    =>
    (retract ?option ?search_input_project_grade)
    (printout t "There is no student with project grade: " ?project_grade crlf)
)

(defrule search_exam_and_project_grades_exist
    ?option <- (option 8)
    ?search_input_exam_grade <- (search_input_exam_grade ?exam_grade $?)
    ?search_input_project_grade <- (search_input_project_grade ?project_grade $?)
    (not (student (exam_grade ?exam_grade)(project_grade ?project_grade)))
    =>
    (retract ?option ?search_input_exam_grade ?search_input_project_grade)
    (printout t "There is no student with exam grade: " ?exam_grade " and project grade: " ?project_grade crlf)
)

(defrule search_increment_students_satisfy_exam_project_grades
    ?option <- (option 8)
    ?search_input_exam_grade <- (search_input_exam_grade ?exam_grade $?)
    ?search_input_project_grade <- (search_input_project_grade ?project_grade $?)
    (student (name ?name)(exam_grade ?exam_grade)(project_grade ?project_grade))
    =>
    (bind ?*found_students* (+ ?*found_students* 1))
    (assert (student_number ?name ?*found_students*))
)

(defrule search_display_number_students
    ?option <- (option 8)
    (student (name ?name) (project_grade ?project_grade) (exam_grade ?exam_grade) (laboratory_grades $?laboratory_grades))
    (student_number ?name ?number)
    (test (> ?number 1))
    =>
    (retract ?option)
    (printout t "There are: " ?number " that satisfy condition." crlf)
)

(defrule search_display_students_satisfy_exam_project_grades
    ?option <- (option 8)
    (student_number ?number)
    (test (< ?number 2))
    (test (> ?number 0))
    ?search_input_exam_grade <- (search_input_exam_grade ?exam_grade $?)
    ?search_input_project_grade <- (search_input_project_grade ?project_grade $?)
    (student (name ?name)(exam_grade ?exam_grade)(project_grade ?project_grade))
    =>
    (retract ?option ?search_input_exam_grade ?search_input_project_grade)
    (printout t "Student: " ?name " has exam grade: " ?exam_grade " and project grade: " ?project_grade crlf)
)

; ################ exit ###################
(defrule exit
    ?option <- (option 9)
    =>
    ; do nothing 
)