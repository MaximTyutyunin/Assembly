INCLUDE Irvine32.inc

.data

letters BYTE 256 DUP(?)
index BYTE 256 DUP(?)
fileName BYTE 20 DUP(?)

prompt BYTE "Enter The name of file: ", 0 

fileHandle DWORD ?

msgLength BYTE ?								; number of bytes to read
buff1	BYTE 100 DUP(?)


.code
main PROC

	mov edx, OFFSET prompt
	call WriteString

	mov edx, OFFSET fileName					; point to userInput(fileName) address (for read string)
	mov ecx, SIZEOF fileName					; specify max characters (for read string) can use (LengthOf-1) also
	call ReadString								; save input in addres that is stored in edx, the method accepts only a string not an actual memory location

	
	call OpenInputFile							; OpenInputFile saves file handle into eax, links the actul file and the "fileName"
	mov fileHandle, eax	

	mov edx, OFFSET msgLength					;eax for filehandle, edx for location, ecx for how many bytes should the fuction read
	mov ecx, 1
	call ReadFromFile

	mov eax, 0
	mov al, msgLength
	call WriteDec

	mov edx, OFFSET letters
	mov ecx, msgLength
	mov eax, fileHandle
	call ReadFromFile

	mov edx. OFFSET index
	mov ecx, msgLength
	inc ecx
	call ReadFromFile

	mov edx, OFFSET letters
	mov ecx, SIZEOF msgLength
	mov eax, fileHandle
	call ReadFromFile

	mov	eax, fileHandle							; close file
	call CloseFile

	call DumpRegs
	Call WriteWindowsMsg


	exit
main ENDP
END main