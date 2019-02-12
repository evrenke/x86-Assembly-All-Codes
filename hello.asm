include Irvine32.inc

.data
myStr byte "Hello World!", 0
myStrRev byte (lengthof myStr - 1), 0

.code
main proc
	
	mov ecx, (lengthof myStr - 1)
	sub esi, esi

	L1:
	movzx eax, myStr[esi]
	push eax	
	inc esi
	loop L1

	call proc1
	
exit
main endp

proc1 proc
    ;IMPORTANT LINE HERE
	pop edx



	mov ecx, (lengthof myStr - 1)
	sub esi, esi

	L2:
	pop eax
	mov myStrRev[esi], al
	call writeChar
	inc esi
	loop L2

	;ANOTHER IMPORTANT LINE HERE
	push edx
ret
proc1 endp
proc2 proc


ret
proc2 endp

end main