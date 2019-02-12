


include irvine32.inc

.data
myBytes BYTE 10h,20h,30h,40h
myWords WORD 8Ah,3Bh,72h,44h,66h
myDoubles DWORD 1,2,3,4,5

.code
main proc
;;;;;;;;;;;
;Question 1
;;;;;;;;;;;

mov  eax,DWORD PTR myWords      ; a: EAX:   00 3B 00 8A  ;it takes the first two words from myWords as a dword
mov  ax, word Ptr myDoubles     ; b: AX:    00 01        ;it takes the first dword as a word, leaving the other two bytes of 00 00 alone
mov  ax, lengthof myDoubles     ; c: AX:    5            ;it has 5 elements so its value is 5 
mov  ebx, offset myDoubles
add  ebx, type myDoubles		; d: EBX:                ;

comment !
;;;;;;;;;;
Question 2
;;;;;;;;;;
 ZF is zero flag, it returns 1 if the number is 0
 SF is most significant bit flag, it returns the most significant bit (1 or 0)
 CF is carry flag
Assume ZF, SF, CF, OF are all clear at the start, and the 3 instructions below run one after another. 
a. fill in the value of all 4 flags after each instruction runs 
b. explain why CF and OF flags have that value 
   Your explanation should not refer to signed or unsigned data values, 
   the ALU doesn't differentiate signed vs. unsigned and yet it can set the flags.
!
mov al, 20h 

	add al, 71h     
	; a. ZF = 0  SF = 1  CF = 0  OF = 1
	; b. explanation for CF: the carry digit was 0, and add doesnt flip it so its 0
	;    explanation for OF: the carry digit was 0, and the highest digits carried number was 1, so XOR(0,1) gives 1
	; 0010 0000 + 0111 0001 = 0 1001 0001
	;      carry flag is zero ^ ^ the overflow checked that this digit became 1 because of overflow  , 

	sub al, 0F0h     
	; a. ZF = 0  SF = 0  CF = 1  OF = 0
	; b. explanation for CF: the carry digit was 0 and because it was a sub operation it was flipped to 1
	;    explanation for OF: the carry digit was 0, and the highest digits carried number was 0, so XOR(0,0) gives 0
	; 1001 0001 - 1111 0000 = 1001 0001 + 0000 1111 = 0 1010 0000
	;             carry flag flips this 0 into a 1    ^
	neg al			
	; a. ZF = 0  SF = 0  CF = 1  OF = 0
	; b. explanation for CF: the carry digit was 0, and because it was a neg operation it was flipped to 1
	;    explanation for OF: the carry digit was 0, and the highest digits carried number was 0, so XOR(0,0) gives 0
	; 0 - 1010 0000 = 0 + 0101 1110 + 1 = 0 0101 1111
	;      carry flag flips this into a 1 ^ ^ this stayed a zero
	exit 
main endp
end main

