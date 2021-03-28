INCLUDE Irvine32.inc

.data

numbers WORD 3 DUP(?)
totals WORD 3 DUP(?)

comma BYTE ", ", 0
msg1 BYTE "The array has been filled with random numbers", 0


.code
main PROC
    call Randomize
	mov eax, 0
	mov ecx, LENGTHOF numbers
	mov esi, 0
L1:
	mov eax, 200
	call RandomRange
	mov numbers[esi],  ax
	add esi, TYPE numbers
	loop L1

	mov edx, OFFSET msg1
	call WriteString

	call CrLf

	mov ebx, OFFSET numbers
	mov ecx, LENGTHOF numbers 
	call outputArray

	mov ebx, OFFSET numbers
	mov edx, OFFSET totals
	mov ecx, LENGTHOF numbers 
	call createRunningTotal

	call CrLf

	mov ebx, OFFSET totals
	mov ecx, LENGTHOF totals 
	call outputArray

	exit
main ENDP



;**********************************************************
outputArray PROC USES  ebx ecx eax edx
	dec ecx
	mov edx, OFFSET comma

	mov al, "{"
	call WriteCHar

L1:
	
	movzx eax, WORD PTR [ebx] ;ebx stores address, [] mean that we need content of the address, contents are smaller in bitr size than 32 bit so we extend them using "WORD PTR"
	add ebx, TYPE numbers
	call WriteDec
	;call WriteString  ; for some reason when printing 'totals' this loop doesnot print ", " string from EDX 
	mov al, ","
	call WriteChar
	mov al, " "
	call WriteChar
	loop L1

	mov eax, [ebx]
	add ebx, TYPE numbers
	call WriteDec

	mov al, "}"
	call WriteCHar



	ret
outputArray ENDP
;***********************************************************
 createRunningTotal PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi

	
L:
	;mov eax, 0							; this one works fine																	
	;movzx esi,  WORD PTR [ebx]		
	;add eax, esi
	;mov [edx], eax

	mov eax, 0
	 
	add eax, [ebx]						; this one takes the DWORD => causes issues when printing the array. the last number is wrong
	mov [edx], eax

	add ebx, TYPE numbers
	add edx, TYPE totals
	loop L

	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
 ret
 createRunningTotal ENDP


END main