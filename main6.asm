;;; Assignment 6
;;; Date: 02/21/2019

;;; Description: This code will take a positive number input from the user
;;;              It will then display all positive numbers below that number 
;;;              that have 2 integral divisors

include Irvine32.inc

.data
inputStr BYTE "Enter a positive integer: ", 0
errorStr BYTE "That is not a positive integer! ", 0
keyPrompt BYTE "Press any key... ", 0
numStr BYTE "This number has two divisors: ", 0

.code
main proc

	; global variables only used in main
	mov edx, offset inputStr
	mov ebx, offset errorStr
	call posInput
	; eax now holds a positive value from the user

	call crlf
	mov ebx, 1

	; c++ interpretation of code:
	
	; while (ebx < eax)
	; oldEax = eax
	; eax = is2Divisors(ebx)
	; if(eax == 1)
	; print number
	; eax = oldEax
	; ebx++
	
	loopNumbers:
	; go through all numbers below eax
	; and print each one with two integral divisors out
	cmp ebx, eax
	JGe outLoop01

	push eax
	mov eax, ebx
	call is2Divisors ; eax is now 0 or 1 -> A flag of if the number has 2 divisors
	cmp eax, 1
	JNe dontPrintNum
	mov eax, ebx
	mov edx, offset numStr
	call WriteString
	call writeDec
	call crlf

	dontPrintNum:
	pop eax
	inc ebx
	Jmp loopNumbers

	outLoop01:
	
	mov edx, offset keyPrompt
	call WaitForKey

	exit
main endp


;;; Description: Takes a positive input integer from the user
;;; Parameters:  edx with offset of outputted string
;;;              ebx with offset of error string
;;; Modified:    eax register used to return value
posInput proc
	; c++ interpretation of code:

	; do input = readInt
	; while(input <= 0)

	whileInput:
	call WriteString
	call readInt
	cmp eax, 0
	JG outLoop02
	push edx
	mov edx, ebx
	call WriteString
	pop edx
	call crlf
	Jmp whileInput
	outLoop02:

ret
posInput endp

;;; Description: For the number in the paramater number,
;;;              the amount of integral divisors is found
;;;              If that number is 2, it returns "true" (1) in eax
;;;              If not then it returns "false" (0) in eax
;;; Parameters:  eax register with number to check
;;; Modified:    eax register to flag if the number has two integral divisors
is2Divisors proc

	push ebx ; preserve ebx value
	; no need to preserve edx or ecx value
	push ecx
	push edx

	mov ebx, 2    ; ebx will scroll through numbers
	sub ecx, ecx  ; ecx will count divisors
	
	; c++ interpretation of code:

	; while (ebx < eax)
	;	if (ecx >=3) break;
	;   if (eax % ebx == 0)
	;	    ecx++;
	;   ebx++

	whileEBXLessThanEAX:
		cmp ebx, eax
		JGe outLoop03 ; ebx is now past eax so loop ends
		cmp ecx, 3
		JGe outLoop03 ; 3 divisors or more, already invalid no need to count more
		sub edx, edx  ; edx will be used in division

		;c++ equivalent: edx = eax % ebx 
		push eax
		div ebx ; edx:eax / ebx = quotient eax + remainder edx
		pop eax
		
		cmp edx, 0
		JNe notADivisor
		inc ecx
		notADivisor:
		inc ebx
		Jmp whileEBXLessThanEAX
	outLoop03:
	
	; if ecx, the divisor count, is equal to 2 it will set eax to 1
	; else eax is set to 0 

	cmp ecx, 2
	JNe not2Divisors
	mov eax, 1
	Jmp has2Divisors
	not2Divisors:
	xor eax, eax
	has2Divisors:

	pop edx
	pop ecx
	pop ebx
	
ret
is2Divisors endp

;;; Description: A procedure to pause the program by taking user input char
;;; Parameters:  edx with offset of outputted string
;;; Modified:    None
WaitForKey proc

	push eax
	
	call WriteString
	call ReadChar

	pop eax
	
ret
WaitForKey endp

end main

comment !
TEST RUN:
Enter a positive integer: 16

This number has two divisors: 6
This number has two divisors: 8
This number has two divisors: 10
This number has two divisors: 14
This number has two divisors: 15
Press any key...

!
