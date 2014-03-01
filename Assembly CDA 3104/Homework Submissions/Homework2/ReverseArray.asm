title  Reverse Array
; Thomas Turney
; Dr. Guo
; Assignment 2
; 10/2/2013
INCLUDE Irvine32.inc

.data ;Contains all variables for program
ARRAY_SIZE = 13
RAND_MAX = 100
HALF_ARRAY_SIZE = ARRAY_SIZE / 2
rands DWORD ARRAY_SIZE dup(0)


.code ;Contains all code from program
main PROC


	call randomize
	mov ecx, ARRAY_SIZE
	mov esi, 0

genran: ;generate random numbers
	mov eax, RAND_MAX ; random numbers in between this array
	call RandomRange
	mov rands[esi], eax ;assign random number to array
	add esi, type rands
	loop genran

	mov ecx, ARRAY_SIZE
	mov esi, 0
printarr: ;printing the array
	mov eax, rands[esi]
	call writeint

	mov al, ' '
	call writechar  ;add spacing

	add esi, type rands
	loop printarr

	call crlf ;newline

	;declare two pointers
	mov esi, 0
	mov ebp, sizeof rands-4

	mov edx, 0 ; will hold temporary variable
	mov ecx, ARRAY_SIZE

revarr: ;reverse the array
	mov edx, rands[esi]
	mov eax, rands[ebp]
	mov rands[esi], eax
	mov rands[ebp], edx
	
	mov edx, esi ;test condition for ending the array
	sub edx, HALF_ARRAY_SIZE*4
	jz printend
	add esi, type rands
	sub ebp, type rands
	loop revarr

printend:
	mov ecx, ARRAY_SIZE
	mov esi, 0
printall:
	mov eax, rands[esi]
	call writeint

	mov al, ' '
	call writechar  ;add spacing

	add esi, type rands
	loop printall

	exit
main ENDP
END main