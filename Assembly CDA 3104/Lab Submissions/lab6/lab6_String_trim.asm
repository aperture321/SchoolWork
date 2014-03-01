TITLE Lab 6 Part I: string trim
;Thomas Turney
;12/2/2013
;Dr. Guo
;Assembly Language

INCLUDE Irvine32.inc

.data
string1 byte "abcd efgh ijk&&&&&", 0
string2 byte "abcd efgh &&&ijk", 0
string3 byte "&&&&&", 0
trail = '&'

.code

string_trim PROTO,
  pstring: PTR BYTE,
  char: BYTE

string_trim PROC uses eax ebx ecx edi,
  pstring: PTR BYTE, char: BYTE ;our methods

  invoke str_length, pstring

  mov ecx, eax ; store length of pstring
  mov ebx, eax ; backup storage, to be checked later.

  mov edi, [pstring]
  add edi, eax ; add the length
  sub edi, 2 ; subtract 1 for length, and 1 for 0 character

  mov al, char ; search for char symbol

  std ; set direction flag backword
  repe scasb ; search for the string
  ;note that sometimes this fails..

  inc ecx
  cmp ecx, ebx ; compare to see if they were equal
  je Done

  add edi, 2 ; reset the edi
  mov al, 0
  mov [edi], al

Done:
  ret
string_trim endp


main PROC
  invoke string_trim, ADDR string1, trail
  mov edx, offset string1
  call WriteString
  call crlf
   
  invoke string_trim, ADDR string2, trail
  mov edx, offset string2
  call WriteString
  call crlf

  invoke string_trim, ADDR string3, trail
  mov edx, offset string3
  call WriteString
  call crlf


  call waitMsg
  exit
main ENDP

END main
