;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 022
; TA: Cody and Sahar
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
;input for first number and save to R1
GETC
OUT
AND R1, R1, x0
ADD R1, R0, #0

;print out an empty line
LD R0, newline
OUT

;input for second number and save to R2
GETC
OUT
AND R2, R2, x0
ADD R2, R0, #0

;print out an empty line
LD R0, newline
OUT

;print the subtraction that will take place
;first number
AND R0, R0, x0
ADD R0, R1, #0
OUT
;space
LD R0, space
OUT
;subtraction sign
LD R0, subtract
OUT
;space
LD R0, space
OUT
;second number
AND R0, R0, x0
ADD R0, R2, #0
OUT
;space
LD R0, space
OUT
;equal sign
LD R0, equal
OUT
;space
LD R0, space
OUT

;convert the ASCII numbers into binary numbers
;must subtract 48 form the ASCII numbers to get the binary numbers (only lets me subtract 16 at a time?)
ADD R1, R1, #-16
ADD R1, R1, #-16
ADD R1, R1, #-16

ADD R2, R2, #-16
ADD R2, R2, #-16
ADD R2, R2, #-16

;turn the positve second number into a negative number by flipping and adding one (2's complement)
NOT R2, R2
ADD R2, R2, #1

;do the subtraction
AND R3, R3, x0
ADD R3, R2, R1

;check if the answer is a negative number
BRzp NON_NEG
    ;print out the negative sign
    LD R0, subtract
    OUT
    ;convert the answer from negative to positive (2's complement)
    NOT R3, R3
    ADD R3, R3, #1
NON_NEG

;convert the binary number back to ASCII to print the answer (only lets me add 15 at a time?)
ADD R0, R3, x0
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT

;print a newline for formating
LD R0, newline
OUT

HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL x0A	; newline character - use with LD followed by OUT
subtract .FILL x2D  ; subtraction character
equal    .FILL x3D  ;equal sign character
space    .FILL x20  ;space character



;---------------	
;END of PROGRAM
;---------------	
.END

