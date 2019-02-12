; Program template
TITLE   Assignment 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; date: 
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
	L1:
		mov edx, offset enterNumStr
		call writeString
		call readDec
		mov numArr[ebx], eax
		inc ebx
	loop L1

	; 1. Prompt the user to enter 5 numbers then 5 letters
	; 3. Saves the letters to charArr where each element reserves one byte.
	; Taking the character input from the user

	mov edx, offset enterCharStr
	call writeString

	mov ecx, lengthof charArr
	sub ebx, ebx
	L2:
		call readChar
		mov charArr[ebx], al
		inc ebx
	loop L2
	
	
    
    ;4. Prints the numbers and letters. 
    ;5. prints the mean of the number array,numArr
    ;6. copy all the elements from the numArr and the charArr
    ;    to a quadword array, newArr in a reverse order.
    ;    where each qword in newArr contains a letter that occupies
    ;    4 bytes and a number that occupies 4 bytes, 
    ;7. Prints out the newArr.
	
	 
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
