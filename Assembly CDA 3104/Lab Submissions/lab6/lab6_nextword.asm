TITLE Lab 6 Part I: String Nextword
;Thomas Turney
;12/2/2013
;Dr. Guo
;Assembly Language

INCLUDE Irvine32.inc

.data
msg byte "  fort  myers fgcu cda   3104  holmes hall    402",0

.code

Str_nextword PROTO,
  string: PTR BYTE,
  delimiter: BYTE

Str_nextword PROC uses eax ecx edi,
  string: PTR BYTE, delimiter: BYTE ;our methods

  invoke str_length, string 

  mov ecx, eax ; store length of string
  mov edi, string ; address of string

  mov al, delimiter ; load delimeter to check for scasb

  repz scasb ;check and look for zero flags

  jz Done ;no nextwords

  mov edx, edi 
  dec edx        ;resetting edx for another value to check
  repnz scasb

  jnz Done ;no more values

  mov [edi-1], byte ptr 0 ;sets string with trailing 0 byte
  cmp edi, 0 ;can set zero flag


Done:
  ret
Str_nextword endp


main PROC
  
  mov edx, offset msg

tokenize:
  invoke Str_nextword, edx, ' '
  jz quit
  call writestring
  call crlf
  invoke str_length, edx ; in eax
  inc eax ; for null string
  add edx, eax ;start next tokenizer
  jmp tokenize

quit:
  call waitMsg
  exit

main ENDP

END main
