INCLUDE Irvine32.inc

.data

prompt BYTE "Write a character: ", 0

char BYTE ?
rows BYTE ?
cols BYTE ?

.code
main PROC
	call Randomize					; this is for RandomRange 

	call GetMaxXY					; get the screen size
	mov rows,al
	mov cols,dl


				
	
	mov edx, OFFSET prompt
	call WriteString
	mov eax, 0
	call ReadChar					; store the chARACTER INTO a;
	mov char, al

	mov eax, 0						; clean regs
	mov ebx, 0
	mov eax, 255					; set upper bound
	mov ebx, 0						; set lower bound

	

	mov ecx, 512
L:
	push eax						; push eax to save the upper bound
	;call RandomLocation			; possible error here or in method
	;call Gotoxy					; locate cursor
	call BetterRandomRange			; returns eax, preserves only ebx
	call SetTextColor				; for SETTEXTCOLOR eax is resposible for the color of white on blue, ,white  (blue * 16) <- this can be replaced with a result of the expression
	mov al, char
	call WriteChar

	

	mov eax, 1						; set delay (it takes value in eax)
	call Delay
	pop eax
	loop L



	call DumpRegs
	


	    exit
main ENDP
;*******************************************************
BetterRandomRange PROC USES ebx
 ; RECIEVES: ebx => lower bound 
 ;		     eax => upper bound 
 ; RETURNS: eax
 ; PRINCIPLE OF OPERATION: 
 ; 1) first we get the range = upper -lower
 ; 2) then get a number within that range
 ; 3) add the lower bound to the result to get what we were looking for
;*******************************************************	
	dec ebx
	inc eax
	sub eax, ebx						; get the range = upper -lower
	call RandomRange					; get a number within that range
	add eax, ebx						; get what we were looking for



ret
BetterRandomRange ENDP
;***********************************************
RandomLocation PROC USES eax esi edx
;RECIEVES: eax
;RETURNS: nothing but sets dh and dl to a random number
;***********************************************
	call GetMaxXY						; get dimentions
	movzx eax,al
	movzx esi,dl

	call BetterRandomRange
	mov dh, BYTE PTR [eax] ; set row 

	mov eax, esi
	call BetterRandomRange
	mov dl,BYTE PTR [eax] ; set column 
	


ret
RandomLocation ENDP
END main