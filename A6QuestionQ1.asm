INCLUDE Irvine32.inc
; Maxim Tyutyunin
; Ass#8
; Question Q1
; the progrm gives a user ability to select an option and apply it on the array of predifined values 
; only exit and print work 

PrintArray PROTO,
	ptrArray:PTR DWORD, 
	szArray:DWORD 
.data

array SDWORD 10 DUP(-100)

p1 BYTE " 1 --> Populate the array with random numbers", 0dh,0ah
   BYTE " 2 --> Shift the array value bits a specified number of positions", 0dh,0ah
   BYTE " 3 --> Multiply the array with a user provided multiplier", 0dh,0ah
   BYTE " 4 --> Print the array", 0dh,0ah
p0 BYTE " Exit", 0
invalidInput BYTE " Your number is Invalid :(", 0
userInput BYTE " Your option is --> ", 0
.code
main PROC

;messages
	mov edx, OFFSET p1
	call WriteString
	call CrLf
L:
	mov edx, OFFSET userInput
	call WriteString
	
; select options
	call ReadInt
	cmp eax, 0
	je Exitt
	cmp eax, 1
	je Populate
	cmp eax, 2
	je Shift
	cmp eax, 3
	je Multiply
	cmp eax, 4
	je Print							
	ja Invalid
	loop L

; methods
Populate:
	mov eax, OFFSET array
	push eax
	mov eax, LENGTHOF array
	push eax
	call populateRandomNum
	call CrLf
	jmp L
Shift:
	call Shift
	call CrLf
	jmp L
Multiply:
	call Multiply
	call CrLf
	jmp L
Print:
	invoke PrintArray, ADDR array, LENGTHOF array
	call CrLf
	jmp L

Invalid:
	mov edx, OFFSET invalidInput
	call WriteString
Exitt:
	mov edx, OFFSET p0
	call WriteString


	 exit
main ENDP
;**********************************************************
;PrintArray
;Recieves: ADDR array, LENGTHOF array
;Returns: nothing
;Description: prints the array
;**********************************************************
PrintArray PROC USES esi ecx,
	ptrArray: PTR DWORD, ; points to the array
	szArray: DWORD ; array size

	mov edx, ptrArray
	mov ecx, szArray
L:	
	mov eax, [edx]							; i want to understand other eays of printing the array tho
	call WriteInt
	add edx, TYPE array
	loop L

	ret
PrintArray ENDP
;*******************************************************
populateRandomNum PROC USES eax ebx
; RECIEVES: ebx => offset 
;		    eax => length
; RETURNS: eax
; PRINCIPLE OF OPERATION: 
; 1) first we get the range = upper -lower
; 2) then get a number within that range
; 3) add the lower bound to the result to get what we were looking for
; 4) passes the number to a sertain position in the array
;*******************************************************
	
	push ebx							; set the base pointer 
	mov ebx, esp
	sub esp, 4							; give memory space to locals (1 Dword)

	mov esi, [ebp + 12]					; offset
	mov ecx, [ebp + 8]					; length
	mov eax, 300000						; upper bound
	mov ebx, -100000					; lower bound (might not be signed after moving to ebx)

L:
	push eax
	push ebx
	dec ebx
	dec ebx
	inc eax
	sub eax, ebx						; get the range = upper -lower
	call RandomRange					; get a number within that range in eax
	add eax, ebx						; get what we were looking for
	
	mov [esi], eax						; move random num into the array
	add esi, TYPE array
	pop ebx
	pop eax
	loop L

	mov esp, ebp
	pop ebp
	ret 12
populateRandomNum ENDP
END main
