					

; Description: - basics of procedure calls 
;              - using registers to pass parameters


INCLUDE Irvine32.inc

;; use the debugger to step through the code below with nested calls 
;; 1. answer the questions
;; 2. identify which call goes with which return by numbering them together
;;     call 1 goes with ret 1, call 2 goes with ret 2, etc. so you can
;;     see how deep the stack frames go
;; 2. observe when ESP changes value and explain why it does



.data

.code
main PROC

; write code to clear out eax 
mov eax, 0

; explain what happens with each step
; and if there is any change to the stack
mov ax,3		;    ax is changed to 3, and eax is now 3. No change to stack
mov bx,4		;    bx is changed to 4, and ebx is some value. No change to stack
call add1		;    The address of the next line is pushed to stack, and eip is now the address pf add1
call writeDec	;   writeDec is called, making changes in stack but leaving no net change after its finished
call crlf

exit
main ENDP


add1 PROC
add ax,bx		; bx is added to ax, making eax 7
call test1		; the address of the next line is pushed to stack, and eip is now the address of test1
ret				; returns eip's value to the next address from main
				; what happens if there is no ret here?
add1 ENDP


test2 PROC		; 
mov dx,200h		; dx is now 200h, and edx is some value
				; Show what the stack looks like (with all its values 
				; in order in the stack) when execution reaches this line
				; How many stack frames are there at this point?
ret				; pops eip, returning to the address that was placed when its called
test2 ENDP


test1 PROC
mov cx,1		; cx is now 1, and ecx is some value. No change to stack
push eax        ; 7 is pushed to stack

mov ax, 10		; 10 is moved to ax, making eax 10

call writeDec	; writeDec is called, making changes in stack but leaving no net change after its finished

pop eax			; eax is now 7

call crlf		; crlf is called, making changes in stack but leaving no net change after its finished

call test2		; address of the next line is pushed to stack, and eip is now the address of test2
mov dx, 300h	; dx is now 300h, and edx is some value
ret				; pop eip, returning eip's value to the next address from add1
test1 ENDP


END main
