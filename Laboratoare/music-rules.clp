(deffacts metrics
    (total_notes)
    (different_notes)
    (durations)
    (total_measures)
)

(defrule number_of_total_musical_notes
    ?note <- (note (position ? ?) (pitch ?step ?octave) (duration ?) (voice ?) (type ?) (stem ?))
    ?a <- (total_notes $?notes)
    (not (total_notes $? ?note $?))    
    =>
    (retract ?a)
    (assert (total_notes $?notes ?note))
)

(defrule number_of_different_musical_notes
    (note (position ? ?) (pitch ?step ?octave) (duration ?) (voice ?) (type ?) (stem ?))
    ?a <- (different_notes $?notes)
    (not (different_notes $? ?step ?octave $?))    
    =>
    (retract ?a)
    (assert (different_notes $?notes ?step ?octave))
)

(defrule determine_durations
    (note (position ? ?) (pitch ? ?) (duration ?duration) (voice ?) (type ?) (stem ?))
    ?a <- (durations $?durations)
    (not (durations $? ?duration $?))    
    =>
    (retract ?a)
    (assert (durations $?durations ?duration))
)

(defrule number_of_total_measures
    ?measure <- (measure (number ?) (width ?))
    ?a <- (total_measures $?measures)
    (not (total_measures $? ?measure $?))    
    =>
    (retract ?a)
    (assert (total_measures $?measures ?measure))
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