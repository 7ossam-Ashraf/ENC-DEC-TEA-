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
EVEN_CASE:
; Even Length
;-------------------------------------------------------
; Copy The Real Message into the Encrypted Message
;INVOKE Str_copy, ADDR MSG, ADDR MSG_ENC
; Extending the 8-bit characters into 32-bit characters
MOV ECX, MSG_LEN
MOV EBX, 0
MOV EDX, 0
COPY_LOOP:
	MOVZX EAX, MSG[EBX]
	MOV MSG_ENC[EDX], EAX 
	ADD EBX, 1
	ADD EDX, 4
LOOP COPY_LOOP
MOV EAX, MSG_LEN
SHL EAX, 2
MOV MSG_ENC_LEN, EAX		; MSG_ENC_LEN = 4*MSG_LEN
;-------------------------------------------------------
;-------------------------------------------------------

 ; Encrypting the Whole Message
        MOV ESI, OFFSET MSG_ENC     ; ESI is pointing at the beginig of the encrypted message
        MOV EDX, OFFSET MSG_ENC		; EDX = Begining of MSG_ENC
        ADD EDX, MSG_ENC_LEN		; EDX = MSG_ENC + 4*(Length)
        SUB EDX, 8			; EDX = MSG_ENC + 4*(Length - 2)
   MESSAGE_LOOP:
        MOV ECX, 32 
        MOV SUM, 0
   ENCRYPTION_LOOP:
        MOV EBX, DELTA      ; EBX =  0x9e3779b9
        ADD SUM, EBX        ; SUM += 0x9e3779b9

        ; Calculating V[0]
        MOV EAX, [ESI+4]            ; EAX = V[1]
        SHL EAX, 4                  ; EAX = (V[1]<<4)
        ADD EAX, KEY_0              ; EAX = (V[1]<<4 + KEY[0])
        MOV EBX, [ESI+4]            ; EBX = V[1]
        ADD EBX, SUM                ; EBX = V[1] + sum
        XOR EAX, EBX                ; EAX = (V[1]<<4 + KEY[0]) ^ (V[1] + sum)
        MOV EBX, [ESI+4]            ; EBX = V[1]
        SHR EBX, 5                  ; EBX = V[1]>>5
        ADD EBX, KEY_1              ; EBX = V[1]>>5 + KEY[1]
        XOR EAX, EBX                ; EAX = (V[1]<<4 + KEY[0]) ^ (V[1] + sum) ^ (V[1]>>5 + KEY[1])
        ADD [ESI], EAX              ; V[0] += (V[1]<<4 + KEY[0]) ^ (V[1] + sum) ^ V[1]>>5 + KEY[1]
	

        ; Calculating V[1]
        MOV EAX, [ESI]              ; EAX = V[0]
        SHL EAX, 4                  ; EAX = (V[0]<<4)
        ADD EAX, KEY_2              ; EAX = (V[0]<<4 + KEY[2])
        MOV EBX, [ESI]              ; EBX = V[0]
        ADD EBX, SUM                ; EBX = V[0] + sum
        XOR EAX, EBX                ; EAX = (V[0]<<4 + KEY[2]) ^ (V[0] + sum)
        MOV EBX, [ESI]              ; EBX = V[0]
        SHR EBX, 5                  ; EBX = V[0]>>5
        ADD EBX, KEY_3              ; EBX = V[0]>>5 + KEY[3]
        XOR EAX, EBX                ; EAX = (V[0]<<4 + KEY[2]) ^ (V[0] + sum) ^ (V[0]>>5 + KEY[3])
        ADD [ESI+4], EAX            ; V[1] += (V[0]<<4 + KEY[2]) ^ (V[0] + sum) ^ (V[0]>>5 + KEY[3])
    LOOP ENCRYPTION_LOOP

	CMP ESI, EDX			; If ESI is at The End of MSG_ENC Then leave
	JZ OUT_OF_LOOP
    ADD ESI, 8

JMP MESSAGE_LOOP
OUT_OF_LOOP:
        
;-------------------------------------------------------
;-------------------------------------------------------
; Display Output 

CALL DrawLine
MOV  EDX, OFFSET PROMPT2
CALL WriteString
MOV  EDX, OFFSET MSG
CALL WriteString

CALL Crlf 

MOV  EDX, OFFSET PROMPT3
CALL WriteString
MOV  EDX, OFFSET MSG_ENC
CALL WriteString

CALL Crlf 

CALL DrawLine

;-------------------------------------------------------
exit 
main ENDP 
;-------------------------------------------------------------------
DrawLine PROC 
    MOV  EDX, OFFSET LINE_1
    CALL WriteString 
    CALL Crlf                   ; Writes a carriage return/linefeed 
                                ;sequence (0Dh,0Ah) to standard output.
    RET 
DrawLine ENDP 
;-------------------------------------------------------------------

END main 
