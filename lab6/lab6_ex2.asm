;=================================================
; Name: Amshu Bellur
; Email: abell062
; 
; Lab: lab 5, ex 2
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================
.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE
LD R1, DATA_PTR
; your code goes here
LD R5, sub_PTR_3200
JSRR R5
LD R4, sub_PTR_3400
JSRR R4

halt

; your local data goes here
DATA_PTR  .FILL  x4000
sub_PTR_3200  .FILL x3200
sub_PTR_3400  .FILL x3400
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
ADD R5, R5, #-1

LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET
PROMT_3200 .STRINGZ "Please type the phrase you want to check: "

.END

;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME_3400
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
.ORIG x3400
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R5, R6, #0

AND R4, R4, x0
ADD R4, R4, #1
ADD R3, R1, R5
ADD R3, R3, #-1
DO_WHILE_PAL_CHECK
    LDR R2, R1, #0
    LDR R7, R3, #0
    NOT R2, R2
    ADD R2, R2, #1
    ADD R0, R2, R7
    BRnp NOT_PAL
    ADD R3, R3, #-1
    ADD R1, R1, #1
    ADD R5, R5, #-2
    BRp DO_WHILE_PAL_CHECK
    BRnz POS
END_DO_WHILE_PAL_CHECK

NOT_PAL
    AND R4, R4, x0
    ADD R4, R4, #0
END_NOT_PAL

POS

LDR R5, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET

.END

;-------------------------------------------------------------------------
.ORIG x4000
ARRAY  .BLKW  #100
.END
