INCLUDE Irvine32.inc
comment *
	      Maxim Tyutyunin
		  Ass#3
		  Question B
		  Purpose: program reads 6 ints into an word array, add them and 
		  print three times: first as a SIGNED integer, then as a HEX value,
		  and finally as a BINARY value.
		*
.data

array SWORD 6 DUP(?)

prompt BYTE "Enter an integer: ", 0

msg1 BYTE " The signed total of the 6 numbers is: ", 0
msg2 BYTE " The total of the 6 numbers in hex is: ", 0
msg3 BYTE " The total of the 6 numbers in binary is: ", 0


.code
main PROC
mov edx, OFFSET prompt			; Ask the question
	call WriteString
	call ReadInt				; collect first num and store it in EAX
	mov [array], ax				; array[0] = user input

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect second num and store it in EAX
	mov [array+2], ax			; array[1] = user input

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect third num and store it in EAX
	mov [array+4], ax			; array[2] = user input

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect forth num and store it in EAX
	mov [array+6], ax			; array[3] = user input

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect fifth num and store it in EAX
	mov [array+8], ax			; array[4] = user input

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect sixth num and store it in EAX
	mov [array+10], ax			;array[5] = user input

comment *
	mov ax, [array]
	add ax, [array+2]
	add ax, [array+4]
	add ax, [array+6]
	add ax, [array+8]
	add ax, [array+10]

	i dont know which way is better but will use the second one
	*
	; since nums are16 bits (2 bytes) use movsx to make them larger in size
	; the issue here is that if i paste "-1" it saves it as ffff ffff which it shouldnt do i guess
	movsx eax, [array]				;eax = array[0]
	movsx ebx, [array+2]			;ebx = array[1]
	add eax, ebx					;eax += ebx
	movsx ebx, [array+4]		;ebx = array[2]
	add eax, ebx				;eax += ebx
	movsx ebx, [array+6]			;ebx = array[3]
	add eax, ebx					;eax += ebx
	movsx ebx, [array+8]		;ebx = array[4]
	add eax, ebx				;eax += ebx
	movsx ebx, [array+10]			;ebx = array[5]
	add eax, ebx					;eax += ebx
								; eax = array[0] + array[1] + array[2] + array[3] + array[4] + array[5]


	

	mov edx, OFFSET msg1
	call WriteString
	call WriteInt					; sout(eax)

	call CrLf		
	
	mov edx, OFFSET msg2
	call WriteString
	call WriteHex					; sout(eax.hex)

	call CrLf		

	mov edx, OFFSET msg3
	call WriteString
	call WriteBin					; sout(eax.bin)

	exit
main ENDP
END main