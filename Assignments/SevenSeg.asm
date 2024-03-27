;---------------------
; Title: SevenSeg.asm
;---------------------
;Program Details: This Program powers a seven segment display, while allowing
;the connection of two inputs to control incrementing, decrementing, and 
;resetting the display
    
; Inputs: RB0, RB1
; Outputs: RD0,RD1,RD2,RD3,RD4,RD5,RD6,
; Date: 26 March 2024
; File Dependencies / Libraries: AssemblyConfig.inc
; Compiler: IDE v6.20
; Author: Grant Goodwin
; Versions:
;       V1.0: Oriiginal Program

;---------------------
; Initialization
;---------------------
#include ".\AssemblyConfig.inc"
#include <xc.inc>
PSECT absdata,abs,ovrld

;---------------------
; Main Program
;---------------------
    BANKSEL	PORTD 
    CLRF	PORTD 
    BANKSEL	LATD 
    CLRF	LATD 
    BANKSEL	ANSELD 
    CLRF	ANSELD 
    BANKSEL	TRISD 
    MOVLW	0b00000000 
    MOVWF	TRISD 
    
    BANKSEL	PORTB 
    CLRF	PORTB 
    BANKSEL	LATB 
    CLRF	LATB 
    BANKSEL	ANSELB 
    CLRF	ANSELB 
    BANKSEL	TRISB 
    MOVLW	0b11111111 
    MOVWF	TRISB
    
    MOVLW 0b0111111
    MOVWF 0x10,0
    MOVLW 0b0000110
    MOVWF 0x11,0
    MOVLW 0b1011011
    MOVWF 0x12,0
    MOVLW 0b1001111
    MOVWF 0x13,0
    MOVLW 0b1100110
    MOVWF 0x14,0
    MOVLW 0b1101101
    MOVWF 0x15,0
    MOVLW 0b1111101
    MOVWF 0x16,0
    MOVLW 0b0000111
    MOVWF 0x17,0
    MOVLW 0b1111111
    MOVWF 0x18,0
    MOVLW 0b1100111
    MOVWF 0x19,0
    MOVLW 0b1110111
    MOVWF 0x1A,0
    MOVLW 0b1111100
    MOVWF 0x1B,0
    MOVLW 0b0111001
    MOVWF 0x1C,0
    MOVLW 0b1011110
    MOVWF 0x1D,0
    MOVLW 0b1111001
    MOVWF 0x1E,0
    MOVLW 0b1110001
    MOVWF 0x1F,0
    MOVLW 0x4
    MOVWF 0x20,0
    MOVWF 0x0F,0
    

Zero:
    LFSR 0,0x10
    MOVFF INDF0, PORTD
Main:
    CALL Delay
    BTFSC PORTB,0
    CALL INCR,0
    BTFSC PORTB,1
    CALL DECR
    GOTO Main
    
DECR:
    BTFSC PORTB,0
    GOTO Zero
    DECF FSR0L
    MOVFF INDF0,0x1
    MOVLW 0x5
    CPFSGT 0x1
    CALL FSet,1
    MOVFF 0x1,PORTD
    RETURN    
    
INCR:
    BTFSC PORTB,1
    GOTO Zero
    MOVFF PREINC0,0x1
    MOVLW 0x5
    CPFSGT 0x1
    GOTO Zero
    MOVFF 0x1,PORTD
    GOTO Main

Delay:
    MOVLW 0x1
    MOVWF 0x7
    MOVLW 0x5
outer2:
    MOVWF 0x6
outer:    
    MOVWF 0x5 
inner:
    DECF 0x5,1
    BNZ inner
    DECF 0x6,1
    BNZ outer
    DECF 0x7,1
    BNZ outer2
    RETURN 0
    
FSet:
    LFSR 0,0x1F
    MOVFF INDF0,0x1
    RETURN 0   
    
    
    
   
    
    
    