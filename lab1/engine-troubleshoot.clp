(defrule check_starter
    =>
    (printout t "Starter turning?" crlf)
    (assert (starter_turning (read)))
)

(defrule check_petrol
    (starter_turning Y)
    =>
    (printout t "Got any petrol?" crlf)
    (assert (got_petrol (read)))
)

(defrule call_aa
    (got_petrol Y)
    =>
    (printout t "Call the AA" crlf)
)

(defrule buy_petrol
    (got_petrol N)
    =>
    (printout t "Buy some!" crlf)
)

(defrule check_lights
    (starter_turning N)
    =>
    (printout t "Lights working?" crlf)
    (assert (lights_working (read)))
)

(defrule check_solenoid_click
    (lights_working Y)
    =>
    (printout t "Solenoid click?" crlf)
    (assert (solenoid_click (read)))
)

(defrule charge_battery
    (lights_working N)
    =>
    (printout t "Charge battery" crlf)
)

(defrule check_terminals
    (solenoid_click Y)
    =>
    (printout t "Terminals clean?" crlf)
    (assert (terminals_clean (read)))
)

(defrule replace_starter
    (terminals_clean Y)
    =>
    (printout t "Replace starter" crlf)
)

(defrule clean_terminals
    (terminals_clean N)
    =>
    (printout t "Clean terminals" crlf)
)

(defrule check_solenoid_fuse_ok
    (solenoid_click N)
    =>
    (printout t "Solenoid fuse ok?" crlf)
    (assert (check_solenoid_fuse_ok (read)))
)

(defrule replace_solenoid
    (check_solenoid_fuse_ok Y)
    =>
    (printout t "Replace solenoid" crlf)
)

(defrule replace_fuse
    (check_solenoid_fuse_ok N)
    =>
    (printout t "Replace fuse" crlf)
)
