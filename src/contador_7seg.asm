;***************************
;Aula 5
;Prof. Vitor Leao
;Multiplexar o display
;***************************
;----------VARIAVEIS-----------------------------
			DSEG		AT 20H
			BSEG
FLAG0:		DBIT		1	;EQUIVALE A 20.0H
FLAG1:		DBIT		1	;EQUIVALE A 20.1H
FLAG2:		DBIT		1	;EQUIVALE A 20.2H
FLAG3:		DBIT		1	;EQUIVALE A 20.3H
FLAG4:		DBIT		1	;EQUIVALE A 20.4H
FLAG5:		DBIT		1	;EQUIVALE A 20.5H
FLAG6:		DBIT		1	;EQUIVALE A 20.6H
FLAG7:		DBIT		1	;EQUIVALE A 20.7H

;----------VAR. BYTE-----------------------------
			DSEG		AT 21H	;END. DE MEMORIA

CONT0:		DS			1		;EQUIVALE 21H
CONT1:		DS			1		;EQUIVALE 22H
CONT2:		DS			1		;EQUIVALE 23H
CONT3:		DS			1		;EQUIVALE 24H
CONT4:		DS			1		;EQUIVALE 25H
CONT5:		DS			1		;EQUIVALE 26H
CONT6:		DS			1		;EQUIVALE 27H
CONT7:		DS			1		;EQUIVALE 28H

;----------CONSTANTE-----------------------------
			FREQ		EQU			60000 ; Estouro em 65535

;----------END. DE INTERRUP�OES------------------
			CSEG		AT	0H
			JMP			BOOT

			CSEG		AT	0BH		; Interrupção do Timer0
			MOV			TL0,#LOW	FREQ
			MOV			TH0,#HIGH	FREQ
			JMP			DISPLAY_MUX

;----------PROG. PRINCIPAL-----------------------
BOOT:
			MOV			CONT0,#0
			MOV			CONT1,#0
			MOV			CONT2,#0
			MOV 		CONT3,#0
			MOV 		CONT4,#0
			MOV 		CONT5,#0
			MOV 		CONT6,#0
			MOV 		CONT7,#0
			MOV			TMOD,#1
			MOV			TL0,#LOW FREQ
			MOV			TH0,#HIGH FREQ
			MOV			IE,#10000010B		;EA = 1 E ET0 = 1										
			SETB		TR0					;TIMER RUN

LOOP:	
			CALL		ATRASO
			INC			CONT0
			MOV			R3,CONT0
			CJNE		R3,#10,LOOP	
			
			MOV			CONT0,#0
			INC			CONT1
			MOV			R3,CONT1
			CJNE		R3,#10,LOOP
			
			MOV			CONT1,#0
			INC			CONT2
			MOV			R3,CONT2
			CJNE		R3,#10,LOOP
			
			MOV			CONT2,#0
			INC			CONT3
			MOV			R3,CONT3
			CJNE		R3,#10,LOOP

			MOV			CONT3,#0
			INC			CONT4
			MOV			R3,CONT4
			CJNE		R3,#10,LOOP

			MOV			CONT4,#0
			INC			CONT5
			MOV			R3,CONT5
			CJNE		R3,#10,LOOP

			MOV			CONT5,#0
			INC			CONT6
			MOV			R3,CONT6
			CJNE		R3,#10,LOOP

			MOV			CONT6,#0
			INC			CONT7
			MOV			R3,CONT7
			CJNE		R3,#10,LOOP
			JMP			LOOP
;------------------------------------------------
DISPLAY_MUX:
			JB			FLAG0,CM0
			JB			FLAG1,CM1
			JB			FLAG2,CM2
			JB			FLAG3,CM3
			JB			FLAG4,CM4
			JB			FLAG5,CM5
			JB			FLAG6,CM6
			JB			FLAG7,CM7

CM0:
			MOV			P2,#11101111B
			MOV			A,CONT0
			CALL		MOSTRA_7SEG
			CLR			FLAG0
			SETB		FLAG1
			JMP			SAIDA_INT

CM1:
	  		MOV			P2,#11111110B
			MOV			A,CONT1
			CALL		MOSTRA_7SEG
			CLR			FLAG1
			SETB		FLAG2
			JMP			SAIDA_INT

CM2:
			MOV			P2,#11111101B
			MOV			A,CONT2
			CALL		MOSTRA_7SEG
			CLR			FLAG2
			SETB		FLAG3
			JMP			SAIDA_INT

CM3:
			MOV			P2,#11111011B
			MOV			A,CONT3
			CALL		MOSTRA_7SEG
			CLR			FLAG3
			SETB		FLAG4
			JMP			SAIDA_INT

CM4:
			MOV			P2,#11110111B
			MOV			A,CONT4
			CALL		MOSTRA_7SEG
			CLR			FLAG4
			SETB		FLAG5
			JMP			SAIDA_INT

CM5:
			MOV			P2,#11011111B
			MOV			A,CONT5
			CALL		MOSTRA_7SEG
			CLR			FLAG5
			SETB		FLAG6
			JMP			SAIDA_INT

CM6:
			MOV			P2,#10111111B
			MOV			A,CONT6
			CALL		MOSTRA_7SEG
			CLR			FLAG6
			SETB		FLAG7
			JMP			SAIDA_INT

CM7:
			MOV			P2,#01111111B
			MOV			A,CONT7
			CALL		MOSTRA_7SEG
			CLR			FLAG7
			SETB		FLAG0
	
SAIDA_INT:
			RETI	

MOSTRA_7SEG:
		
		MOV		DPTR, #NUMEROS
		MOVC 	A, @A+DPTR
		MOV 	P0, A
		RET

ATRASO:
		MOV			R0, #1
ATR1: 	MOV 		R1, #50
ATR2: 	MOV 		R2, #50
		DJNZ 		R2, $
		DJNZ 		R1, ATR2
		DJNZ 		R0, ATR1
		RET

NUMEROS:
		DB 		11000000B, 11111001B, 10100100B, 10110000B, 10011001B, 10010010B, 10000010B, 11111000B, 10000000B, 10010000B
		END	
			
									   	



			



	 												 
			