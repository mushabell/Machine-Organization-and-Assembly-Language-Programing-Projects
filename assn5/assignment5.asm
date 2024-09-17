; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 022
; TA: Cody and Sahar
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stack
ld r6, stack_addr

; call main subroutine
lea r5, main
jsrr r5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
; get a string from the user
LEA R1, user_prompt
LD R2, array_ptr
LD R5, get_user_string_addr
JSRR R5

; find size of input string
LD R1, array_ptr
LD R5, strlen_addr
JSRR R5

; call palindrome method
LD R1, array_ptr
ADD R2, R1, R0
ADD R2, R2, #-1
ADD R3, R0, #0
AND R0, R0, x0
ADD R0, R0, #1
LD R5, palindrome_addr
JSRR R5

; determine of stirng is a palindrome
AND R3, R3, x0
ADD R3, R3, R0
AND R0, R0, x0
LEA R0, result_string
PUTS
ADD R3, R3, #0
BRp FINAL
BRz WITH_NOT

; print the result to the screen
WITH_NOT
LEA R0, not_string
PUTS
END_WITH_NOT

FINAL
LEA R0, final_string
PUTS
END_FINAL

HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400
array_ptr            .FILL    x4000


; Reserve memory for strings in the progrtam
user_prompt          .STRINGZ "Enter a string: "
result_string        .STRINGZ "The string is "
not_string           .STRINGZ "not "
final_string         .STRINGZ	"a palindrome\n"

.END

;---------------------------------------------------------------------------------
; Subroutine: get_user_string_3200
; Parameter (R1): The address of the user prompr string
; Parameter (R2): The address where the user string is stored
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value: none
;	R2 contains the starting address of the array unchanged.
;---------------------------------------------------------------------------------
.ORIG x3200
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0

AND R0, R0, x0
ADD R0, R1, R0
PUTS

BR DO_WHILE_INPUT

Backspace
LD R3, zero
ADD R2, R2, #-1
STR R3, R2, #0
ADD R2, R2, #-1
STR R3, R2, #0

DO_WHILE_INPUT
    GETC
    OUT
    STR R0, R2, #0
    ADD R2, R2, #1
    ADD R3, R0, #-8
    BRz Backspace
    ADD R3, R0, #-10
BRnp DO_WHILE_INPUT
END_DO_WHILE_INPUT

ADD R2, R2, #-1
LD R3, zero
STR R3, R2, #0

LDR R2, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET
zero             .FILL    #0
.END


;---------------------------------------------------------------------------------
; Subroutine: strlen_3300
; Parameter (R1): The starting address of the string
; Postcondition: Compute the length of a zero terminated string
; Return Value (R0): The number of values in the array that the user typed
;	R1 contains the starting address of the array unchanged.
;---------------------------------------------------------------------------------
.ORIG x3300
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0

AND R0, R0, x0

DO_WHILE_COUNT
    LDR R3, R1, #0
    BRz FINISH
    ADD R0, R0, #1
    ADD R1, R1, #1
    BR DO_WHILE_COUNT
END_DO_WHILE_COUNT

ADD R0, R0, #-1

FINISH
LDR R3, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET

.END

;---------------------------------------------------------------------------------
; Subroutine: palindrome_3400
; Parameter (R1): The address of the first character of the string
; Parameter (R2): The address of the last character of the string
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R0 {1 if the string is a palindrome, 0 otherwise}
;---------------------------------------------------------------------------------
.ORIG x3400
palindrome_jsr
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0
ADD R6, R6, #-1
STR R2, R6, #0

LDR R5, R1, #0
LDR R7, R2, #0
NOT R5, R5
ADD R5, R5, #1
AND R4, R4, x0
ADD R4, R5, R7
BRnp NOT_PAL
ADD R2, R2, #-1
ADD R1, R1, #1
ADD R3, R3, #-2
BRnz ENDING
jsr palindrome_jsr
br ending

NOT_PAL
    AND R0, R0, x0
    ADD R0, R0, #0

ENDING

LDR R2, R6, #0
ADD R6, R6, #1
LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET
palindrome_addr_3400      .FILL	  x3400
.END

;---------------------------------------------------------------------------------
;storage for the user input string
.ORIG X4000
user_string  .BLKW  #100
.END

