;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 8, ex 2
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
;prompt the user
LEA R0, prompt
PUTS

;get the input a echo it to the terminal
AND R0, R0, x0
GETC
OUT

;save the input
ADD R1, R0, #0

;count the number of one's
LD R5, PARITY_CHECK
JSRR R5

;output a new line
AND R0, R0, x0
LD R0, newLine
OUT

;output the statement
AND R0, R0, x0
LEA R0, ending_string_p1
PUTS

AND R0, R0, x0
ADD R0, R1, #0
OUT

LEA R0, ending_string_p2
PUTS

LD R4, conversion_num
ADD R3, R3, R4
AND R0, R0, x0
ADD R0, R0, R3
OUT

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr    .FILL xFE00
newLine           .FILL #10
prompt            .STRINGZ "Please type one character: "
PARITY_CHECK      .FILL x3600
ending_string_p1  .STRINGZ "The number of 1’s in '"
ending_string_p2  .STRINGZ "' is: "
conversion_num    .FILL #48

.end

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: (R1) holds the user inputed character
; Postcondition: Count number of 1s in the binary form of R1
; Return Value (R3): the number of ones that are in the binary form of R1
;=================================================
.orig x3600
; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0
ADD R6, R6, #-1
STR R1, R6, #0 

;stores the number of times we must print a value
MAIN_LOOP
    ADD R1, R1, #0
    ;checks if the first bit is positive or negative and calls on the respective loop
    BRzp SHIFT_LEFT  ;<-- if the value is zero or positive
    BRn COUNT   ;<-- if the value is negative
    
    ;add one to the counter variable
    COUNT
        ADD R3, R3, #1
    
    ;shifts to the left once by adding the value to itself (multiplying by 2)
    SHIFT_LEFT
        ADD R1, R1, R1

    BRnp MAIN_LOOP
END_MAIN_LOOP

; Restore registers
LDR R1, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1

RET

.end