;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 022
; TA: Cody and Sahar
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------

beginning
; Set up flags, counters, accumulators as needed
AND R0, R0, x0
AND R1, R1, x0
AND R2, R2, x0  ;negative flag
AND R3, R3, x0  ;counter
ADD R3, R3, #5
AND R4, R4, x0  ;answer
AND R5, R5, x0  ;input checking
AND R6, R6, x0  ;r4 multiplyer
AND R7, R7, x0  ;currentDigits

; output intro prompt
LD R0, introPromptPtr
PUTS

; Get first character, test for '\n', '+', '-', digit/non-digit 
GETC
OUT

; is very first character = '\n'? if so, just quit (no message)!
LD R5, newLine
NOT R5, R5 
ADD R5, R5, #1
ADD R5, R0, R5
BRz finish

; is it = '+'? if so, ignore it, go get digits
LD R5, plus
ADD R7, R7, #-1
ADD R5, R0, R5
BRz nextChar

; is it = '-'? if so, set neg flag, go get digits
LD R5, neg
ADD R5, R0, R5
BRz negFlag
BRnp contCheck

;sets R2 to one if the value is negative
negFlag
ADD R2, R2, #1

;gets the next character if passing the initial test
nextChar
GETC
OUT

contCheck
;check if the character is a newline
LD R5, newLine
NOT R5, R5
ADD R5, R5, #1
ADD R5, R5, R0
BRz checkNeg

; is it < '0'? if so, it is not a digit	- o/p error message, start over
LD R5, decZero
ADD R5, R5, R0
BRn Error

; is it > '9'? if so, it is not a digit	- o/p error message, start over
LD R5, decNine
ADD R5, R5, R0
BRp Error

; if none of the above, first character is first numeric digit - convert it to number & store in target register!
AND R6, R6, x0
ADD R6, R6, #9
AND R1, R1, x0
ADD R1, R1, R4
;multiply R4 by 10
multiplyLoop
    ADD R4, R4, R1
    ADD R6, R6, #-1
BRp multiplyLoop
END_multiplyLoop
;add the new value after converting from ASCII
LD R5, decZero
ADD R0, R0, R5
ADD R4, R4, R0

; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
ADD R3, R3, #-1
BRp nextChar
BRnz checkNeg

;print the error message and restart the program
Error
LD R0, newLine
OUT
BR beginning

;check if the value was negative
checkNeg
ADD R2, R2, #0
BRp flipNum
BRnz finish

;if the value was negative, takes the twps complement
flipNum
NOT R4, R4
ADD R4, R4, #1

; remember to end with a newline!
finish
LD R0, newLine

HALT

;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200
newLine         .FILL #10
plus            .FILL #-43
neg             .FILL #-45
decZero         .FILL #-48
decNine         .FILL #-57

.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.