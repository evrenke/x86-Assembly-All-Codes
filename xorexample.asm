; take a string of integer chars
; and make an array of actual integers from it

include Irvine32.inc

.data
myStr BYTE "12345", 0
; array is 31, 32, 33, 34, 35
len = lengthof myStr - 1
intStr byte len dup (?)
.code
main proc
	mov ecx, len
	;ZERO EBX
	
	;mov ebx, 0  ; slower than the other ones
	;sub ebx, ebx; pretty good too
	xor ebx, ebx ; this one is the most efficient way to zero
	
	
	L1: ; and the numbers with 0F to keep lower byte the same

	mov al, myStr[ebx]
	and al, 0Fh
	mov intStr[ebx], al
	inc ebx
	loop L1

	exit
main endp
end main
