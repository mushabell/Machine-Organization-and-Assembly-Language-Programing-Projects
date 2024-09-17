;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 4, ex 2
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================
.ORIG x3000
LD R1, ARRAY_PTR
LD R5, sub_PTR_3200
JSRR R5
AND R5, R5, x0
LD R5, sub_PTR_3400
JSRR R5

HALT
ARRAY_PTR .FILL  x4000
sub_PTR_3200   .FILL x3200
sub_PTR_3400   .FILL x3400
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY_3200
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3200
LDR R3, R1, #0
DO_WHILE_3200
    ADD R1, R1, #1
    ADD R3, R3, #1
    STR R3, R1, #0
    ADD R4, R3, #-9
BRn  DO_WHILE_3200
END_DO_WHILE_3200
LD R1, ARRAY_PTR_3200

RET
ARRAY_PTR_3200 .FILL x4000
.END
;------------------------------------------------------------------------
; Subroutine: SUB_CONVERT_ARRAY_3400
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (number) in the array should be represented as a character. E.g. 0 -> ‘0’
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3400
AND R3, R3, x0
ADD R3, R3, #15
ADD R3, R3, #15
ADD R3, R3, #15
ADD R3, R3, #3
AND R4, R4, x0
ADD R4, R4, #-16
ADD R4, R4, #-16
ADD R4, R4, #-16
ADD R4, R4, #-9
DO_WHILE_3400
    AND R4, R4, x0
    ADD R4, R4, #-16
    ADD R4, R4, #-16
    ADD R4, R4, #-16
    ADD R4, R4, #-9
    LDR R6, R1, #0
    ADD R6, R6, R3
    STR R6, R1, #0
    ADD R1, R1, #1
    ADD R4, R4, R6
BRn  DO_WHILE_3400
END_DO_WHILE_3400
LD R1, ARRAY_PTR_3400

RET
ARRAY_PTR_3400  .FILL  x4000
.END

;-------------------------------------------------------------------------
.ORIG x4000
ARRAY   .BLKW   #10
.FILL   #0
.END