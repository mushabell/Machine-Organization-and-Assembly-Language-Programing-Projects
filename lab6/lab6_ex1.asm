;=================================================
; Name: Amshu Bellur
; Email: abell062
; 
; Lab: lab 5, ex 1
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================
.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE

; your code goes here
LD R5, sub_PTR_3200
JSRR R5
halt

; your local data goes here
DATA_PTR  .FILL  x4000
sub_PTR_3200  .FILL x3200
top_stack_addr .fill xFE00 ; DO NOT MODIFY THIS LINE OF CODE
.end

; your subroutines go below here
;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING_3200
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
.ORIG x3200
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0

AND R0, R0, x0
LEA R0, PROMT_3200
PUTS

LEA R1, DATA_PTR_3200
AND R5, R5, x0
DO_WHILE_INPUT
    GETC
    OUT
    ADD R5, R5, #1
    STR R0, R1, #0
    ADD R1, R1, #1
    ADD R3, R0, #-10
BRnp DO_WHILE_INPUT
END_DO_WHILE_INPUT

LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET
DATA_PTR_3200  .FILL  x4000
PROMT_3200 .STRINGZ "Please type the phrase you want to check: "

.END
;-------------------------------------------------------------------------
.ORIG x4000
ARRAY  .BLKW  #100
.END
