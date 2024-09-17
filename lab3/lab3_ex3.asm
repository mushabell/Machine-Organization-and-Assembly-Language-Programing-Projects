;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================

.ORIG x3000
;initialize the array and the counting registar
LEA R1, DATA_PTR
AND R2, R2, x0
ADD R2, R2, #10
;promt the user for the inputs
LEA R0, PROMT
PUTS
;loop through the array and assign the input values
DO_WHILE_INPUT
    GETC
    OUT
    STR R0, R1, #0
    ADD R1, R1, #1
    ADD R2, R2, #-1
BRp DO_WHILE_INPUT
END_DO_WHILE_INPUT
;re-initialize the counter variable value and the array registar
ADD R2, R2, #10
LEA R1, DATA_PTR
;print new line for formating
LD R0, NEWLINE
OUT
;print the values in the array
DO_WHILE_OUTPUT
    LDR R0, R1, #0
    OUT
    LD R0, NEWLINE
    OUT
    ADD R1, R1, #1
    ADD R2, R2, #-1
BRp DO_WHILE_OUTPUT
END_DO_WHILE_OUTPUT


HALT

DATA_PTR .BLKW  #10
PROMT   .STRINGZ "Enter exactly 10 characters from the keyboard (no enter or spaces inbetween entries): \n"
NEWLINE .FILL   x0A


.END