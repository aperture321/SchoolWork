title  Hello World Program (hello32irvine.asm)
; This program displays "Hello, world!"
INCLUDE Irvine32.inc

.data ;Contains all variables for program
msg byte 'Hello World!',0Ah,0Dh,0

.code ;Contains all code from program
main PROC
	;outputing msg
	mov edx, offset msg
	call WriteString
	
	;exiting the programming
	exit
main ENDP
END main