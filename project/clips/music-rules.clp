(deffacts metrics
    (total_notes)
    (different_notes)
    (durations)
    (total_measures)
    (count_do)
    (count_re)
    (count_mi)
    (count_fa)
    (count_sol)
    (count_la)
    (count_si)
)

; Define statistics rules

(defrule number_of_total_musical_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?octave) (duration ?) (voice ?) (type ?) (stem ?))
    ?a <- (total_notes $?notes)
    (not (total_notes $? ?note $?))
    =>
    (retract ?a)
    (assert (total_notes $?notes ?note))
)

(defrule number_of_different_musical_notes
    (note (id ?) (measure_id ?) (pitch ?step ?octave) (duration ?) (voice ?) (type ?) (stem ?))
    ?a <- (different_notes $?notes)
    (not (different_notes $? ?step ?octave $?))
    =>
    (retract ?a)
    (assert (different_notes $?notes ?step ?octave))
)

(defrule determine_durations
    (note (id ?) (measure_id ?) (pitch ? ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    ?a <- (durations $?durations)
    (not (durations $? ?duration $?))
    =>
    (retract ?a)
    (assert (durations $?durations ?duration))
)

(defrule number_of_total_measures
    ?measure <- (measure (id ?) (notes_id $?))
    ?a <- (total_measures $?measures)
    (not (total_measures $? ?measure $?))
    =>
    (retract ?a)
    (assert (total_measures $?measures ?measure))
)

; Notes A(do), B(re), C(mi), D(fa), E(sol), F(la), G(si)
; function str-compare <string1> <string2> returns 0 if <string1> equals <string2> else returns 1 (https://www.csie.ntu.edu.tw/~sylee/courses/clips/bpg/node12.3.9.html)
(defrule number_of_do_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    (test (< (str-compare ?step "A") 1))
    ?a <- (count_do $?notes)
    (not (count_do $? ?note $?))
    =>
    (retract ?a)
    (assert (count_do $?notes ?note))
)

(defrule number_of_re_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    (test (< (str-compare ?step "B") 1))
    ?a <- (count_re $?notes)
    (not (count_re $? ?note $?))
    =>
    (retract ?a)
    (assert (count_re $?notes ?note))
)

(defrule number_of_mi_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    (test (< (str-compare ?step "C") 1))
    ?a <- (count_mi $?notes)
    (not (count_mi $? ?note $?))
    =>
    (retract ?a)
    (assert (count_mi $?notes ?note))
)

(defrule number_of_fa_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    (test (< (str-compare ?step "D") 1))
    ?a <- (count_fa $?notes)
    (not (count_fa $? ?note $?))
    =>
    (retract ?a)
    (assert (count_fa $?notes ?note))
)

(defrule number_of_sol_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    (test (< (str-compare ?step "E") 1))
    ?a <- (count_sol $?notes)
    (not (count_sol $? ?note $?))
    =>
    (retract ?a)
    (assert (count_sol $?notes ?note))
)

(defrule number_of_la_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    (test (< (str-compare ?step "F") 1))
    ?a <- (count_la $?notes)
    (not (count_la $? ?note $?))
    =>
    (retract ?a)
    (assert (count_la $?notes ?note))
)

(defrule number_of_si_notes
    ?note <- (note (id ?) (measure_id ?) (pitch ?step ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    (test (< (str-compare ?step "G") 1))
    ?a <- (count_si $?notes)
    (not (count_si $? ?note $?))
    =>
    (retract ?a)
    (assert (count_si $?notes ?note))
)

; Display statistics

(defrule notes_per_measure
    (measure (id ?id) (notes_id $?ids))
    =>
    (printout t "Measure: " ?id " has: " (length $?ids) " notes" crlf)
)

(defrule display_number_of_musical_notes
    (total_notes $?notes)
    =>
    (printout t "Number of total musical notes: " (length $?notes) crlf)
)

(defrule display_number_of_different_musical_notes
    (different_notes $?notes)
    =>
    (printout t "Number of different musical notes: " (/ (length $?notes) 2) crlf)
)

(defrule display_durations
    (durations $?durations)
    =>
    (printout t "Durations: " $?durations crlf)
)

(defrule display_number_of_measures
    (total_measures $?measures)
    =>
    (printout t "Number of total measures: " (length $?measures) crlf)
)

; I want to execute this rule at the end when all the notes are counted, that's why I declare a negative priority
(defrule display_notes_apparition
    (declare (salience -10))
    (count_do $?do_notes)
    (count_re $?re_notes)
    (count_mi $?mi_notes)
    (count_fa $?fa_notes)
    (count_sol $?sol_notes)
    (count_la $?la_notes)
    (count_si $?si_notes)
    =>
    (printout t "-------------Notes apparition-------------" crlf)
    (printout t "DO: " (length $?do_notes) crlf)
    (printout t "RE: " (length $?re_notes) crlf)
    (printout t "MI: " (length $?mi_notes) crlf)
    (printout t "FA: " (length $?fa_notes) crlf)
    (printout t "SOL: " (length $?sol_notes) crlf)
    (printout t "LA: " (length $?la_notes) crlf)
    (printout t "SI: " (length $?si_notes) crlf)
    (printout t "------------------------------------------" crlf)
)