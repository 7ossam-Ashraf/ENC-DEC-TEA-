TITLE TEA(Tiny Encryption Algorithm)   (Encryption.asm)

INCLUDE C:\Irvine\Irvine32.inc
.data?
    MSG DWORD 99 DUP(?)         ; Empty memory for Input Message
    LEN BYTE DUP(?)             ; Input Length
    OUTER_COUNTER DWORD DUP(?)  ; Inner loop counter
    DISPLAY_OUTER_COUNTER DWORD DUP(?)
    
.data 
    KEY_0 DWORD 1   ; Key
    KEY_1 DWORD 3
    KEY_2 DWORD 50
    KEY_3 DWORD 100
    
    DELTA DWORD 9e3779b9H
    SUM DWORD 0
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
    
    ; Begining of the loop
    MOV EDX, 0 
    MOV ECX, 32
    LOOP_I:
        ; In use EAX , EDX , ECX , EBX
        ADD EDX, 9e3779b9H  ; EDX += 0x9e3779b9
        ; Calculating V[0]
        MOV EAX, V_1        ; EAX = V[1]
        SHL EAX, 4          ; EAX = (V[1]<<4)
        ADD EAX, KEY_0      ; EAX = (V[1]<<4 + KEY[0])
        MOV EBX, V_1        ; EBX = V[1]
        ADD EBX, EDX        ; EBX = V[1] + sum
        XOR EAX, EBX        ; EAX = (V[1]<<4 + KEY[0]) ^ (V[1] + sum)
        MOV EBX, V_1        ; EBX = V[1]
        SHR EBX, 5          ; EBX = V[1]>>5
        ADD EBX, KEY_1      ; EBX = V[1]>>5 + KEY[1]
        XOR EAX, EBX        ; EAX = (V[1]<<4 + KEY[0]) ^ (V[1] + sum) ^ (V[1]>>5 + KEY[1])
        ADD V_0, EAX        ; V[0] += (V[1]<<4 + KEY[0]) ^ (V[1] + sum) ^ V[1]>>5 + KEY[1]
        ; Calculating V[1]
        MOV EAX, V_0        ; EAX = V[0]
        SHL EAX, 4          ; EAX = (V[0]<<4)
        ADD EAX, KEY_2      ; EAX = (V[0]<<4 + KEY[2])
        MOV EBX, V_0        ; EBX = V[0]
        ADD EBX, EDX        ; EBX = V[0] + sum
        XOR EAX, EBX        ; EAX = (V[0]<<4 + KEY[2]) ^ (V[0] + sum)
        MOV EBX, V_0        ; EBX = V[0]
        SHR EBX, 5          ; EBX = V[0]>>5
        ADD EBX, KEY_3      ; EBX = V[0]>>5 + KEY[3]
        XOR EAX, EBX        ; EAX = (V[0]<<4 + KEY[2]) ^ (V[0] + sum) ^ (V[0]>>5 + KEY[3])
        ADD V_1, EAX        ; V[1] += (V[0]<<4 + KEY[2]) ^ (V[0] + sum) ^ (V[0]>>5 + KEY[3])
    LOOP LOOP_I


main ENDP 
END main 
