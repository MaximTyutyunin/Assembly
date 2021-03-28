INCLUDE Irvine32.inc

comment *
	      Maxim Tyutyunin
		  Ass#3
		  Question A
		  Purpose: program reads two HEX values from the user (with a different prompt for each). Stores
		  each value in one of two WORD variable called number1 and number2.
		*

.data

prompt1 BYTE "Please enter the first number: ", 0			;all strings -> null-terminated
prompt2 BYTE "Please enter the second number: ", 0

msg1 BYTE "Number1 in HEX is: ", 0
msg2 BYTE "Number2 in HEX is: ", 0
msg3 BYTE "Number1 + number2 in binary is: ", 0
msg4 BYTE "As a signed integer, number1 is: ", 0
msg5 BYTE "As an unsigned integer, number2 is: ", 0

number1 SWORD ?
number2 SWORD ?
 

.code
main PROC

	mov edx, OFFSET prompt1		; Ask the question, EDX is for messages
	call WriteString			; Write string for returning a message, it works with EDX
	call ReadHex				; collect first num and store it in EAX
	mov  number1, ax			; store contents of ax into number1(word) and use ax coz it is 2 bytes long 

	mov edx, OFFSET prompt2		; Ask the question, EDX is for messages
	call WriteString			; Write string for returning a message
	call ReadHex				; collect first num and store it in EAX
	mov  number2, ax			; store contents of ax into number2(word) and use ax coz it is 2 bytes long 

	mov eax, 123456789

	;to write num1 in hex
	mov edx, OFFSET msg1
	call WriteString
	movzx eax, number1			; use movsx <- unsigned integers go here to make them larger in size to match target register
	call WriteHex

	call CrLf					; new line

	;to write num2 in hex
	mov edx, OFFSET msg2
	call WriteString			;sout(msg2)
	movzx eax, number2			; eax = number2
	call WriteHex				; sout(eax.hex)

	call CrLf	

	; this is for addition
	movzx ebx, number1			; ebx = number1 + (ebx.size - number1.size)
	add eax, ebx				; eax = ebx
	mov edx, OFFSET msg3
	call WriteString			;sout(msg3)
	call WriteBin
	
	call CrLf
	
	;to display a signed int
	mov edx, OFFSET msg4
	call WriteString
	movsx eax, number1
	call WriteInt

	call CrLf

	;to display an unsigned int
	mov edx, OFFSET msg5
	call WriteString
	movsx eax, number2
	call WriteDec

	exit
main ENDP
END main