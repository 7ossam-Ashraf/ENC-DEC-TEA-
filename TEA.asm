TITLE TEA(Tiny Encryption Algorithm)   (Encryption.asm)

.data?
;-------------------------------------------------------
; String length data
MSG_LEN DWORD ?
MSG_ENC_LEN DWORD ?
;-------------------------------------------------------
.data 
;-------------------------------------------------------
; Line
LINE_1 BYTE "--------------------------------------",0
;-------------------------------------------------------

;-------------------------------------------------------
; User Prompt To Enter The String
PROMPT1 BYTE "Enter a String: ",0
PROMPT2 BYTE "Message = ",0
PROMPT3 BYTE "ENC_Message = ",0
;-------------------------------------------------------
;-------------------------------------------------------
; Input Message Data
MAX = 80                          ;max chars to read
MSG BYTE MAX+1 DUP (?)            ;room for null
MSG_ENC DWORD MAX+1 DUP(?)        
;-------------------------------------------------------
DELTA DWORD 9e3779b9H
SUM DWORD 0

KEY_0 DWORD 1   ; Key
KEY_1 DWORD 3
KEY_2 DWORD 50
KEY_3 DWORD 100


.code 
main PROC 

CALL DrawLine               ; Draw Line  
;-------------------------------------------------------
; Prompt User to Enter the Length of String
MOV  EDX, OFFSET PROMPT1
CALL WriteString
;-------------------------------------------------------
;-------------------------------------------------------
; Enter The Message
MOV  EDX, OFFSET MSG
MOV  ECX, MAX               ;buffer size - 1
CALL ReadString
;-------------------------------------------------------
CALL DrawLine               ; Draw Line 
;-------------------------------------------------------
; Finding The Length of Message
MOV  EDX, OFFSET MSG
CALL StrLength
MOV  MSG_LEN, EAX
;-------------------------------------------------------
TEST MSG_LEN, 1
JZ EVEN_CASE
; Odd Length
MOV EAX, OFFSET MSG         ; ESI = Message Offset 
MOV EBX, MSG_LEN
MOV EDX, '!'
MOV [EAX+EBX], EDX				; Extend The Message With a '0' Character to Become of Even Length
MOV EDX, 0
MOV [EAX+EBX+1], EDX      ; Ending The Message with a NULL Character
ADD MSG_LEN, 1				; MSG_LEN += 1

    ; Encrypting the Whole Message
    ;----------------------------------------------
    MOVZX ECX, LEN          ; ECX = length of input string
    MOV OUTER_COUNTER, ECX  ; OUTER_COUNTER = Length of string

    MOV EDX, 0
    MOV ECX, OUTER_COUNTER  ; ECX = OUTER_COUNTER
    LOOP_ENCRYPT_MESSAGE:
    ; Inner Loop
    ; Begining of the loop
        MOV SUM, 0              ; SUM = 0
        MOV ECX, INNER_COUNTER  ; ECX = INNER_COUNTER
        LOOP_I:
            ; In use EAX(Temp) , ECX(Temp) , EBX(Temp)
            MOV EBX, DELTA      ; EBX =  0x9e3779b9
            ADD SUM, EBX        ; SUM += 0x9e3779b9

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
