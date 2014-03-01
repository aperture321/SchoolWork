TITLE printproc
; Thomas Turney
; Dr. Guo
; Lab 4
; 10/15/2013
INCLUDE Irvine32.inc

.data
symbol = 'x'
delay_time = 10

iterative byte "ITERATIVE",0
recursive byte "RECURSIVE",0

.code

main PROC
	; displays "ITERATIVE"
	mov dh, 3
	mov dl, 12
	call gotoxy
	mov edx, offset iterative
	call writestring

	; prints the square using iteration
	mov bl, 10		; top-left x
	mov bh, 6		; top-left y
	mov al, 25		; bottom-right x
	mov ah, 21		; bottom-right y
	call spiral_print

	; displays "RECURSIVE"
	mov dh, 3
	mov dl, 32
	call gotoxy
	mov edx, offset recursive
	call writestring

	; prints the square using recursion
	mov bl, 30		; top-left x
	mov bh, 6		; top-left y
	mov al, 45		; bottom-right x
	mov ah, 21		; bottom-right y
	call spiral_print_recurs

	; moves the cursor for "Press any key to continue"
	mov dh, 22
	mov dl, 10
	call gotoxy
	exit
main ENDP


; Receives BL (top-left x), BH (top-left y)
;	   AL (bottom-right x), AH (bottom-right y)
; Precondition: (BL-AL)==(AH-BH), (BL-AL+1) is even
; Returns: nothing
; Description: Prints a square of constant symbol. The top-left corner of 
;		the square is (BL, BH). The bottom-right corner of the square
;		is (AL, AH). The program pauses for constant delay_time milliseconds.
;		Algorithm: recursion
spiral_print_recurs proc USES EAX EBX EDX ECX ESI
	cmp bl, al
	ja end_proc ; jumps to the end when bl is greater than al
	
	mov cl, al
	sub cl, bl
	movzx esi, cl	;edge length, upper three bytes is zero
	add cl, 1
	shr cl, 1	; divides cl by 2 ; number of rings

	;they require dh and dl!
	;coordinate corners!!
	mov dx, bx
	call horizontal_print
	mov dl, al
	mov dh, bh
	call vertical_print
	mov dx, ax
	call horizontal_print_rev
	mov dl, bl
	mov dh, ah
	call vertical_print_rev
	
	;move on to inner ring, update coordinates
	inc bl
	inc bh
	dec al
	dec ah
	sub esi, 2

	call spiral_print_recurs
	; implement the rest of the procedure

end_proc:
	ret
spiral_print_recurs endp

; Receives BL (top-left x), BH (top-left y)
;	   AL (bottom-right x), AH (bottom-right y)
; Precondition: (BL-AL)==(AH-BH), (BL-AL+1) is even
; Returns: nothing
; Description: Prints a square of constant symbol. The top-left corner of 
;		the square is (BL, BH). The bottom-right corner of the square
;		is (AL, AH). The program pauses for constant delay_time milliseconds.
;		Algorithm: iteration
spiral_print proc USES EAX EBX EDX ECX ESI
	mov cl, al
	sub cl, bl
	movzx esi, cl	;edge length, upper three bytes is zero
	add cl, 1
	shr cl, 1	; divides cl by 2 ; number of rings

	;ecx is counter for loop, and is defined...
L1:
	;they require dh and dl!
	;coordinate corners!!
	mov dx, bx
	call horizontal_print
	mov dl, al
	mov dh, bh
	call vertical_print
	mov dx, ax
	call horizontal_print_rev
	mov dl, bl
	mov dh, ah
	call vertical_print_rev
	
	;move on to inner ring, update coordinates
	inc bl
	inc bh
	dec al
	dec ah
	sub esi, 2

	loop L1

	ret
spiral_print endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)
;              each print increments DH		
vertical_print proc USES EDX ECX EAX ESI
	
	; implement this procedure
	;advance curosr to the next row
	;
L1:
	call Gotoxy	
	mov al, offset symbol
	call writeChar
	inc dh
	call Gotoxy
	call writeChar
	inc dh
	mov eax, 10
	call Delay
	loop L1
	
	ret
vertical_print endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)			
;              each print increments DL
horizontal_print proc USES EDX ECX EAX ESI
	

L1:
	call Gotoxy	
	mov al, offset symbol
	call writeChar
	inc dl
	call writeChar
	inc dl
	mov eax, 10
	call Delay
	loop L1

	ret
horizontal_print endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)
;              each print decrements DH		
vertical_print_rev proc USES EDX ECX EAX ESI
	
L1:
	call Gotoxy	
	mov al, offset symbol
	call writeChar
	dec dh
	call Gotoxy
	call writeChar
	dec dh
	mov eax, 10
	call Delay
	loop L1
	
	ret
vertical_print_rev endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)			
;              each print decrements DL
horizontal_print_rev proc USES EDX ECX EAX ESI
	
L1:
	call Gotoxy	
	mov al, offset symbol
	call writeChar
	dec dl
	call Gotoxy
	call writeChar
	dec dl
	mov eax, 10
	call Delay
	loop L1
	
	ret
horizontal_print_rev endp
END main