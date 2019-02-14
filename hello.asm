; Program template
TITLE   Assignment 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; date: 02/14/2019
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Comment !
Write a complete program that:
    1. Prompts the user to enter 5 numbers then 5 letters.
    2. Saves the numbers to a 32-bit integer array, numArr.
    3. Saves the letters to charArr where each element reserves one byte.
    4. Prints the numbers and letters. 
    5. prints the mean of the number array,numArr
    6. copy all the elements from the numArr and the charArr
        to a quadword array, newArr in a reverse order.
        where each qword in newArr contains a letter that occupies
        4 bytes and a number that occupies 4 bytes, 
    7. Prints out the newArr.
    8. dumps out the memory for each array. This is done for you.  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      You MUST use loop and indirect addressing. 
      You MUST use the SIZEOF, TYPE, and LENGTHOF operators to make the program
      as flexible as possible if the arrays' size and type should be 
      changed in the future. NO IMMEDIATATE NUMBERS AT ALL IN THE CODE SEGMENT.
      Add comments to make your program easy to read. Your lines must not 
	  exceed 80 columns.
	  Look at the sample run for clarification.
	  Don't delete anything already written for you.		
	  Copy paste 2 of your runs and paste them at the end of your code
	
	!
    

include irvine32.inc

.data
string1 byte 0Ah,0Dh,"Dumping out charArr",0
string2 byte 0Ah,0Dh,"Dumping out numArr", 0
string3 byte 0Ah,0Dh,"Dumping out newArr", 0

charArr byte   5 dup  (?)
numArr  dword  5 dup  (?)
newArr  qword  5 dup  (?)

; add your data here

introStr byte "You will need to enter 5 integers and 5 characters for two arrays. ", 0
enterNumStr byte "Enter an integer: ", 0
numStr byte "The integer array you entered: ", 0
meanStr byte "The mean of the array you entered: ", 0
enterCharStr byte "Enter 5 characters: ", 0
charStr byte "The characters you entered: ", 0

.code
main proc
	;----------------------------Your Code starts Here-----------------------
	; 1. Prompt the user to enter 5 numbers then 5 letters
	; 2. Save the numbers to a 32-bit integer array, numArr.
	; The inputs are saved as they are taken from the user

	mov edx, offset introStr
	call writeString
	call crlf
	
	mov ecx, lengthof numArr
	sub ebx, ebx
	mov edx, offset enterNumStr
	sub eax,eax
	loopNumEntry:
		call writeString
		call readDec
		mov numArr[ebx], eax
		add ebx, type numArr
	loop loopNumEntry

	; 1. Prompt the user to enter 5 numbers then 5 letters
	; 3. Saves the letters to charArr where each element reserves one byte.
	; Taking the character input from the user

	mov edx, offset enterCharStr
	call writeString

	mov ecx, lengthof charArr
	sub ebx, ebx
	loopCharEntry:
		call readChar
		mov charArr[ebx], al
		call writeChar
		inc ebx
	loop loopCharEntry
	
	call crlf
    
    ;4. Prints the numbers and letters. 

	mov edx, offset numStr  ; "The integer array you entered: "
	call writeString

	mov ecx, lengthof numArr
	sub ebx, ebx
	loopNumDisplay:
		mov eax, numArr[ebx]
		call writeDec
		mov al, ' '
		call writeChar
		add ebx, type numArr
	loop loopNumDisplay

	call crlf

	mov edx, offset charStr  ; "The characters you entered: "
	call writeString

	mov ecx, lengthof charArr
	sub ebx, ebx
	loopCharDisplay:
		mov al, charArr[ebx]
		call writeChar
		mov al, ' '
		call writeChar
		inc ebx
	loop loopCharDisplay

	call crlf

    ;5. prints the mean of the number array,numArr

	mov ecx, lengthof numArr
	mov ebx, 0
	sub eax, eax ; eax will hold the total value of the array
	loopAddNums:
		add eax, numArr[ebx]
		add ebx, type numArr
	loop loopAddNums

    sub edx, edx
	mov ebx, lengthof numArr
	div ebx 
	; mean value quotient now in eax
	; mean remainer now in edx
	; both need to be printed
	
	mov ebx, edx
	mov edx, offset meanStr ; "The mean of the array you entered: "
	call writeString
	mov edx, ebx
	call writeDec ; prints out eax, which has the mean quotient
	mov al , ' '
	call writeChar
	mov eax, edx
	call writeDec
	mov al, '/'
	call writeChar
	mov eax, lengthof numArr
	call writeDec

	; prints out mean in format quotient remainder/total numbers
	; example : "14 4/5"

	;6. copy all the elements from the numArr and the charArr
    ;    to a quadword array, newArr in a reverse order.
    ;    where each qword in newArr contains a letter that occupies
    ;    4 bytes and a number that occupies 4 bytes,

	mov ecx, lengthof newArr   ; 5
	mov ebx, type newArr       ; 8
	L6:
	 ; how each element in newArr is constructed
	 ; newArr[ecx] =  charArr[ecx] + numArr[ecx]
		mov eax, ecx           ; eax is now 5
		dec eax                ; decrement to adjust for index
		mul ebx                ; multiply by newArr type to measure correct size bytes
		; eax now holds the right index to look at

		mov edx, charArr[ecx] ; edx will be the upper half of newArr[eax]
		sub eax, typeof numArr
		mov newArr[eax], edx
		add eax, typeof numArr
		
		mov edx, numArr[ecx * 4]

		mov newArr[eax], edx
		; CONTINUE FIXING HERE

	 ; try to multiple ebx after adding char so the value goes up 4 bytes
	 ; leaving bx to hold the value of a num
	 ; then later you divide back down to bring the char to a usable register, use that
	 ; and then use the bx value with the number too
	 ; ... its convoluded but I think it works

	loop L6


    ;7. Prints out the newArr.
	; printing out requires format that keeps char and number values the same
	; "e3 m7 a6 l55 a3"


	; Im not actually sure how to do this...
	
	 
	  ; ---------------------------Your Code Ends Here-------------------------


      mov edx, offset string1
	  call writeString
      mov  esi,OFFSET charArr
      mov  ecx,LENGTHOF charArr
      mov  ebx,TYPE charArr
      call DumpMem
	   
	  mov edx, offset string2
	  call writeString
      mov  esi,OFFSET numArr
      mov  ecx,LENGTHOF numArr 
      mov  ebx,TYPE numArr    
      call DumpMem
	   
	  mov edx, offset string3
	  call writeString
      mov  esi,OFFSET newArr
      mov  ecx,LENGTHOF newArr 
      mov  ebx,TYPE numArr     
      call DumpMem
	  mov  esi,OFFSET newArr + Type numArr * LENGTHOF newArr
      mov  ecx,LENGTHOF newArr 
      mov  ebx,TYPE numArr     
      call DumpMem
exit
main endp
end main