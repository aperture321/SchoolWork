title  Fibannoci Array Recursive
; Thomas Turney
; Dr. Guo
; Assignment 2
; 10/2/2013
INCLUDE Irvine32.inc

.data ;Contains all variables for program

.code ;Contains all code from program
main PROC
	mov edx, 0
Looper:
	push edx
	call fibonacci
	pop eax ; eax gets the result
	call writeint   ;display character

	mov al, ' '
	call writechar  ;add spacing

	sub edx, 12 ;see if end of loop
	jz endpro
	add edx, 12 ;reset to correct amount
	inc edx ;add 1 for next loop
	loop Looper
endpro:
	exit

main ENDP
fibonacci proc uses esi eax ebx ecx

	mov esi, esp
	add esi, 20
	mov eax, [esi] ;This gets the push parameter before the fib call.
	cmp eax, 2 ;see if 1 or 0.
	jl L1

	mov bx, 0h
	mov [esi], bx ; fib placeholder

	;time to make this recursive..
	;guo mentioned this...
	dec eax ;n-1
	push eax
	call fibonacci
	pop ebx ;should be your result...
	mov [esi], ebx ;store n-1

	dec eax ;n-2
	push eax
	call fibonacci
	pop ebx
	add [esi], ebx ;n-1 + n-2
L1: 
	ret ; return value to stack
fibonacci endp
END main