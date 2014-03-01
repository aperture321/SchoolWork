TITLE Lab 5 - bit manipulation
;Thomas Turney
;11/5/2013
;Dr. Guo
;Assembly Language

INCLUDE Irvine32.inc

.data
len=10
vector1 byte 1,  2, 3, 4, 5, 6, 7, 8, 9,10 
vector2 byte 20,19,18,17,16,15,14,13,12,11

part1 byte "***** Part 1: CountDistance *****",0
part2 byte "***** Part 2: SwapOddEvenBits ***",0

diff byte " bits are different between vector1 and vector2",0
.code
main PROC
	; Testing CountDistance
	mov edx, offset part1
	call writestring
	call crlf
	call crlf

	mov esi, offset vector1
	mov edi, offset vector2
	mov ecx, len
	call CountDistance
	call writeint
	mov edx, offset diff
	call writestring
	call crlf
	call crlf

	; Testing SwapOddEvenBits
	mov edx, offset part2
	call writestring
	call crlf
	call crlf

	call randomize
	call random32
	call writebin
	call crlf
	call swapoddevenbits
	call writebin
	call crlf
	call crlf
	exit
main ENDP

; Receives: EAX
; Returns: EAX where every two bits are exchanged
; Example1: Received EAX = 0010 0110 1000 0000 1001 0111 1010 0101
;			Return:  EAX = 0001 1001 0100 0000 0110 1011 0101 1010
SwapOddEvenBits PROC USES  EBX ECX EDX EBP
	
	; implements this procedure
	mov ebx, 3 ; mask
	mov ecx, 0 ; i=0
	mov edx, eax ;number to test
	mov eax, 0 ; result number
WLT: ;while loop test
	shl ebx, cl ; mask = mask << i
	and ebx, edx
	shr ebx, cl ; mask = mask >> i
	cmp ebx, 2 ;compare to 2
	jg noswitch ;ebx = 3
	cmp ebx, 1 ;compare to 1
	jl noswitch  ;ebx = 0
	;assume a switch will be made
	xor ebx, 3 ;??
noswitch:
	shl ebx, cl ; mask = mask << i
	add eax, ebx
	mov ebx, 3
	add ecx, 2 ; i += 2
	cmp ecx, 32
	je endmask
	jmp WLT
endmask:
	ret ;will return result to eax
SwapOddEvenBits ENDP

; Receives: ESI: offset of byte vector1, 
;			EDI: offset of byte vector2, 
;			ECX: length of vector1 and vector2
; Returns: EAX: how bits in vector1 need to flipped to transform to vector2
CountDistance PROC USES ebx ecx
	mov edx, 0
L1:
	mov al, [esi]
	mov bl, [edi]
	xor bl, al
	call countones
	add edx, eax
   	inc esi
	inc edi
	loop L1
	mov eax, edx
	ret
CountDistance ENDP

; Receives: BL ECX
; Returns: EAX: number of one's in BL
; Example: BL = 10010111b, EAX = 5
CountOnes PROC USES EBX ECX
	mov eax, 0 ;set counter = 0
	cmp bl, 0 ;first check
	je Endl

WL1: ;while loop 1
	inc eax
	mov ecx, ebx
	dec ecx ;b-1
	and ebx, ecx ;b & b-1 
	cmp bl, 0
	je Endl
	jmp WL1
Endl:
	ret
CountOnes ENDP

END main
