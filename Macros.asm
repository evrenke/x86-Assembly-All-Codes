include Irvine32.inc

newLine Macro
	call crlf
endm

displayChar Macro paramChar
	push eax   ; you push and pop eax to preserve its previous value, so it remains unchanged
	mov al, paramChar
	call writeChar
	pop eax
endm

sumTwoNum Macro int1, int2, sum ;parameters act as immediate numbers
	push ebx
	mov ebx, int1
	add ebx, int2
	mov sum, ebx
	pop ebx
endm

displayDecimal Macro paramInt
	push eax
	mov eax, paramInt
	call writeDec
	pop eax
endm

loopExample Macro
local L1
	push eax
	push ecx
	mov al, 'a'
	mov ecx, 5
	L1:
	call writeChar
	inc al
	displayChar ' '
	loop L1
	pop ecx
	pop eax
endm

.data
result dword ?

.code
main proc

	newLine

	displayChar ' '
	displayChar 'b'
	mov ebx, 2
	mov eax, 3
	sumTwonum eax, ebx, result
	loopExample
	loopExample

	exit
main endp
end main