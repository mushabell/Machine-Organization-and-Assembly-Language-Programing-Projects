;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================

.ORIG x3000

LD R1, DATA_PTR

LDR R3, R1, #0
LDR R4, R1, #1

ADD R3, R3, #1
ADD R4, R4, #1

STR R3, R1, #0
STR R4, R1, #1

HALT

DATA_PTR .FILL x4000
.END

.ORIG x4000
DEC_65  .FILL   #65
HEX_41  .FILL   #70

.END