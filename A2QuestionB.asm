INCLUDE Irvine32.inc
;	      Maxim Tyutyunin
;		  Ass#4
;		  Question B
;		  Purpose: programm populates the array with numbers and prints them
.data

arrayW WORD 20 DUP(0)
string BYTE ", ",0

.code
main PROC

	mov eax ,0								; clear eax, ebx because i dont trust them
	mov ebx ,0
	mov edx, OFFSET string					; writeString uses edx  to print ", "
	mov ecx, LENGTHOF arrayW - 1			; set counter to array size -1 to not to write the extra comma

	L:										; for(int i = array.lenth; i <=0; i--)
		inc ebx
		add eax, ebx
		call WriteDec						; sout(eax + ebx)
		call WriteString					;sout(string)
	loop L

		inc ebx								; maybe another way exists to get rid of the last extracomma but i dont know it yet
		add eax, ebx
		call WriteDec


	exit
main ENDP
END main