title  Fibannoci Array
; Thomas Turney
; Dr. Guo
; Assignment 2
; 10/2/2013
INCLUDE Irvine32.inc

.data ;Contains all variables for program
array dword 12 DUP(0)
step=type array
first byte "The first twelve fibonnaci numbers are ",0

.code ;Contains all code from program
main PROC
	mov ecx, lengthof array-2
	mov esi, offset array
	add esi, step
	mov eax, 1
	mov [esi], eax ; assigns 1 to the fib array
	add esi, step
	mov ebx, esi ; will be the n operator
L1: ;populating the array
	mov eax, [esi] ; n
	sub ebx, step
	add eax, [ebx] ; n-1
	sub ebx, step
	add eax, [ebx] ; n-2
	mov [esi], eax ; n assigned

	add esi, step
	mov ebx, esi ; assign the n operator again
	loop L1

	;display elements
	mov edx, offset first
	call writeString

	mov ecx, lengthof array
	mov esi, offset array
	
L2:
	mov eax, [esi]
	call writeint   ;display character

	mov al, ' '
	call writechar  ;add spacing

	add esi, step ; increment the array
	loop L2

	exit
main ENDP
END main