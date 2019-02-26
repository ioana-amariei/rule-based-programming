(defrule read_printer_print
    =>
    (printout t "Does printer print?" crlf)
    (assert (printer_not_print (read)))
)

(defrule read_light_flashing
    =>
    (printout t "Red light is flushing?" crlf)
    (assert (red_light_flashing (read)))
)

(defrule read_printer_unrecognised
    =>
    (printout t "Printer is unrecognised?" crlf)
    (assert (printer_unrecognised (read)))
)

(defrule check_power_cable
    (printer_not_print Y)
    (red_light_flashing N)
    (printer_unrecognised Y)
    =>
    (printout t "Check the power cable" crlf)
)

(defrule check_printer_computer_cable
    (printer_not_print Y)
    (printer_unrecognised Y)
    =>
    (printout t "Check the printer computer cable" crlf)
)

(defrule ensure_printer_software_installed
    (printer_unrecognised Y)
    =>
    (printout t "Ensure printer software is installed" crlf)
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

