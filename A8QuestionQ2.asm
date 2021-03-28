INCLUDE Irvine32.inc
;	      Maxim Tyutyunin
;		  Ass#10
;		  Question Q2
;		  Purpose: create and resise a matrix

SumColumnOfArray PROTO,
	pArr: PTR DWORD,
	rows: DWORD,
	cols: DWORD,
	target: DWORD
.data
 NUM_ROWS  = 5
 NUM_COLS = 8
 array SWORD  NUM_ROWS*NUM_COLS DUP (0)
 prompt1 BYTE " Enter number of rows and columns --> ", 0 
 prompt2 BYTE " Enter the target column index --> ", 0 
 error BYTE " Enter the valid target column index (-^-) ", 0 
 targetInd DWORD ?
 array1 SWORD 1,2,3,4,5,6
		SWORD 1,2,-3,4,5,6
		SWORD 1,2,3,4,5,6
.code
main PROC
	call Randomize



	call PopulateArray

	push OFFSET array
	push NUM_ROWS
	push NUM_COLS
	call PrintArray

badNum:													; check if the index is valid and ask again if not
	call CrLf
	mov edx, OFFSET prompt2
	call WriteString
	call ReadInt
	cmp eax, 0											; if input < 0 --> try again
	jl badNum
	cmp eax, NUM_COLS
	jg badNum											; if input > num_cols --> try again
	mov targetInd, eax

	INVOKE SumColumnOfArray, ADDR array, NUM_ROWS, NUM_COLS, targetInd
	;INVOKE SumColumnOfArray, ADDR array1, 3, 6, targetInd
	call WriteInt

	    exit
main ENDP


PopulateArray PROC
; Recieves: esi = offset, edi = number of columns, ecx = number of rows
; Returns: nothing
	ENTER 0,0

	mov esi, 0
	mov edi, 0

	mov ecx, NUM_ROWS
outL:
	push ecx
	mov ecx, NUM_COLS
inL:
	mov eax, 125 - (-125) + 1
	call RandomRange
	sub eax, 125
	mov array[esi+edi], ax
	add edi, TYPE array
	loop inL
	pop ecx
	loop outL


	LEAVE
	ret
PopulateArray ENDP
;-----------------------------------------------------------
PrintArray PROC
; Description: has two loops (outL to print rows and inL to print cols)
; Resieves:  NUM_ROWS, NUM_COLS, and the OFFSET of the array
; Returns: nothing
;-----------------------------------------------------------
.data
	comma BYTE ", ", 0
.code
	push ebp
	mov ebp, esp

	mov edx, OFFSET comma
	mov esi, [ebp + 16]							; offset
	mov edi, 0


	mov ecx , [ebp + 12]						; rows
outL:
	mov al, "|"
	call WriteChar

	push ecx
	mov ecx, [ebp + 8]							; cols
	dec ecx										; to not to print last comma
inL:
	movsx eax, WORD PTR [esi + edi] 
	call WriteInt
	call WriteString
	add edi, TYPE SWORD	
	loop inL

	movsx eax, WORD PTR [esi + edi]				; to print the last num
	call WriteInt
	mov al, "|"
	call WriteChar
	call CrLf
	pop ecx
	loop outL


	mov esp, ebp
	pop ebp
	ret
PrintArray ENDP

SumColumnOfArray PROC,
	pArr: PTR DWORD,
	rows: DWORD,
	cols: DWORD,
	target: DWORD
	LOCAL stepCol: dWORD,
		  stepRaw: dword
	mov eax, TYPE array
	mov ebx, target
	mul ebx
	mov stepCol, eax

	mov eax, TYPE array
	mov ebx, cols
	mul ebx
	mov stepRaw, eax

	;mov esi, OFFSET array1
	;add esi, 12
	;mov edi, 0
	;add edi, step
	;mov eax, 0
	;add ax, word ptr[esi + edi]
	
	mov esi, OFFSET array
	mov edi, stepCol
	mov eax, 0
	mov ecx, rows
L:	
	add ax, word ptr[esi + edi]
	add esi, stepRaw
	loop L

	ret
SumColumnOfArray ENDP
END main