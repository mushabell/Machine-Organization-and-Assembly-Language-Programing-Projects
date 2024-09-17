;
; Hellow world example program
;also illustrates how to use PUTS (aka: Trap x22)
;
.ORIG x3000
;-------------
;Instructions
;-------------
    LEA R0, MSG_TO_PRINT     ;R0 <-- the location of the label: MSG_TO_PRINT
    PUTS                     ;Prints string defined at MSG_TO_PRINT

    HALT                     ;terminate program
;------------
;local data
;------------
    MSG_TO_PRINT    .STRINGZ    "Hello world!!!\n"   ;store "H" in an adress labelled
                                                     ;MSG_TO_PRINT nd then
                                                     ;charcter ("e", "l", "l", "o", " ", "w"...) in
                                                     ;it's own (consecutive) memory
                                                     ;adress, followed by #0 at the end
                                                     ;of the string to mark the end of the 
                                                     ;string
.END