; Author:	   Evren Keskin
; Date:        01/24/2019
; Filename:        Assignment3.asm
; Description: This program will take three number inputs from the user,
; and then display the quotient and remainder from this equation:
; (num2 % 780 - 2 * num1 * num3)/(num1 ^ 3)

;imports
include irvine32.inc

;variables
.data
string1 BYTE "Enter the value of num1?", 0
string2 BYTE "Enter the value of num2?", 0
string3 BYTE "Enter the value of num3?", 0
string4 BYTE "The quotient is: ", 0
string5 BYTE "The remainder is: ", 0
num1 dword ?   ; 4 bytes
num2 dword ?
num3 dword ?

;main code
.code
main proc
	;Taking prompts for number entry from user
	mov edx, offset string1
	call writeString

	call readDec
	mov num1, eax

	mov edx, offset string2
	call writeString

	call readDec
	mov num2, eax

	mov edx, offset string3
	call writeString

	call readDec
	mov num3, eax

	; Equation calculated here
	; (num2 % 780 - 2 * num1 * num3)/(num1 ^ 3)

	mov eax,num2
	mov ebx, 780
	sub edx, edx
	div ebx			; quotient eax and remainder edx, mod calculation will use remainder
	mov ebx, edx
	mov eax, num1
	mul num3
	mov edx, 2
	mul edx
	sub ebx, eax	; ebx now has the first paranthesis's result
	mov eax, num1
	mul num1
	mul num1		; eax has the second paranthesis's result
	mov ecx, eax
	mov eax, ebx
	sub edx, edx
	div ecx
	mov num1, eax	; num1 is now the quotient
	mov num2, edx	; num2 is now the remainder

	mov edx, offset string4
	call writeString

	mov eax, num1
	call writeInt
	
	call crlf

	mov edx, offset string5
	call writeString

	mov eax, num2
	call writeInt

	exit
main endp

end main

comment!
Run #1
!

comment!
Run #2
!

comment!
Run #3
!
