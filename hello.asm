; This is a simple add program

include irvine32.inc

.data
string1 BYTE "please enter a number", 0
string2 BYTE "num1 + num2 = ", 0
num1 dword ?
num2 dword ?

.code
main proc

	mov edx, offset string1 ; edx now has the address of string1
	call writeString        ; prints what edx is pointing at

	call readDec          ; reads number input into eax
	mov num1, eax 

	comment !
	You can make comment blocks using this stuff
	thats cool
	a number input is taken from the user into num1
	with a user prompt printed as string1

	!
	
	mov edx, offset string1
	call writeString

	call readDec
	mov num2, eax

	mov eax, num1
	add eax, num2

	mov edx, offset string2
	call writeString
	call writeDec   ; prints out UNSIGNED number at eax
	;call writeInt  ; alternatively this can be used to print a number as a signed value
	call crlf ; new line

	exit
main endp
end main