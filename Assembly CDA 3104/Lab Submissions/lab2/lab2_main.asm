; Thomas Turney
; Dr. Guo
; 9/12/2013
; Lab 2
TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
msg1 byte 'Please input the first number: ',0
msg2 byte 'Please input the second number: ',0
msg3 byte 'Please input the third number: ',0
val1 byte 3 DUP(0)
val2 byte 3 DUP(0)
val3 byte 3 DUP(0)
totalmsg byte 'The result is: ',0

.code
main PROC
	call Clrscr

	mov	edx, offset msg1
	call WriteString
	mov edx, offset val1
	call ReadInt
	mov ecx, eax
	
	mov	edx, offset msg2
	call WriteString
	mov edx, offset val2
	call ReadInt
	add ecx, eax

	mov	edx, offset msg3
	call WriteString
	mov edx, offset val3
	call ReadInt
	sub ecx, eax

	;output
	mov edx, offset totalmsg
	call WriteString
	mov eax, ecx
	call WriteInt

	exit
main ENDP
END main