; defininm starile posibile
(deffacts printer-facts
	(pnp N)
	(rlf N)
	(pu N)
)

; definim regulile
(defrule check-power-cable
	(pnp Y)
	(rlf N)
	(pu Y)
	=>
	(printout t "Check the power cable!" crlf)	
)

(defrule check-the-printer-computer-cable
	(pnp Y)
	(pu Y)
	=>
	(printout t "Check the printer computer cable!" crlf)	
)


(defrule ensure-printer-software-is-installed
	(pu Y)
	=>
	(printout t "Ensure printer-software is installed!" crlf)	
)

(defrule check-replace-ink
	(rlf Y)
	=>
	(printout t "Check or replace ink!" crlf)	
)

(defrule check-for-paper-jam
	(pnp Y)
	(pu N)
	=>
	(printout t "Check for paper jam!" crlf)
)	


