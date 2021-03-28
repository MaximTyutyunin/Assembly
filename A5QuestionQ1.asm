INCLUDE Irvine32.inc
		  ;Maxim Tyutyunin
		  ;Ass#7
		  ;Question Q1
		  ;Purpose: the procedure checks if a user number is a power of 2 or not and prints messages acordingly
.data
prompt BYTE " Enter a number, power of two plezzzz: ", 0
msg1 BYTE " Your number in binary --> ", 0
msg2 BYTE " Nope, the number is not a power of 2", 0
msg3 BYTE " Ye, the number is  a power of 2", 0

.code
main PROC
	mov edx, OFFSET prompt
	call WriteString
	call ReadInt
	mov edx, OFFSET msg1
	call WriteString
	call WriteBin

	call CrLf

	call CheckPowerOfTwo
	jnz badNum											; jump if zf == 1
	mov edx, OFFSET msg3
	call WriteString
	jmp done
badNum:
	mov edx, OFFSET msg2
	call WriteString
done:

	    exit
main ENDP
;*******************************************
CheckPowerOfTwo PROC
;Returns: nothing
;Resieves: eax
;the function moves bits to the right till 1 bit reaches the LSB position
;if in that state the number is one than its even 
;*******************************************
	pushad

	cmp eax, 0		 ; compare to zero 
	je Power

	mov ecx, 32

L:	
	test eax, 00000000000000000000000000000001b					; check when 1 is at LSB position 
	jnz power
	shr eax, 1

	loop L

power:
	cmp eax, 1						; zf = 1 if destination == sourse
					

	popad
ret
CheckPowerOfTwo ENDP
END main