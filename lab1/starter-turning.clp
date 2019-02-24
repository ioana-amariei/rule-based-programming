(deffacts state
    (starter_turning NO)
    (got_petrol NO)
    (lights_working NO)
    (solenoid_click YES)
    (terminals_clean NO)
    (solenoid_fuse_ok NO)
)

(defrule call_aa
    (starter_turning YES)
    (got_petrol YES)
    => 
    (printout t "Call the A.A." crlf)
)

(defrule buy_petrol
    (starter_turning YES)
    (got_petrol NO)
    =>
    (printout t "Buy some petrol" crlf)
)

(defrule charge_battery
    (starter_turning NO)
    (lights_working NO)
    =>
    (printout t "Charge battery" crlf)
)

(defrule replace_starter
    (starter_turning NO)
    (lights_working YES)
    (solenoid_click YES)
    (terminals_clean YES)
    =>
    (printout t "Replace starter" crlf)
)

(defrule clean_terminals
    (starter_turning NO)
    (lights_working YES)
    (solenoid_click YES)
    (terminals_clean NO)
    =>
    (printout t "Clean terminals" crlf)
)

(defrule replace_solenoid
    (starter_turning NO)
    (lights_working YES)
    (solenoid_fuse_ok YES)
    =>
    (printout t "Replace solenoid" crlf)
)

(defrule replace_fuse
    (starter_turning NO)
    (lights_working YES)
    (solenoid_click NO)
    (solenoid_fuse_ok NO)
    =>
    (printout t "Replace fuse" crlf)
)
