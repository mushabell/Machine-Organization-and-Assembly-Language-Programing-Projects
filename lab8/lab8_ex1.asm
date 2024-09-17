;=================================================
; Name: Amshu Bellur
; Email: abell062@ucr.edu
; 
; Lab: lab 8, ex 1
; Lab section: 022
; TA: Cody and Sahar
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LD R5, LOAD_FILL_VALUE
JSRR R5

ADD R2, R2, #1

LD R5, OUTPUT_AS_DECIMAL
JSRR R5

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
LOAD_FILL_VALUE .fill x3200
OUTPUT_AS_DECIMAL .fill x3400

.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: none
; Postcondition: take a hard-coded value, and load it into a register of your choice
; Return Value: (R2) The value of the fixed number
;=================================================
.orig x3200
; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0

LD R2, VALUE

; Restore registers
LDR R7, R6, #0
ADD R6, R6, #1
RET
VALUE .FILL #32766
.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: (R2) The value of the fixed number
; Postcondition: prints the value in the parameter onto the console
; Return Value: none
;=================================================
.orig x3400
; Backup registers
ADD R6, R6, #-1
STR R7, R6, #0

;check if the value is negative
ADD R3, R2, #0
BRn neg
BRzp pos

neg
    LD R0, negative_sign
    OUT
    NOT R2, R2
    ADD R2, R2, #1
END_neg

pos
;checking for 5th digit place
AND R3, R3, x0
FIFTH_PLACE
    LD R1, neg_ten_thousand
    ADD R4, R2, R1
    BRn NO_FIVE
    ADD R2, R2, R1
    ADD R3, R3, #1
    BR FIFTH_PLACE
END_FIFTH_PLACE

NO_FIVE
    ADD R3, R3, #0
    BRnz FOURTH
    AND R0, R0, x0
    ADD R0, R0, R3
    LD R1, num_conversion
    ADD R0, R0, R1
    OUT
END_NO_FIVE

;checking for 4th digit place
FOURTH
AND R3, R3, x0
AND R4, R4, x0
FOURTH_PLACE
    LD R1, neg_thousand
    ADD R4, R2, R1
    BRn NO_FOUR
    ADD R2, R2, R1
    ADD R3, R3, #1
    BR FOURTH_PLACE
END_FOURTH_PLACE

NO_FOUR
    ADD R3, R3, #0
    BRnz THIRD
    AND R0, R0, x0
    ADD R0, R0, R3
    LD R1, num_conversion
    ADD R0, R0, R1
    OUT
END_NO_FOUR

;checking for 3rd digit place
THIRD
AND R3, R3, x0
AND R4, R4, x0
THIRD_PLACE
    LD R1, neg_hundred
    ADD R4, R2, R1
    BRn NO_THREE
    ADD R2, R2, R1
    ADD R3, R3, #1
    BR THIRD_PLACE
END_THIRD_PLACE

NO_THREE
    ADD R3, R3, #0
    BRnz SECOND
    AND R0, R0, x0
    ADD R0, R0, R3
    LD R1, num_conversion
    ADD R0, R0, R1
    OUT
END_NO_THREE

;checking for 2nd digit place
SECOND
AND R3, R3, x0
AND R4, R4, x0
SECOND_PLACE
    LD R1, neg_ten
    ADD R4, R2, R1
    BRn NO_TWO
    ADD R2, R2, R1
    ADD R3, R3, #1
    BR SECOND_PLACE
END_SECOND_PLACE

NO_TWO
    ADD R3, R3, #0
    BRnz FIRST
    AND R0, R0, x0
    ADD R0, R0, R3
    LD R1, num_conversion
    ADD R0, R0, R1
    OUT
END_NO_TWO

;checking for 4th digit place
FIRST
AND R3, R3, x0
AND R4, R4, x0
FIRST_PLACE
    LD R1, neg_one
    ADD R4, R2, R1
    BRn NO_ONE
    ADD R2, R2, R1
    ADD R3, R3, #1
    BR FIRST_PLACE
END_FIRST_PLACE

NO_ONE
    ADD R3, R3, #0
    BRnz DONE
    AND R0, R0, x0
    ADD R0, R0, R3
    LD R1, num_conversion
    ADD R0, R0, R1
    OUT
END_NO_ONE

DONE

; Restore registers
LDR R7, R6, #0
ADD R6, R6, #1
RET
negative_sign     .fill x2D
neg_ten_thousand  .fill #-10000
neg_thousand      .fill #-1000
neg_hundred       .fill #-100
neg_ten           .fill #-10
neg_one           .fill #-1
num_conversion    .fill #48
.end