TITLE TDA(Tiny Decryption Algorithm)    (Decryption.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data?
    MSG DWORD 99 DUP(?)         ; Empty memory for Input Message
    LEN BYTE DUP(?)             ; Input Length
    OUTER_COUNTER DWORD DUP(?)  ; Inner loop counter


.data 
    KEY_0 DWORD 1   ; Key
    KEY_1 DWORD 3
    KEY_2 DWORD 50
    KEY_3 DWORD 100

    DELTA DWORD 9e3779b9H
    SUM DWORD 0C6EF3720H

    INNER_COUNTER DWORD 32 

.code 
main PROC 
    ; Taking Input Length from User *LENGTH SHOULD BE EVEN And Between 00 - 99*
    ;----------------------------------------------
    ; Translating 10^1
    MOV AH, 1H      ;Code to read a character (Character Saved in AL)
                    ; EAX = 00 00 AH(01) AL(00)
    INT 21H         ;Dos Interrupt 
                    ; EAX = 00 00 AH(01) AL(USER_INPUT1)
    MOV AH, 0       ; EAX = 00 00 AH(00) AL(USER_INPUT1)
    SUB AL, 48      ; Convert from ASCII to Number
    MUL 10          ; AX = (USER_INPUT1 - 48)*10 
    MOV LEN, AL     ; LEN = USER_INPUT1*10

    ; Translating 10^0
    MOV AH, 1H      ;Code to read a character (Character Saved in AL)
                    ; EAX = 00 00 AH(01) AL(00)
    INT 21H         ;Dos Interrupt 
                    ; EAX = 00 00 AH(01) AL(USER_INPUT0)
    MOV AH, 0       ; EAX = 00 00 AH(00) AL(USER_INPUT0)
    SUB AL, 48      ; Convert from ASCII to Number
    ADD LEN, AL     ; LEN = USER_INPUT1*10 + USER_INPUT0
    ;----------------------------------------------

    ; Taking Input Message from User
    ;----------------------------------------------
    MOV ECX, LEN        ; ECX = length of input string
    MOV EBX, 0
    LOOP_MESSAGE:
        MOV AH, 1H           ;Code to read a character (Character Saved in AL)
                             ; EAX = 00 00 AH(01) AL(00)
        INT 21H              ;Dos Interrupt 
                             ; EAX = 00 00 AH(01) AL(USER_CHAR)
        MOVZX MSG[EBX], AL   ; MSG = USER_CHAR *Relative addressing*
        INC EBX 
    LOOP LOOP_MESSAGE
    ;----------------------------------------------

     ; Decryptin the Whole Message
    ;----------------------------------------------
    MOVZX ECX, LEN          ; ECX = length of input string
    MOV OUTER_COUNTER, ECX  ; OUTER_COUNTER = Length of string

    MOV EDX, 0
    MOV ECX, OUTER_COUNTER  ; ECX = OUTER_COUNTER
    LOOP_DECRYPT_MESSAGE:
        ; Inner Loop
        ;----------------------------------------------
        ; Begining of the loop
        MOV SUM, 0C6EF3720H     ; SUM = 0X0C6EF3720
        MOV ECX, INNER_COUNTER  ; ECX = INNER_COUNTER
        LOOP_I:
            ; In use EAX(Temp) , ECX(Temp) , EBX(Temp)
            ; Calculating V[1]
            MOV EAX, MSG[EDX]           ; EAX = V[0]
            SHL EAX, 4                  ; EAX = (V[0]<<4)
            ADD EAX, KEY_2              ; EAX = (V[0]<<4 + KEY[2])
            MOV EBX, MSG[EDX]           ; EBX = V[0]
            ADD EBX, SUM                ; EBX = V[0] + sum
            XOR EAX, EBX                ; EAX = (V[0]<<4 + KEY[2]) ^ (V[0] + sum)
            MOV EBX, MSG[EDX]           ; EBX = V[0]
            SHR EBX, 5                  ; EBX = V[0]>>5
            ADD EBX, KEY_3              ; EBX = V[0]>>5 + KEY[3]
            XOR EAX, EBX                ; EAX = (V[0]<<4 + KEY[2]) ^ (V[0] + sum) ^ (V[0]>>5 + KEY[3])
            SUB MSG[EDX+1] , EAX        ; V[1] -= (V[0]<<4 + KEY[2]) ^ (V[0] + sum) ^ (V[0]>>5 + KEY[3])

            ; Calculating V[0]
            MOV EAX, MSG[EDX+1]         ; EAX = V[1]
            SHL EAX, 4                  ; EAX = (V[1]<<4)
            ADD EAX, KEY_0              ; EAX = (V[1]<<4 + KEY[0])
            MOV EBX, MSG[EDX+1]         ; EBX = V[1]
            ADD EBX, SUM                ; EBX = V[1] + sum
            XOR EAX, EBX                ; EAX = (V[1]<<4 + KEY[0]) ^ (V[1] + sum)
            MOV EBX, MSG[EDX+1]         ; EBX = V[1]
            SHR EBX, 5                  ; EBX = V[1]>>5
            ADD EBX, KEY_1              ; EBX = V[1]>>5 + KEY[1]
            XOR EAX, EBX                ; EAX = (V[1]<<4 + KEY[0]) ^ (V[1] + sum) ^ (V[1]>>5 + KEY[1])
            SUB MSG[EDX] , EAX          ; V[0] -= (V[1]<<4 + KEY[0]) ^ (V[1] + sum) ^ V[1]>>5 + KEY[1]

            MOV EBX, DELTA      ; EBX =  0x9e3779b9
            SUB SUM, EBX        ; SUM -= 0x9e3779b9

        LOOP LOOP_I
        ;----------------------------------------------

        ADD EDX, 2      ; EDX += 2

        MOV ECX, OUTER_COUNTER

        MOV EAX, OUTER_COUNTER 
        SUB EAX, 1 
        MOV OUTER_COUNTER, EAX 

    LOOP LOOP_DECRYPT_MESSAGE
    ;----------------------------------------------

    ; Displaying Output 
    ;----------------------------------------------
    MOVZX DISPLAY_OUTER_COUNTER, LEN 
    MOV ECX, DISPLAY_OUTER_COUNTER
    MOV ESI, 0
    DISPLAY_OUTER_LOOP:

        MOV EBX, MSG[ESI]
        MOV ECX, 4
        DISPLAY_INNER_LOOP:
            MOV AL, BL          ; AL = BL  
            MOV DL, AL          ;Copy Character to DL
            MOV AH, 21H         ;Code to write a character
            INT 21H             ;Display Character in DL
            SHR EBX, 8          ; EAX >> 8
        LOOP DISPLAY_INNER_LOOP

        INC ESI                 ; ESI = ESI + 1

        MOV ECX, DISPLAY_OUTER_COUNTER
        SUB ECX, 1 
        MOV ECX, DISPLAY_OUTER_COUNTER

        MOV ECX, DISPLAY_OUTER_COUNTER

    LOOP DISPLAY_OUTER_LOOP
    ;----------------------------------------------


main ENDP 
END main 
