TITLE worksheet 5                   

comment !
The following class exercise is for the third week
Topics: Assembly Fundamentals and Library Calls

1. Use the comment directive instead of ; for
the first 4 lines of comments
!

comment !
2. Name the directives that you see in the code:
.data
.code
include
!

INCLUDE Irvine32.inc

; 3. define a constant for the number of seconds in an hour
; by using an integer expression constant

.data
; 4. define a string: “Hello there, enter a number: ”;

; 5. define a byte and initialize with binary 110

; 6. define a word and initialize with hexadecimal F9

; 7. define a doubleword and initialize with -16

;8. define a doubleword and leave it Uninitialized
                                 
; 9. define an array of 5 doublewords and initialize with the values 1,2,3
; and leaving the last 2 elements uninitialized

.code
main PROC

; 10. write code to print the string

; 11. write code to read a value and save it in the Doubleword in step
;     8 from the user   

; 12. write code to store the immediate value -1 in eax

; 13. write code to print the word defined in step 6

; 14. write code to print the doubleword defined in step 7

; 15. show what the array of 5 doublewords look like.
; Why does it look like that?

    exit   
main ENDP

END main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;