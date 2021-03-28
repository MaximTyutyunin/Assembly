INCLUDE Irvine32.inc

.data

array SWORD 5 DUP(?)

prompt BYTE "Enter an integer... ", 0

msg BYTE " The total of the 5 numbers is: ", 0

total WORD ?

.code
main PROC
	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect first num and store it in EAX
	mov [array], ax				;brackets are not important

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect second num and store it in EAX
	mov [array+2], ax

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect third num and store it in EAX
	mov [array+4], ax

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect forth num and store it in EAX
	mov [array+6], ax

	mov edx, OFFSET prompt		; Ask the question
	call WriteString
	call ReadInt				; collect fifth num and store it in EAX
	mov [array+8], ax
	

	mov al, "{"					;print {
	call WriteChar

	movsx eax, [array]			; move first val in the array to eax
	call WriteInt				; write contents of eax
	mov ebx, eax				; move number into ebx so we can add new numbers to it later 
	mov al, ","					; for orinting comma
	call WriteChar
	

	movsx eax, [array+2]		; [array+2] because we work with WORD array
	call WriteInt
	add ebx, eax				; add new numbers to contents of eax 			
	mov al, ","
	call WriteChar
	

	movsx eax, [array+4]
	call WriteInt
	add ebx, eax
	mov al, ","
	call WriteChar
	

	movsx eax, [array+6]
	call WriteInt
	add ebx, eax
	mov al, ","
	call WriteChar
	

	movsx eax, [array+8]
	call WriteInt
	add ebx, eax
	

	mov al, "}"							;print }
	call WriteChar

	call CrLf							; print new empty line
	mov edx, OFFSET msg					;print string			
	call WriteString
	mov eax,ebx							; move because "WriteInt" prints contents of eax 
	call WriteInt						;print sum


	exit
main ENDP
END main