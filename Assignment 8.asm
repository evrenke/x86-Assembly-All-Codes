Title Assignment 8

COMMENT !
*****************
date: 03/19/2019
*****************
Description:
	- This program asks the user for the length of a 2D array to use (up to 40)
	- It then asks how many elements there are in a row
	- It also asks the type of the arrays data (BYTE, WORD, DWORD)
	- Then the user is prompted to enter the data of their array
	- After filling the array, the user can ask the sum of the elements in a row
	  By giving the row index
!

include irvine32.inc
; ===============================================
.data

sizeString BYTE "How many elements does your 2D array have?", 0
rowStr BYTE "How many elements in a row of your 2D array?", 0
rowStr2 BYTE "(It should divide the array into equal rows)", 0
dataStr BYTE "What type of data does your array have?", 0
dataStr2 BYTE "Type 1 for BYTE, 2 for WORD, and 3 for DWORD", 0
elementsStr BYTE "Enter the elements of your array", 0
sumStr BYTE "Which row do you want to sum up?", 0
sumStr2 BYTE "The sum is : " , 0
pauseStr BYTE "Press any key to continue...", 0

arraySize BYTE ?
rowSize BYTE ?
dataType BYTE ?
rowIndex BYTE ?
array DWORD 40 dup (?)


;=================================================
.code
main proc
	
	;;;;; Ask for array size ;;;;;
	mov edx, offset sizeString
	call writeString
	call crlf
	push 40
	call read_range_int
	pop eax
	mov arraySize, al


	;;;;; Ask for elements per row ;;;;;
	mov edx, offset rowStr
	call writeString
	call crlf
	mov edx, offset rowStr2
	call writeString
	call crlf
	push eax
	call read_range_int
	pop eax
	mov rowSize, al


	;;;;; Ask for array data type ;;;;;
	mov edx, offset dataStr
	call writeString
	call crlf
	mov edx, offset dataStr2
	call writeString
	call crlf
	push 3
	call read_range_int
	pop eax
	mov dataType, al


	;;;;; Ask for the elements of the array ;;;;;
	; if(dataType == 1)
	;	enter_elem(BYTE, offset array, arraySize, rowSize)
	; else if(dataType == 2)
	;	enter_elem(WORD, offset array, arraySize, rowSize)
	; else
	;	enter_elem(DWORD, offset array, arraySize, rowSize)
	;

	cmp dataType, 1
	JNE notBYTE
		push BYTE
		jmp pushedType
	notBYTE:
	cmp dataType, 2
	JNE notWORD
		push WORD
		jmp pushedType
	notWORD:
	push DWORD
	pushedType:

	push offset array
	xor eax, eax
	mov al, arraySize
	push eax
	mov edx, offset elementsStr
	call writeString
	call crlf
	call enter_elem


	;;;;; Ask for the index of the row to sum up ;;;;;
	mov edx, offset sumStr
	call writeString
	call crlf

	mov al, arraySize
	div rowSize
	dec al
	; this is calculating how many rows there should be based on array size and row length
	; EXAMPLE: 40 size, 10 row length = 4 rows
	; then it decrements by one because selection is from 0 to 3 instead of 1 to 4

	push eax
	call read_range_int
	pop eax
	mov rowIndex, al


	sub esp, 4
	push offset array    ;;;; pushing *array

	mov al, rowSize      ;;;; pushing rowSize
	push eax

	; if(dataType == 1)
	;	calcRowSum(offset array, arraySize, BYTE, rowSize)
	; else if(dataType == 2)
	;	calcRowSum(offset array, arraySize, WORD, rowSize)
	; else
	;	calcRowSum(offset array, arraySize, DWORD,rowSize)
	;
	

	cmp dataType, 1
	JNE notBYTE2
		push BYTE
		jmp pushedType2
	notBYTE2:
	cmp dataType, 2
	JNE notWORD2
		push WORD
		jmp pushedType2
	notWORD2:
	push DWORD
	pushedType2:         ;;;; pushing type
	mov al , rowIndex
	push eax            ;;;; pushing rowIndex

	;calcRowSum( int *array, int rowSize, int type, int rowIndex)
	call calcRowSum 
	pop eax

	mov edx, offset sumStr2
	call writeString
	call writeInt
	call crlf

	;;;;; Pause main screen ;;;;;
	mov edx, offset pauseStr
	call writeString
	call readChar

   exit
main endp

