;;; Assignment 5
;;; Date: 02/19/2019

comment !
Write a program that:
1.     Clears the screen, locates the cursor near the middle of the screen.
2.     Prompts the user for two signed integers.
3.     Displays their sum and difference.
4.     Repeats the same steps three times. Clears the screen after each loop iteration.
5.     You need to call the following procedures from irvine32 library:
·        ClrScr
·        WriteString
·        WriteInt
·        ReadInt
·        Crlf
·        ReadChar
·        Gotoxy

The Gotoxy procedure locates the cursor at a given row and column in the console window.
By default, the console window’s X-coordinate range is 0 to 79 and the Y-coordinate range is 0 to 24.
When you call Gotoxy, pass the Y-coordinate (row) in DH and the X-coordinate (column) in DL. Sample call:

mov   dh,10 ; row 10
mov   dl,20 ; column 20
call  Gotoxy; locate cursor


6.     You need to create the following procedures:
        Locate. It needs to be called before anything displays on the screen. Where it sets the cursor position.         
		Input: this procedure prompts the user and saves the input.
		DisplaySum: calculates and displays the sum.
		DisplayDiff: calculates and displays the difference. (first input - the second input)
		WaitForKey; It needs to be called at the end of each iteration.
		It displays "Press any key..." and waits for an input
!

include Irvine32.inc

.data
signedNum1 DWORD ?  ; The first number the user enters 
signedNum2 DWORD ?  ; The second number the user enters

inputVar DWORD ?    ; The number Input proc uses to save the values entered
inputPrompt BYTE "Enter an integer: ", 0
sumString BYTE "The sum of both integers: ", 0
diffString BYTE "The difference of both integers: ", 0
keyPrompt BYTE "Press any key... ", 0
.code
main proc
	mov ecx, 3
	mainLoop:
;;; TASK 1) Clear the screen, locate the cursor near the middle of the screen.
	
		call Locate

;;; TASK 2) Prompt the user for two signed integers.
	
		call Input
		;;; inputVar now has the first input
		mov eax, inputVar
		mov signedNum1, eax

		call Input
		;;; inputVar now has the second input
		mov eax, inputVar
		mov signedNum2, eax

;;; TASK 3) Displays inputs sum and difference.
	
		call DisplaySum

		call DisplayDiff

		call WaitForKey
;;; TASK 4) Repeat steps 1-3 three times.
	loop mainLoop

	exit
main endp

comment !
;;; TASK 6) You need to create the following procedures:
        Locate
		Input
		DisplaySum
		DisplayDiff
		WaitForKey
!
;;;;; Sets the cursors position to the center of the command console
;;;;; Assumes the command console to have its default 80 by 25 size.
Locate proc

	push edx
	call ClrScr
	mov   dh, 10 ; row 39 of 80 range
	mov   dl, 20 ; column 12 of 25 range
	call  Gotoxy; locates cursor at (39, 12)
	pop edx

ret
Locate endp

;;;;; Prompts the user and saves the input.
;;;;; The input is a signed number
Input proc

	pop ebx
	call Locate
	mov edx, offset inputPrompt
	call writeString
	call readInt
	mov inputVar, eax
	call crlf
	push ebx

	;;; "Enter an integer: "
	;;; followed by user entry of signed number
ret
Input endp

;;; Takes the values of signedNum1 and signedNum2
;;; And displays their sum to the user
DisplaySum proc

	call Locate
	push eax
	push edx
	
	mov eax, signedNum1 
	add eax, signedNum2      ;;; adds two values together
	mov edx, offset sumString
	call WriteString
	call WriteInt
	call crlf
	pop edx
	pop eax
ret
DisplaySum endp

;;; Takes the values of signedNum1 and signedNum2
;;; And displays their difference to the user
DisplayDiff proc

	call Locate
	push eax
	push edx
	
	mov eax, signedNum1
	sub eax, signedNum2    ;;; subtracts the second value from the first
	mov edx, offset diffString
	call WriteString
	call WriteInt
	call crlf
	pop edx
	pop eax
ret
DisplayDiff endp

;;; Stops the program to take an unused char input
;;; Outputs "Press any key..." to user
WaitForKey proc

	call Locate
	push eax
	push edx
	mov edx, offset keyPrompt
	call WriteString
	call ReadChar

	pop edx
	pop eax
	
ret
WaitForKey endp

end main


comment !
TEST RUNS:

Run 1:


Run 2:


Run 3:


!