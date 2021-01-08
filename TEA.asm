TITLE TEA(Tiny Encryption Algorithm)   (Encryption.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data 
    KEY_0 DWORD 1   ; Key
    KEY_1 DWORD 3
    KEY_2 DWORD 50
    KEY_3 DWORD 100

    V_0 DWORD 150     ; Message
    V_1 DWORD 336


.code 
main PROC 
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
