;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 4, ex 4 fixed
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================
.ORIG x3000
LD R6, STACK_ADDR
LD R1, ARRAY_PTR
LD R5, sub_PTR_3200
JSRR R5
AND R5, R5, x0
LD R5, sub_PTR_3400
JSRR R5
AND R5, R5, x0
LD R5, sub_PTR_3800
JSRR R5

HALT
ARRAY_PTR .FILL  x4000
sub_PTR_3200   .FILL x3200
sub_PTR_3400   .FILL x3400
sub_PTR_3800   .FILL x3800
STACK_ADDR      .FILL xFE00
.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY_3200
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3200
ADD R6, R6, #-1
STR R7, R6, #0
LDR R3, R1, #0
DO_WHILE_3200
    ADD R1, R1, #1
    ADD R3, R3, #1
    STR R3, R1, #0
    ADD R4, R3, #-9
BRn  DO_WHILE_3200
END_DO_WHILE_3200
LD R1, ARRAY_PTR_3200

LDR R7, R6, #0
add R6, R6, #1

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
ADD R6, R6, #-1
STR R7, R6, #0

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
    LDR R2, R1, #0
    ADD R2, R2, R3
    STR R2, R1, #0
    ADD R1, R1, #1
    ADD R4, R4, R2
BRn  DO_WHILE_3400
END_DO_WHILE_3400
LD R1, ARRAY_PTR_3400

LDR R7, R6, #0
ADD R6, R6, #-1

RET
ARRAY_PTR_3400  .FILL  x4000
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRINT_ARRAY_3600
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (character) in the array is printed out to the console.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3600
ADD R6, R6, #-1
STR R7, R6, #0
AND R3, R3, x0
ADD R3, R3, #10
DO_WHILE_3600
    LDR R0, R1, #0
    OUT
    ADD R1, R1, #1
    ADD R3, R3, #-1
BRp DO_WHILE_3600
END_DO_WHILE_3600
LD R1, ARRAY_PTR_3600

LDR R7, R6, #0
ADD R6, R6, #-1

RET
ARRAY_PTR_3600  .FILL x4000
.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRETTY_PRINT_ARRAY_3800
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Prints out “=====” (5 equal signs), prints out the array, and after prints out “=====” again.
; Return Value (None)
;-------------------------------------------------------------------------
.ORIG x3800
ADD R6, R6, #-1
STR R7, R6, #0
AND R3, R3, x0
ADD R3, R3, #5
DO_WHILE_3800
    LEA R0, EQUAL
    PUTS
    ADD R3, R3, #-1
BRp DO_WHILE_3800
END_DO_WHILE_3800
LD R1, ARRAY_PTR_3800
AND R5, R5, x0
LD R5, sub_PTR_3600
JSRR R5
AND R3, R3, x0
ADD R3, R3, #5
DO_WHILE_3800_2
    LEA R0, EQUAL
    PUTS
    ADD R3, R3, #-1
BRp DO_WHILE_3800_2
END_DO_WHILE_3800_2

LDR R7, R6, #0
ADD R6, R6, #-1

RET
ARRAY_PTR_3800  .FILL x4000
EQUAL   .STRINGZ   "="
sub_PTR_3600   .FILL x3600
sub_PTR_36_3800   .FILL x3800
.END 

;-------------------------------------------------------------------------
.ORIG x4000
ARRAY   .BLKW   #10
.FILL   #0
.END