; ================================================
; void read_range_int(max)
;
; Input:
;   MAX the maximum value the integer can be
; Output:
;   input int through the stack
; Operation:
;   take an integer value between 0 and the maximum value
; ================================================
read_range_int proc
	push ebp
	mov ebp, esp
	push eax
	xor eax, eax

	; do
	; {
	;	eax = call readInt();
	; } while (eax > [ebp + 8] || eax < 0);

	call readInt
	whileTakingInputs:
		cmp eax, [ebp + 8]
		JG takeInput
		cmp eax, 0
		JL takeInput
		jmp outLoop
		takeInput:
		call readInt
		jmp whileTakingInputs
	outLoop:

	mov [ebp+8], eax
	pop eax
	pop ebp
	ret

read_range_int endp

; ================================================
; void enter_elem(datatype, offset array, arraySize)
;
; Input:
;   datatype BYTE WORD OR DWORD
;	array offset of the array to fill
;	arraySize number of elements to fill
;	rowSize number of rows to fill
; Output:
;   No returns
; Operation:
;   Fill the array with elements from the user
; ================================================
enter_elem proc
	push ebp
	mov ebp, esp
	push edx
	push ebx
	push eax
	push edi

	mov edx, [ebp + 16] ; data type
	mov edi, [ebp + 12] ; array offset
	mov ebx, [ebp + 8] ; array size
	xor eax, eax

	comment!
	; go through the array length and fill in every value with an input
	while( eax < ebx )
	{
		oldEAX = eax
		eax = readInt();
		array[edi] = eax;
		eax = oldEAX;
		eax++;
	}
	!
	loopInputs:
		cmp eax, ebx
		jGE outLoop
		push eax
		call readInt
		mov [edi], eax
		pop eax
		add edi, edx
		inc eax
		jmp loopInputs
	outLoop:

	pop edi
	pop eax
	pop ebx
	pop edx
	pop ebp
	ret 12
enter_elem endp


; ================================================
; int calcRowSum( int *array, int rowSize, int type, int rowIndex)
;
; Input:
;  *array   : is the array offset to modify
;  rowSize  : row size in array
;  type     : the datatype to use (BYTE, WORD or DWORD)
;  rowIndex : the index of the row to modify, chosen by the user
; Output:
;   returns the sum of the row through the stack
; Operation:
;   Move a pointer to the beginning of a row, and sum up all values on that row
; ================================================
calcRowSum proc
	push ebp
	mov ebp, esp
	push edi
	push edx
	push ecx
	push ebx
	push eax

	mov edi, [ebp + 20] ; the array offset
	mov ecx, [ebp + 12] ; datatype
	mov ebx, [ebp + 16 ] ; row size

	comment!
	; C++ Equivalent of summing up a row
	eax = datatype * rowsize * rowIndex;
	// this will move the index to the beginning of the row to sum
	edi += eax;
	eax = 0;
	ebx = 0;
	if(ecx == BYTE)
		while(ebx < edx)
		{
			al += [edi];
			edi += ecx;
			ebx++;
		}
	else if(ecx == WORD)
		while(ebx < edx)
		{
			ax += [edi];
			edi += ecx;
			ebx++;
		}
	else
		while(ebx < edx)
		{
			eax += [edi];
			edi += ecx;
			ebx++;
		}
	[ebp + 24] = eax;
	!

	xor edx, edx
	mov eax, ecx
	mul ebx
	mov ebx, [ebp + 8] ; row index
	mul ebx            
	;eax now has the index addition needed
	add edi, eax
	
	xor eax, eax
	mov edx, [ebp + 16] ; row size
	xor ebx, ebx


	cmp ecx, 1
	JNE notBYTE3
		loopSumByteRow:
		cmp ebx, edx
		jGE outLoop1

		add al, [edi]
		add edi, ecx
		inc ebx
		jmp loopSumByteRow
	outLoop1:
		jmp sumFinish
	notBYTE3:
	cmp ecx, 2
	JNE notWORD3
	loopSumWordRow:
		cmp ebx, edx
		jGE outLoop2

		add ax, [edi]
		add edi, ecx
		inc ebx
		jmp loopSumWordRow
	outLoop2:
		jmp sumFinish
	notWORD3:
	loopSumDWordRow:
		cmp ebx, edx
		jGE outLoop3

		add eax, [edi]
		add edi, ecx
		inc ebx
		jmp loopSumDWordRow
	outLoop3:
	sumFinish:

	mov [ebp + 24], eax
	
	pop eax
	pop ebx
	pop ecx
	pop edx
	pop edi
	pop ebp
	ret 16
calcRowSum endp

end main

comment!
SAMPLE RUN:
How many elements does your 2D array have?
15
How many elements in a row of your 2D array?
(It should divide the array into equal rows)
5
What type of data does your array have?
Type 1 for BYTE, 2 for WORD, and 3 for DWORD
2
Enter the elements of your array
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
Which row do you want to sum up?
2
The sum is : +65
Press any key to continue...
!