TITLE Example of Procedures
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
	ja end_proc ; jumps to the end when bl is greater than bl

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
	movzx esi, cl	
	add cl, 1
	shr cl, 1	; divides cl by 2

	; implement the rest of the procedure

	ret
spiral_print endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)
;              each print increments DH		
vertical_print proc USES EDX ECX EAX ESI
	
	; implement this procedure
	
vertical_print endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)			
;              each print increments DL
horizontal_print proc USES EDX ECX EAX ESI
	
	; implement this procedure
	
horizontal_print endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)
;              each print decrements DH		
vertical_print_rev proc USES EDX ECX EAX ESI
	
	; implement this procedure
	
vertical_print_rev endp

; Receives: DH (row), DL (col), ESI (# of prints)
; Returns: nothing
; Description: prints symbol for ESI times from (DL, DH)			
;              each print decrements DL
horizontal_print_rev proc USES EDX ECX EAX ESI
	
	; implement this procedure
	
horizontal_print_rev endp
END main
