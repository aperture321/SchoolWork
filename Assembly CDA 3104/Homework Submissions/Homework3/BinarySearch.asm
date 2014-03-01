TITLE BinarySearch
; Thomas Turney
; Dr. Guo
; Homework 3
; 10/28/2013
INCLUDE Irvine32.inc

.data
array BYTE 1, 5, 6, 16, 27, 104, 115

.code
main PROC
	mov esi, OFFSET array
	mov ecx, LENGTHOF array
	mov al, 104 ;whatever value would like to be searched
	call binarySearch
	mov eax, ebp
	call writeInt ;give to output
	call crlf
	call waitMsg ;wait for key
	exit
main ENDP


; Receives: ECX: len of array, AL: search key
; Returns: EBP: index of search key in array (-1 when search fails)
; Assumes: array is sorted
binarySearch PROC uses ebx edx
	mov ebx, 0  ;first array element
	mov edx, ecx
	dec edx  ;will reference last array element
lowval:
	mov ebp, ebx ;lowest array value is
	add ebp, edx ;add with highest value
	shr ebp, 1   ;then averaged for mid value
	
	cmp al, array[ebp] ;see if key is equal to middle element
	je found   ;see if equal
	jb highval     ;if below that array

	mov ebx, ebp ;reassign first element to mid
	add ebx, 1
	cmp ebx, edx
	jbe lowval

highval:
	mov edx, ebp ;reassign last element to mid
	sub edx, 1
	cmp ebx, edx
	jbe lowval

	mov ebp, -1 ;array element was not found
found:
	ret ;give values out in ebp

binarySearch ENDP

END main