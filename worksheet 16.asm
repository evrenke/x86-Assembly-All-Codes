INCLUDE Irvine32.inc
numrow = 3
numcol = 5
.data
arr WORD 1,2,3,3,4,4,5,6,2,2,2,7,5,5,5
uniq WORD 15 dup(0)
twoD WORD 0,1,2,3,4
	WORD 10,11,12,13,14     
	WORD 20,21,22,23,24;or      
	;twoD WORD 0,1,2,3,4,10,11,12,13,14,20,21,22,23,24
.code
main PROC
;Q1: copy arr into uniq
	lea esi, arr
	lea edi, uniq
	cld
	mov ecx, 15
	rep movsw

;Q2 print uniq to check
mov ecx, lengthof uniq
lea esi, uniq
cld
xor eax, eax
print:
	lodsw
	call writeInt
	loop print

call crlf
; Q3: zero out uniq
mov ecx, lengthof uniq
lea edi, uniq
cld
xor eax, eax
rep stosw

; Q4: print uniq to check
mov ecx, lengthof uniq
lea esi, uniq
cld
xor eax, eax
L1:
	lodsw
	call writeInt
	loop L1

call crlf
; Q5: copy arr into uniq, but don't copy consecutive 
; duplicate numbers
	lea esi, arr
	lea edi, uniq
	cld
	movsw
	mov ecx, lengthof arr - 1

	loopCopy:
	lodsw
	cmp ax, [edi - type uniq]
	je next_elem
		stosw
	next_elem:
	loop loopCopy


; Q6: print uniq to check
mov ecx, lengthof uniq
lea esi, uniq
cld
xor eax, eax
print2:
	lodsw
	call writeInt
	loop print2

; Q7: implement: ax = twoD[2][3] use
; base index operand
	xor eax, eax
	mov ebx, offset twoD
	add ebx, 2 * 5 * type twoD
	mov edi, 3 * type twoD
	mov ax, [ebx + edi]


; Q8: print out ax:

	call crlf
	call writeInt

; Q9: implement: ax = twoD[1][2] 
; by using base index displacement operand 
	xor eax, eax
	mov ebx, 1 * 5 * type twoD
	add ebx, 2 * type twoD

	mov ax, [twoD + ebx]

; Q10: print out ax:
	call crlf
	call writeInt
exit
main ENDP
END main
