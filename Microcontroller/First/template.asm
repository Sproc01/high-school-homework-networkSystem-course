;**************************************************
;*** Struttura base programma con la PIC 16F84 ***
;***                                            ***
;    [Programma assoluto]
;
; (c) 2015, Federico Melon
;
;**************************************************
        PROCESSOR       16F84A	     ;definizione del tipo di Pic per il quale � stato scritto il programma
        RADIX           DEC	         ;i numeri scritti senza notazione sono da intendersi come decimali
        INCLUDE         "P16F84A.INC" ;inclusione del file che contiene la definizione delle costanti di riferimento al file dei
        							 ;registri (memoria Ram)
        ERRORLEVEL      -302		 ;permette di escludere alcuni errori di compilazione, la  segnalazione  302  ricorda  di 
                                     ;commutare il banco di memoria qualora si utilizzino registri che non stanno nel banco 0


        ;Setup of PIC configuration flags
        ;XT oscillator
        ;Disable watch dog timer
        ;Enable power up timer
        ;Disable code protect
;        __CONFIG        0x3FF1	      ; definizione del file di configurazione
		__CONFIG   _XT_OSC & _CP_OFF & _WDT_OFF &_PWRTE_ON

;=============================================================
;       DEFINE= acronimo di una istruzione completa
;=============================================================
;Definizione comandi
;#define  Bank1	bsf     STATUS,RP0			  ; Attiva banco 1
;#define  Bank0 bcf     STATUS,RP0	          ; Attiva banco 0
;=============================================================
; 		SIMBOLI
;=============================================================
;LABEL	CODE 	OPERANDO	COMMENTO
;=============================================================
LED_ON  EQU     01					  ; Led acceso
LED_OFF EQU	    00					  ; Led spento
;=============================================================
;       AREA DATI
;=============================================================	
;LABEL	CODE 	OPERANDO	COMMENTO
;=============================================================
CounterA EQU     0x0C					  
CounterB EQU     0x0D
					
;=============================================================
;       PROGRAMMA PRINCIPALE
;=============================================================
;LABEL	CODE 	OPERANDO	COMMENTO
;=============================================================        ;Reset Vector
        ;Start point at CPU reset
        ORG     0x0000				  ;	indirizzo di inizio programma      ORG= origine; locazione da cui parte il programma
		goto	Main
;=============================================================
;       INTERRUPT AREA
;=============================================================
		ORG     0x0004				  ;	indirizzo inizio routine interrupt
;
;
		retfie						  ; ritorno programma principale
;=============================================================
;       AREA PROGRAMMA PRINCIPALE
;=============================================================
	Main
;Codice Programma
;        Bank1						  ;	accedo al banco zero del file register per settare I/O porta A e B
        bsf     STATUS,RP0			  ; attiva banco 1
        movlw   B'00000000'
        movwf   TRISA 				  ; bit della porta A definiti come uscite   si possono passare 8 bit alla porta B
        movlw   B'00000000'			  ; bit della porta B definiti come uscite
        movwf   TRISB
;        Bank0						  ; rinposta l'accesso ai registri del banco 1
	    bcf     STATUS,RP0	          ; attiva banco 0
		movlw   LED_ON				  ; sposta in W il valore di LED_ON
		movwf	PORTB				  ; invio in uscita sulla Porta B, B0=1  
		nop
;=============================================================
;       AREA ROUTINE
;=============================================================
;										
        END                           ; Fine programma


 