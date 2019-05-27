(deftemplate similar_measures
	(slot measure_id_1)
  (slot measure_id_2)
  (slot measure_1_total_length)
  (slot measure_2_total_length)
	(multislot similar_note_1_id)
  (multislot similar_note_2_id)
)

(defrule check_similar_measures
  ; Get the measures for each score
  ?measure_1 <- (measure (id ?id_1) (score_id S1) (notes_id $?ids_1))
  ?measure_2 <- (measure (id ?id_2) (score_id S2) (notes_id $?ids_2))

  ; Get notes for each measure of the two scores
  ?note_1 <- (note (id ?note_id_1) (measure_id ?measure_id_1) (score_id ?score_id_1) (pitch ?step_1 ?octave_1) (duration ?duration_1) (voice ?voice_1) (type ?type_1) (stem ?stem_1))
  ?note_2 <- (note (id ?note_id_2) (measure_id ?measure_id_2) (score_id ?score_id_2) (pitch ?step_2 ?octave_2) (duration ?duration_2) (voice ?voice_2) (type ?type_2) (stem ?stem_2))
  (and
    (test (= ?measure_id_1 ?id_1))
    (test (= (str-compare ?score_id_1 "S1") 0))
    (test (= ?measure_id_2 ?id_2))
    (test (>= (str-compare ?score_id_2 "S1") 1))
  )

  ; Get same length measures
  ; (test (= (length $?ids_1) (length $?ids_2)))

  ; Compare all notes of the two measures
  (and
    (test (= (str-compare ?step_1 ?step_2) 0))
    (or
      (and
        (test (>= ?octave_1 ?octave_2))
        (test (<= (- ?octave_1 ?octave_2) 1))
      )
      (and
        (test (< ?octave_1 ?octave_2))
        (test (<= (- ?octave_2 ?octave_1) 1))
      )
    )
    (or
      (and
        (test (>= ?duration_1 ?duration_2))
        (test (<= (- ?duration_1 ?duration_2) 2))
      )
      (and
        (test (< ?duration_1 ?duration_2))
        (test (<= (- ?duration_2 ?duration_1) 2))
      )
    )
    (test (= ?voice_1 ?voice_2))
    (test (= (str-compare ?type_1 ?type_2) 0))
    (test (= (str-compare ?stem_1 ?stem_2) 0))
  )

  =>

  (assert (similar_measures (measure_id_1 ?id_1) (measure_id_2 ?id_2) (measure_1_total_length (length $?ids_1)) (measure_2_total_length (length $?ids_2)) (similar_note_1_id $?note_id_1) (similar_note_2_id $?note_id_2)))
)

(defrule show_similar_measures
  (declare (salience -10))
  (similar_measures (measure_id_1 ?id_1) (measure_id_2 ?id_2) (measure_1_total_length ?measure_1_total_length) (measure_2_total_length ?measure_2_total_length) (similar_note_1_id $?note_id_1) (similar_note_2_id $?note_id_2))
  =>
  (printout t ?id_1 " " ?id_2 " " ?measure_1_total_length " " ?measure_2_total_length " " ?note_id_1 " " ?note_id_2 crlf)
)
