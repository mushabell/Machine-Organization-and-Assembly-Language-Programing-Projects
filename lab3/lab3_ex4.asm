;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================

.ORIG x3000
;initialize the array and the counting registar
LD R1, DATA_PTR     ;the array
LD R2, NEG_SENTINAL ;sentinal value
AND R3, R3, x0      ;the sential control varible


;promt the user for the inputs
LEA R0, PROMT
PUTS

;get the array into the first registar
LEA R1, DATA_PTR

;loop through the array and assign the input values until the key is found.
DO_WHILE_INPUT
    GETC
    OUT
    STR R0, R1, #0
    ADD R1, R1, #1
    ADD R3, R2, R0    ;if the value is zero then it is the sentinal key
BRnp DO_WHILE_INPUT
END_DO_WHILE_INPUT

;print out a new line for formating
LD R0, NEWLINE
OUT

;re-initialize the sential control variable value and the array registar
LEA R1, DATA_PTR
AND R3, R3, x0

;print the values in the array
DO_WHILE_OUTPUT
    LDR R0, R1, #0
    OUT
    ADD R1, R1, #1
    ADD R3, R2, R0
BRnp DO_WHILE_OUTPUT
END_DO_WHILE_OUTPUT

;print out a new line for formating
LD R0, NEWLINE
OUT

HALT

PROMT   .STRINGZ "Enter characters from the keyboard (no enter or spaces inbetween entries and max 100 characters) and type # to end the inputs: \n"
NEWLINE .FILL   x0A
DATA_PTR .FILL  x4000
NEG_SENTINAL .FILL  #-35
ARRAY_SENTINAL .FILL #20
.END

.ORIG x4000
ARRAY  .BLKW  #100
.END