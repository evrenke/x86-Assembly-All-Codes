Title Assignment 7

COMMENT !
*****************
date: 03/14/2019
*****************
Description:
	This program asks the user for up to 40 elements of an integer array
	Then it shows the user their array
	Before and after sorting it in descending order
!

include irvine32.inc
; ===============================================
.data

array DWORD 40 dup(?)
arr_length DWORD ?
introStr BYTE "Enter up to 40 unsigned dword integers. To end the array, enter 0.", 0
introStr2 BYTE "After each element press enter. ", 0
unsortedStr BYTE "Your initial array: ", 0
sortedStr BYTE "Your array sorted in descending order: ", 0
pauseStr BYTE "Press any key to continue...", 0

;=================================================
.code
main proc
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;Print introduction to user
	mov edx, offset introStr
	call writeString
	call crlf
	mov edx, offset introStr2
	call writeString
	call crlf

	;;;;;;;;;;;;;;;;;;;;;;;;;;Read array
	push offset array
	call enter_elem
	pop arr_length
	call crlf
	call crlf

	;;;;;;;;;;;;;;;;;;;;;;;;;;Show array made by user
	mov edx, offset unsortedStr
	call writeString
	call crlf
	push offset array
	push arr_length
	call print_arr
	call crlf

	;;;;;;;;;;;;;;;;;;;;;;;;;;Sort the array
	push offset array
	push arr_length
	call sort_arr

	;;;;;;;;;;;;;;;;;;;;;;;;;;Show the array after sorting
	mov edx, offset sortedStr
	call writeString
	call crlf
	push offset array
	push arr_length
	call print_arr
	call crlf
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;Pause main screen
	mov edx, offset pauseStr
	call writeString
	call readChar

   exit
main endp

; ================================================
; void enter_elem(arr_addr)
;
; Input:
;   ARR_ADDRESS THROUGH THE STACK
; Output:
;   ARR_LENGTH THROUGH THE STACK
; Operation:
;   Fill the array and count the number of elements
;
enter_elem proc
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push eax

	mov ebx, [ebp + 8]  ; the array offset
	xor ecx, ecx

	comment!
	;Go until to either 40 inputs or a "0" input
	while( ecx < 40 )
	{
		eax = readInt();
		if( eax == 0 )
			break;
		else
		{
			[ebx] = eax;
			ebx += dword;
			ecx++;
		}
	}
	!

	loopInputs:
		cmp ecx, 40
		jGE outLoop
		call readInt
		cmp eax, 0
		jE outLoop
		mov [ebx], eax
		add ebx, DWORD
		inc ecx
		jmp loopInputs
	outLoop:
	
	pop eax
	mov [ebp+8], ecx ; length of array
	pop ecx
	pop ebx
	pop ebp
	ret
enter_elem endp

; ================================================
; void print_arr(arr_addr,arr_len)
;
; Input:
;   array address and array length through stack
; Output:
;   no return
; Operation:
;  print out the array
;

print_arr proc
	push ebp
	mov ebp, esp
	push edx
	push ecx
	push ebx
	push eax

	mov edx, [ebp + 12] ; the array offset
	mov ecx, [ebp + 8]; the array length
	xor ebx, ebx

	comment!
	;going through array once to print each element
	while(ebx < ecx)
	{
		cout << [edx];
		cout << endl;
		edx += 4;
		ebx++;
	}
	!

	printLoop:
		cmp ebx, ecx
		jGE outPrintLoop

		mov eax, [edx]
		call writeDec
		mov eax, ' '
		call writeChar
		add edx, DWORD
		inc ebx
		jmp printLoop
	outPrintLoop:

	pop eax
	pop ebx
	pop ecx
	pop edx
	pop ebp

	ret 8
print_arr endp

; ================================================
; void sort_arr(arr_addr,arr_len)
;
; Input:
;   array address and array length through stack
; Output:
;   no returns
; Operation:
;   sort the array
;

sort_arr proc
	push ebp
	mov ebp, esp
	push edx
	push ecx
	push ebx
	push eax
	push edi
	
	mov ecx, [ebp + 8]; the array length
	; ecx = ecx * 4 ; to get the length in bytes not dword
	mov eax, ecx
	xor edx, edx
	mov ecx, 4
	mul ecx
	mov ecx, eax

	mov edx, [ebp + 12] ; the array offset
	xor ebx, ebx  ; ebx will be used in inner loop
	xor eax, eax  ; eax will be used in outer loop
	xor edi, edi  ; esi will be used to save maxindex location

	comment!
	;selection sorting in descending order
	;esi is the max index to swap with in one step
	;eax is an index for what location is being checked
	;ebx is the index of what the current location is being compared to
	while(eax < ecx)
	{
		ebx = eax; // ebx will check the location to swap with
		edi = ebx; // edi will be the maximum numbers index
		while(ebx < ecx)
		{
			if(array[ebx] > array[edi])
				edi = ebx;
			ebx++;
		}
		compare and swap ( array[eax], array[edi]);

		eax++;
	}
	!

	startSort:
		cmp eax, ecx
		jGE outSort

		mov ebx, eax
		mov edi, ebx

		searchMaxIndex:
			cmp ebx, ecx
			jGE outSearch
			push eax
			mov eax, [edx + ebx]
			cmp eax, [edx + edi]
			pop eax
			jLE notMax
			mov edi, ebx
			notMax:
			add ebx, dword
		jmp searchMaxIndex
		outSearch:
		
		add edx, eax
		push edx
		sub edx, eax

		add edx, edi
		push edx
		sub edx, edi
		call compare_and_swap

		add eax, dword
		jmp startSort
	outSort:

	pop edi
	pop eax
	pop ebx
	pop ecx
	pop edx
	pop ebp

	ret 8
sort_arr endp

; ===============================================
; void compare_and_swap(x_addr,y_addr)
;
; Input:
;   x address and y address through stack
; Output:
;   no return
; Operation:
;  compare and call SWAP ONLY IF X < Y 
;

compare_and_swap proc
	push ebp
	mov ebp, esp
	push eax
	push ebx
	push ecx
	push edx
	mov eax, [ebp + 12] ; x address
	mov ebx, [ebp + 8]  ; y address

	mov ecx, [eax] ; ecx has x value
	mov edx, [ebx] ; edx has y value
	cmp ecx, edx
	jGE dontSwap
		push eax
		push ebx
		call swap
	dontSwap:

	pop edx
	pop ecx
	pop ebx
	pop eax
	pop ebp

	ret 8
compare_and_swap endp

; =================================================
; void swap(x_addr,y_addr)
;
; Input:
;   x address and y address through stack
; Output:
;   no return
; Operation:
;  swap the two inputs
;

swap proc
	push ebp
	mov ebp, esp
	push eax
	push ebx
	push ecx
	push edx
	mov eax, [ebp + 12] ; x address
	mov ebx, [ebp + 8]  ; y address
	
	mov ecx, [eax] ; ecx has x value
	mov edx, [ebx] ; edx has y value
	mov [eax], edx ; x address gets y value
	mov [ebx], ecx ; y address gets x value

	pop edx
	pop ecx
	pop ebx
	pop eax
	pop ebp

	ret 8
swap endp

end main

comment!
Enter up to 40 unsigned dword integers. To end the array, enter 0.
After each element press enter.
1
2
3
4
5
6
7
8
9
0


Your initial array:
1 2 3 4 5 6 7 8 9
Your array sorted in descending order:
9 8 7 6 5 4 3 2 1
Press any key to continue...
!