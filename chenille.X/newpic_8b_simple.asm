    Title "programme"
    List p=16f84, f=inhx8m
    INCLUDE "p16f84.inc"
masque	equ 0C
	
	org 0
	BSF	STATUS, RP0 ;acces zone 1
	CLRF	TRISB	    ;met PortB en sortie
	BCF	STATUS, RP0 ;revenir zone 0
	MOVLW	D'1'
	MOVWF	masque
BOUCLE	BCF	STATUS,0
	MOVWF	PORTB
	CALL	TEMP
	BTFSC	masque, 7
	BSF	STATUS,0
	RLF	masque,f
	MOVF	masque,w
	GOTO	BOUCLE
	
TEMP	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RETURN
	
	
	End