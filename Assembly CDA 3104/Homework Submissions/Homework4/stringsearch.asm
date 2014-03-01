TITLE string search
;Thomas Turney
;11/22/2013
;Dr. Guo
;Assembly Language

INCLUDE Irvine32.inc

.data
stringMap byte 32 dup(0)
testString byte "hello, assembly language programming!",0

msg1 byte " is not in the string.",0
msg2 byte " is in the string.",0

.code

PrepareMap PROTO,
  string: PTR BYTE,
  map: PTR BYTE

PrepareMap PROC uses eax ebx ecx esi edi,
  string: PTR BYTE, map: PTR BYTE ;our methods

  mov esi, string ; load string to register
  mov edi, map ; load map to register
  invoke str_length, esi ; result in eax
  mov ecx, eax
L1: ;for every character in string... map[rownum] |= 1<<columnum
  mov eax, 0 ; will hold rownum
  mov ebx, 0 ; will hold 1<<columnum

  mov al, [esi]
  shr al, 3 ; rownum
  push eax ; save rownum

  mov al, [esi] ; reload character in
  and al, 111b ; columnum = char & 7
  mov bl, 1b ; get the 1 for shifting
  push ecx ; preserver loop count
  mov cl, al ; put columnum in cl
  shl bl, cl ; 1 << columnum in ebx ONLY cl can be in shl operand
  pop ecx ; loop count back in.
  pop eax ;rownum back in!

  mov bh, [edi+eax] ; adds map with rownum offset to bh
  or bh, bl ; '1' for index in map
  mov [edi+eax], bh ; will give location to store '1' for the map

  inc esi ; next element in the string
  loop L1
  ret
PrepareMap endp

CharacterSearch PROTO,
  map: PTR BYTE,
  char: BYTE

CharacterSearch PROC uses eax ebx ecx esi,
  map: PTR BYTE, char: BYTE

  mov esi, map ; first, load map to register
  
  mov bx, 0 ;using this for map piece, like in PrepareMap

  movzx eax, char ;add in character
  shr eax, 3; gives rownum

  mov bh, [esi+eax] ;rownum of map in bh

  movzx eax, char ;reseting the char for columnum
  and al, 111b ;column & 7
  mov bl, 1b
  mov cl, al ;cl has to be used for the shl operation
  shl bl, cl ; 1 << columnum ONLY cl can be in the shl operand


  and bh, bl ;gives key for the map
  
  cmp bh, 0 ; sets zflag if key found/not found
  ret
CharacterSearch endp

main PROC
  call Randomize
  mov ecx, 10 ;loop counter for characters
L1:
  mov eax, 0FFh ;All types of characters
  call RandomRange ;random variable is now in eax
  call writeChar
  mov edx, offset msg2 ;assume found...
  invoke PrepareMap, addr testString, addr stringMap
  invoke CharacterSearch, addr stringMap, al ;or testcase?
  jnz okay
  mov edx, offset msg1 ;assume not found
okay:
  call writeString
  call crlf
  
  loop L1

  ;program end
  call crlf
  call waitMsg
  exit
main ENDP

END main
