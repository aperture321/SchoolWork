TITLE Lab 5 - bit manipulation
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

; Receives: BL
; Returns: EAX: number of one's in BL
; Example: BL = 10010111b, EAX = 5
CountOnes PROC USES EBX
	
	; implements this procedure

CountOnes ENDP

END main
