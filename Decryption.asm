TITLE TDA(Tiny Decryption Algorithm)    (Decryption.asm)

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
    MOV EDX, 0C6EF3720H
    MOV ECX, 32
    LOOP_I:
         ; In use EAX , EDX , ECX , EBX
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
        SUB V_1, EAX        ; V[1] -= (V[0]<<4 + KEY[2]) ^ (V[0] + sum) ^ (V[0]>>5 + KEY[3])

    LOOP LOOP_I

main ENDP 
END main 
