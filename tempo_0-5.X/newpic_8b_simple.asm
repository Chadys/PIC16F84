    Title "programme"
    List p=16f84, f=inhx8m
    INCLUDE "p16f84.inc"
    INCLUDE "newAsmTemplate.inc"
Cmp	equ 0C
Cmp2	equ 0D
NTOUR2   equ 255 ;2(mov)+(5(nop)+1(dec)+2(goto))*254+5(nop)+2(dec)=2041 
NTOUR	equ 244	;2(mov) + (1(dec)+2(goto)+2041(ntour2))*243+2041+2(dec)+2(return)+5(allumage LED et call temp)=500542
	
	org 0
	BSF	STATUS, RSO ;acces zone 1
	CLRF	TRISB	    ;met PortB en sortie
	BCF	STATUS, RSO ;revenir zone 0
Boucle	BSF	PORTB, RB0  ;met à 1 bit RBO du PortB
	CALL	Temp	    ;sous-programme qui met en attente
	GOTO	Suite	    ;permet d'avoir le meme nombre de cycle
Suite	BCF	PORTB, RB0  ;met à 0 bit RBO du PortB	    	    
	CALL	Temp
	GOTO	Boucle	    ;reboucle
	
Temp	MOVLW	NTOUR	    ;met NTOUR dans repertoire travail
	MOVWF	Cmp	    ;met NTOUR dans Cmp

Temp2	MOVLW	NTOUR2	    ;met NTOUR2 dans repertoire travail
	MOVWF	Cmp2	    ;met NTOUR2 dans Cmp2

Temp3	NOP
	NOP
	NOP
	NOP
	NOP
	DECFSZ	Cmp2, f
	GOTO	Temp3
	
	DECFSZ	Cmp
	GOTO	Temp2
	RETURN
	
	
	End