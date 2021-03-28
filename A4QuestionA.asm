INCLUDE Irvine32.inc
;	      Maxim Tyutyunin
;		  Ass#6
;		  Question A
;		  Purpose: count numbers of characters and numbers in a file
.data

prompt BYTE "Enter a file name: ",0
errorMsg BYTE "Small pipi file name ",0
fileHandle HANDLE ?
buffer	BYTE 100 DUP(?)
fileName BYTE 20 DUP(?)
characters WORD 26 DUP(?)
numbers WORD 10 DUP(?)
.code
main PROC

	mov edx, OFFSET prompt
	call WriteString

	mov edx, OFFSET fileName				;userINput = fileNmae
	mov ecx, SIZEOF fileNAme
	call ReadString

	call OpenInputFile						;						
	mov fileHandle, eax	

;Error check 
	cmp eax, INVALID_HANDLE_VALUE			; if(eax == ivalid){
	jne goodFile							; read from file loop
	mov edx, OFFSET errorMsg				; else{ sout(errorMessage; end the program}
	call WriteString
	jmp done

goodFile:
	call readInBuff
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	mov eax, fileHandle
	call ReadFromFile

	 mov eax,OFFSET buffer   
     call WriteBin

done:
    exit
main ENDP
;**********************************************************************
readInBuff PROC USES edx eax ecx 
; The method uses loop to proces the characters and reads into the buffer and count each letter and number;.
; Receives: edx, eax, ecx 
; Returns: ntihing
;**********************************************************************

	mov ecx, SIZEOF fileName 
	mov edx, OFFSET buffer
	mov eax, fileHandle
L1:										; rewrite the buffer to go through the file
	push ecx							; save the number of iterations
	mov ecx, SIZEOF buffer
	call ReadFromFile

L2:
	loop L2								; count characters and numbers
	pop ecx
	add ecx, LENGTHOF buffer			; increment ecx by 100
	loop L1
	ret
readInBuff ENDP
;**********************************************************************
dig PROC
;
; Determines whether the character in AL is a valid upper case char.
; Receives: AL = character
; Returns: ZF = 1 if AL contains a valid decimal digit; otherwise, ZF = 0.
;**********************************************************************
	cmp al,'A'
	jb ID1						; ZF = 0 when jump taken
	cmp al,'Z'
	ja ID1						; ZF = 0 when jump taken
	test ax,0					; set ZF = 1
ID1: 
	ret
dig ENDP
END main