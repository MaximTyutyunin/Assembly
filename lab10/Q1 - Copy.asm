INCLUDE Irvine32.inc

.data

NUM_ROWS = 7
NUM_COLS = 5
array SBYTE NUM_ROWS*NUM_COLS DUP(?)

.code
main PROC
;public void popRandom(int[][] array, int numRows, int numColumns) {
;for(int i = 0; i < numRows; i++){
;	for(int j = 0; j < numColumns; j++){
;		array[i][j] = -50 + (int)(Math.random() * (100 – (-50) + 1));
;		}
;	}
;}

;public void totalRows(int[][] array, int numRows, int numColumns) {
;for(int i = 0; i < numRows; i++){
;	int total = 0;
;		for(int j = 0; j < numColumns; j++){
;			System.out.print(array[i][j]);
;			if(j < numColumns-1) System.out.print(“ + “);
;		}
;	System.out.println(“ = “ + total);
;	}
;}
	
	call Randomize
	
	push NUM_ROWS
	push NUM_COLS
	push OFFSET array
	call popRandomArray

	push NUM_ROWS
	push NUM_COLS
	push OFFSET array
	call totalRows

	    exit
main ENDP

rows EQU <DWORD PTR [ebp+16]>
columns EQU <DWORD PTR [ebp+12]>
offs EQU <DWORD PTR [ebp+8]>
popRandomArray PROC
	push ebp
	mov ebp, esp

	mov esi, offs
	mov edi, 0 
	mov ecx, rows

outL:
	push ecx
	mov ecx, columns
innerL:
	mov eax, 100 - (-50) + 1
	call RandomRange
	sub eax, 50

	mov [esi + edi],  eax			;array is a byte so i dont think we use eax here, i at least want to show the logik
	add edi, TYPE array
	loop innerL

	pop ecx
	loop outL

	mov esp, ebp
	pop ebp
	ret
popRandomArray ENDP

total EQU <DWORD PTR [ebp-4]>
totalRows PROC
	push ebp
	mov ebp, esp
	sub esp, 4

	mov esi, offs
	mov edi, 0 
	
	mov ecx, rows
outL:
	push ecx
	mov total, 0
	mov ecx, columns
	
innerL:
	movsx eax, SBYTE PTR [esi + edi]
	add total, eax		
	add edi, TYPE array
	
	cmp ecx, 1
	jle done

	push eax
	movsx eax, SBYTE PTR[esi + edi]
	call WriteInt
	pop eax
	push eax
	mov al, "+"					
	call WriteChar
	pop eax

	loop innerL

done:
	push eax
	mov al, "="					
	call WriteChar
	call CrLf
	pop eax

	mov eax, total
	call WriteInt
	pop ecx
	loop outL


	mov esp, ebp
	pop ebp
	ret
totalRows ENDP
END main