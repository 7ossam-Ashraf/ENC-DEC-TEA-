TITLE TDA(Tiny Decryption Algorithm)    (Decryption.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data?
;-------------------------------------------------------
; String length data
MSG_LEN DWORD ?
MSG_ENC_LEN DWORD ?


.data 
;-------------------------------------------------------
; Line
LINE_1 BYTE "--------------------------------------",0
;-------------------------------------------------------

;-------------------------------------------------------
; User Prompt To Enter The String
PROMPT1 BYTE "Enter Encrypted String: ",0

.code 
main PROC 

CALL DrawLine               ; Draw Line  
;-------------------------------------------------------
; Prompt User to Enter the Encrypted String
MOV  EDX, OFFSET PROMPT1
CALL WriteString
;-------------------------------------------------------
;-------------------------------------------------------
; Enter The Encrypted Message
MOV  EDX, OFFSET MSG_ENC
MOV  ECX, MAX               ;buffer size - 1
CALL ReadString
;-------------------------------------------------------
CALL DrawLine               ; Draw Line 
;-------------------------------------------------------
; Finding The Length of Encrypted Message
MOV  EDX, OFFSET MSG_ENC
CALL StrLength
MOV  MSG_ENC_LEN, EAX
main ENDP
DrawLine PROC 
    MOV  EDX, OFFSET LINE_1
    CALL WriteString 
    CALL Crlf                   ; Writes a carriage return/linefeed 
                                ;sequence (0Dh,0Ah) to standard output.
    RET 
DrawLine ENDP 
END main 
