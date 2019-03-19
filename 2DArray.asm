include irvine32.inc
; ===============================================
.data

arr word 5, 3, 2, 1, 4
	word 9, 2, 5, 7, 6
	word 1, 7, 3, 5, 8
	word 2, 3, 8, 4, 1
	word 4, 4, 3, 8, 4

;=================================================
.code
main proc
	sub esp,4 
	push 5
	push offset arr
	call sumDiag
	pop eax
	call writeInt

   exit
main endp

sumDiag proc
	push ebp
	mov ebp, esp
	push edx
	push ecx
	push ebx
	push eax
	push edi

	mov ebx, [ebp + 8] ; array offset
	xor edi, edi ; 0 is the first row
	mov ecx, [ebp + 12] ; array length 5
	xor edx, edx ; the sum
	mov eax, 2
	mul dword ptr [ebp + 12] ; eax now has a row length
	
	; while (edi < ecx)
	; {
	;	 dx += [ebx + edi];
	;	 edi += WORD ; adds a column
	;	 ebx += eax ; adds a row
	; }

	loopDiagonal:
		add dx, [ebx + edi]
		add edi, 2
		add ebx, eax
	loop loopDiagonal

	mov [ebp + 16], edx

	pop edi
	pop eax
	pop ebx
	pop ecx
	pop edx
	pop ebp
	ret 8
sumDiag endp

end main