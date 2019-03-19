;;;;;;;;;;;;;;;;;;
; Stack,  to reverse a string
;;;;;;;;;;;;;;;;;;
include irvine32.inc
.data
str1 byte "This is a string.", 0
LEN = lengthof str1 - 1
str2 byte LEN dup (?), 0

.code
main proc

	mov ecx, LEN
	mov esi, offset str1
	mov edi, offset str2
	mov ebx, type str1
	call proc1
exit
main endp

; esi address of str1
; edi address of str2
; ecx length of str1
; ebx type of str1, bytes

proc1 proc
mov edx, ecx
l1:
	movzx eax, byte ptr [esi]
	push eax
	add esi, ebx
loop l1
	mov ecx, edx
l2:
	pop eax
	mov [edi], al
	add edi, ebx
loop l2
	mov edx, offset str2
	call writeString
	call crlf
ret
proc1 endp


end main