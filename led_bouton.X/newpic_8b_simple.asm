    title "program"
    list p=16F84, f=inhx8m
    INCLUDE "p16f84a.inc"
SAVE_W	 EQU	0C
SAVE_STATUS  EQU	0D
    
	org 0
	
init	BSF	STATUS, RP0
	MOVLW	B'00000001'
	MOVWF	TRISB
	BCF	OPTION_REG, T0CS
	BCF	STATUS, RP0
	
	;valide interruption INT
	BSF	INTCON, GIE
	BSF	INTCON, INTE
	
Start	BTFSS	PORTA, RA4
	GOTO	allume		;RA4=0
	GOTO	eteint		;RA4=1
	
allume	BSF	PORTB, RB1
	GOTO	Start
	
eteint	BCF	PORTB, RB1
	GOTO	Start
	End
	
	
	org 4
	;sauvegarde des registres
	MOVWF	SAVE_W
	SWAPF	STATUS, w
	MOVWF	SAVE_STATUS
	
	;test si interruption INT
	BTFSS	INTCON, INTF
	GOTO	ret_reg
	
	;changement LEDs
	BCF	PORTB, RB1
	BSF	PORTB, RB5
	
	;restaurer registres
ret_reg	SWAPF	SAVE_STATUS, w
	MOVWF	STATUS
	SWAPF	SAVE_W, f
	SWAPF	SAVE_W, w
	
	;drapeau à zéro
	BCF	INTCON, INTF
	
	RETFIE