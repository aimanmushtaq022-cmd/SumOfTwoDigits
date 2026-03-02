 
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; =====================================================================
; PROGRAM INFORMATION
; =====================================================================
; Program Name  : Sum of Two Decimal Digits
; Processor     : Intel 8086 Microprocessor
; Emulator      : EMU8086
; Interrupt     : INT 21H
; =====================================================================
; Objective     :
;                 1. Display prompt "Enter two digits:"
;                 2. Accept two decimal digits from keyboard
;                 3. Add the two digits
;                 4. Display the sum
; =====================================================================
;
; -------------------------------
; INPUT - PROCESS - OUTPUT
; -------------------------------
; Input   : Two decimal digits (e.g., 3 and 7)
; Process : Convert ASCII to numeric, add, convert back to ASCII
; Output  : THE SUM OF 3 AND 7 IS 10
;
; -------------------------------
; REGISTERS USED
; -------------------------------
; AX | Accumulator (16-bit)     | DOS functions & arithmetic
; AH | Accumulator High (8-bit) | Stores DOS function number
; AL | Accumulator Low (8-bit)  | Stores input character
; CL | Counter Low (8-bit)      | Stores first digit (numeric)
; CH | Counter High (8-bit)     | Stores second digit (numeric)
; DX | Data Register (16-bit)   | Holds address of string
; DL | Data Low (8-bit)         | Holds character for output
; DS | Data Segment Register    | Points to DATA segment
;
; -------------------------------
; DOS FUNCTIONS USED (INT 21H)
; -------------------------------
; AH = 01H -> Input Single Character (returned in AL)
; AH = 02H -> Display Single Character (character in DL)
; AH = 09H -> Display String (address in DX, ends with $)
; AH = 4CH -> Terminate Program
; =====================================================================

.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 0DH,0AH,'THE SUM OF $'
    MSG2 DB ' AND $'
    MSG3 DB ' IS $'

.CODE

MAIN PROC

    MOV AX,@DATA              ; Load DATA segment address into AX
    MOV DS,AX                 ; Initialize DS register

; -------------------------
; Display prompt "?"
; -------------------------

    MOV DL,'?'                ; Load '?' into DL
    MOV AH,02H                ; DOS function: display character
    INT 21H                   ; Display '?'

; -------------------------
; Input First Digit
; -------------------------

    MOV AH,01H                ; DOS function: read character
    INT 21H                   ; AL = first digit (ASCII)
    MOV CL,AL                 ; CL = Counter Low, store first digit
    SUB CL,30H                ; Convert ASCII to numeric

; -------------------------
; Input Second Digit
; -------------------------

    MOV AH,01H                ; DOS function: read character
    INT 21H                   ; AL = second digit (ASCII)
    MOV CH,AL                 ; CH = Counter High, store second digit
    SUB CH,30H                ; Convert ASCII to numeric

; -------------------------
; Add Two Digits
; -------------------------

    MOV AL,CL                 ; Move first digit to AL
    ADD AL,CH                 ; Add second digit
    MOV BL,AL                 ; Save result in BL (numeric sum)

; -------------------------
; Display MSG1 "THE SUM OF "
; -------------------------

    LEA DX,MSG1               ; Load address of MSG1
    MOV AH,09H                ; DOS function: display string
    INT 21H                   ; Display MSG1

; -------------------------
; Display First Digit
; -------------------------

    MOV DL,CL                 ; Move first digit to DL
    ADD DL,30H                ; Convert to ASCII
    MOV AH,02H                ; DOS function: display character
    INT 21H                   ; Display first digit

; -------------------------
; Display MSG2 " AND "
; -------------------------

    LEA DX,MSG2               ; Load address of MSG2
    MOV AH,09H                ; DOS function: display string
    INT 21H                   ; Display MSG2

; -------------------------
; Display Second Digit
; -------------------------

    MOV DL,CH                 ; Move second digit to DL
    ADD DL,30H                ; Convert to ASCII
    MOV AH,02H                ; DOS function: display character
    INT 21H                   ; Display second digit

; -------------------------
; Display MSG3 " IS "
; -------------------------

    LEA DX,MSG3               ; Load address of MSG3
    MOV AH,09H                ; DOS function: display string
    INT 21H                   ; Display MSG3

; -------------------------
; Display Sum
; -------------------------

    MOV AL,BL                 ; Load numeric sum
    CMP AL,9                  ; Check if sum >= 10
    JBE SINGLE_DIGIT          ; If sum <= 9, single digit
                              
    ; For double digit (10-18)
    MOV AH,0                  ; Clear AH
    MOV BL,AL                 ; Save sum
    MOV AL,BL
    DIV BYTE PTR 10            ; AL = quotient, AH = remainder
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H                   ; Display tens digit

    MOV AL,AH                 ; AH had remainder
    ADD AL,30H
    MOV DL,AL
    MOV AH,02H
    INT 21H                   ; Display units digit
    JMP END_PROGRAM

SINGLE_DIGIT:
    ADD AL,30H                ; Convert to ASCII
    MOV DL,AL
    MOV AH,02H
    INT 21H                   ; Display sum

END_PROGRAM:
; -------------------------
; Program Termination
; -------------------------

    MOV AH,4CH                ; DOS function: terminate program
    INT 21H                   ; Return control to DOS

MAIN ENDP
END MAIN

ret






ret




