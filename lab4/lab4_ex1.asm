;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 4, ex 1
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================
.ORIG x3000
LD R1, ARRAY_PTR
LDR R2, R1, #0
ADD R3, R3, x0
ADD R3, R3, #1
LD R5, sub_PTR_3200
JSRR R5

HALT
ARRAY_PTR .FILL  x4000
sub_PTR_3200   .FILL x3200
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY_3200
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3200
DO_WHILE
    ADD R1, R1, #1
    STR R3, R1, #0
    ADD R3, R3, #1
    ADD R4, R3, #-9
BRnz  DO_WHILE
END_DO_WHILE
LD R1, ARRAY_PTR_sub

HALT
ARRAY_PTR_sub .FILL x4000
RET
.END
;-------------------------------------------------------------------------
.ORIG x4000
ARRAY   .BLKW   #10
.FILL   #0
.END