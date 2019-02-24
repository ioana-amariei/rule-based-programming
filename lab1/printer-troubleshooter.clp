; initial state: you can give any values you want
(deffacts state
    (printer_not_print Y)
    (red_light_flashing N)
    (printer_unrecognised N)
)

; defined the rules
(defrule check_power_cable
    (printer_not_print Y)
    (red_light_flashing N)
    (printer_unrecognised N)
    =>
    (printout t "Check the power cable" crlf)
)

(defrule check_printer_computer_cable
    (printer_not_print Y)
    (printer_unrecognised Y)
    =>
    (printout t "Check printer computer cable" crlf)
)

(defrule ensure_printer_software_installed
    (printer_unrecognised Y)
    =>
    (printout t "Ensure the printer software is installed" crlf)
)

(defrule check_replace_ink
    (red_light_flashing Y)
    =>
    (printout t "Check or replace ink" crlf)
)

(defrule check_paper_jam
    (printer_not_print Y)
    (printer_unrecognised N)
    => 
    (printout t "Check for paper jam" crlf)
)

