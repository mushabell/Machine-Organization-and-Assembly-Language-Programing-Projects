;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================

.ORIG x3000

LEA R1, DATA_PTR
AND R2, R2, x0
ADD R2, R2, #10

LEA R0, PROMT
PUTS

DO_WHILE
    GETC
    OUT
    LDR R0, R1, #0
    ADD R1, R1, #1
    ADD R2, R2, #-1
BRp DO_WHILE
END_DO_WHILE

HALT

DATA_PTR .BLKW  #10
PROMT   .STRINGZ "enter exactly 10 characters from the keyboard: \n"


.END