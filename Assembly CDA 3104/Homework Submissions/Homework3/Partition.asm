TITLE Partition
; Thomas Turney
; Dr. Guo
; Homework 3
; 10/28/2013
INCLUDE Irvine32.inc

.data
array BYTE 1, 2, 5, 7, 13, 19, 20, 21, 33, 45, 101

.code
main1 PROC
	mov al, 3 ;test procedure to partition by
	call partition
	mov eax, ebp ;moving results for call writeint
	call writeInt
	call crlf
	call waitMsg ;any message to continue
	exit
main ENDP

; Receives: AL: partition pivot
;
; Returns: EBP: array elements with an index, greater than EBP, are
; greater than the pivot (AL).
; EBP = -1 when all array elements are greater than the pivot
;
; Description: Partitions a byte array into two portions: left and right.
; Elements in the left portion are less than or equal to
; the pivot (AL). The ones in the right are greater than.
;
;Note: only works for byte arrays
partition PROC uses ebx edx
	mov ebx, 0		;initialize with lowest element
	mov edx, LENGTHOF array
	dec edx		;initialize last element

	;test for seeing if at the end of the partition
startcmp:
	cmp ebx, edx ;see if  lowest and highest elements
	jae arrend ;final solution

	;low inc counter, calling high counters
lowinc:
	cmp ebx, edx  
	ja  highdec
	cmp array[ebx], al ;compare with partition element
	ja  highdec
	inc ebx    ;keep incrementing throughout lowest element
	jmp lowinc

	;high dec counter
	; will also be exchanging values
highdec:
	cmp ebx, edx
	ja  exchange
	cmp array[edx], al
	jbe exchange
	dec edx
	jmp highdec

	;exchange values
exchange:
	cmp ebx, edx
	jge arrend
	mov cl, array[ebx]
	mov ch, array[edx]
	mov array[ebx], ch
	mov array[edx], cl
	jmp startcmp

	;end of array
arrend:
	mov ebp, edx
	ret
partition ENDP

END main