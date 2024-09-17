;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 022
; TA: Cody and Sahar
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

;stores the number of times we must print a value
LD R2, NumOfBits
MAIN_LOOP
    ADD R1, R1, #0
    ;checks if the first bit is positive or negative and calls on the respective loop
    BRzp PRINT_VALUE_0  ;<-- if the value is zero or positive
    BRn PRINT_VALUE_1   ;<-- if the value is negative
    
    ;prints out the value 0 and calls on shift left
    PRINT_VALUE_0
        LD R0, NumZero
        OUT
        BR SHIFT_LEFT   ;<-- goes to next bit
    END_PRINT_VALUE_0
    
    ;prints out the value 1 and calls on left shift
    PRINT_VALUE_1
        LD R0, NumOne
        OUT
        BR SHIFT_LEFT   ;<-- goes to next bit
    END_PRINT_VALUE_1
    
    ;shifts to the left once by adding the value to itself (multiplying by 2)
    SHIFT_LEFT
        ADD R1, R1, R1
        BR CHECK_SPACE
    END_SHIFT_LEFT
    
    ;decrements the count of the numbers we must print
    DECREMENT_COUNT
        ADD R2, R2, #-1
    END_DECREMENT_COUNT

    BRp MAIN_LOOP
END_MAIN_LOOP

;checks where I need to place space or when to finish the program
CHECK_SPACE
    ADD R3, R2, #-5
    BRz PRINT_VALUE_SPACE
    ADD R3, R2, #-9
    BRz PRINT_VALUE_SPACE
    ADD R3, R2, #-13
    BRz PRINT_VALUE_SPACE
    ADD R3, R2, #-15
    ADD R3, R2, #-1
    BRz FINISH_PROGRAM
    BR DECREMENT_COUNT
END_CHECK_SPACE

;prints out a space for formatting
PRINT_VALUE_SPACE
    LD R0, Space
    OUT
    BR DECREMENT_COUNT
END_PRINT_VALUE_SPACE

;not sure why I get an infinite loop with my main_loop, but this solves the problem?
FINISH_PROGRAM
    ADD R2, R2, #-15
END_FINISH_PROGRAM


;print out a new line after all the values are printed
LD R0, NewLine
OUT

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
NumOfBits   .FILL #16
NumZero     .FILL #48
NumOne      .FILL #49
NewLine     .FILL #10
Space       .FILL #32
.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
