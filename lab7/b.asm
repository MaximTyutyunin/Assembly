INCLUDE Irvine32.inc

.data

prompt BYTE "enter three signed word values F, G and H: ", 0
f DWORD ?
g DWORD ?
h DWORD ?
msg1 BYTE " 4G + (F - 1) * 2H = ", 0
msg2 BYTE " (10 + H) / (F - G) = ", 0
msg3 BYTE " (3G + 4H) / 6F = ", 0


.code
main PROC
;first
	 mov edx, OFFSET prompt
	 call WriteString
	 call ReadInt
	 mov f, eax
	 call ReadInt
	 mov g, eax	 
	 call ReadInt
	 mov h, eax

	 mov eax, 4	 
	 imul g							; g already knows what is inside so no need to move it  into a register
	 mov esi, eax						; esi = 4g

	 mov ecx, f
	 sub ecx, 1						; ecx = f-1
		 
	 mov eax, 2	 
	 imul h							; g already knows what is inside so no need to move it  into a register
	 mov edx, eax						; dx = 2h
	 	
	 mov eax, edx
	 imul ecx						; eax = (F – 1) * 2H PROBLEM
		
	 add eax, esi						; 4G + (F – 1) * 2H 
	 

	 mov edx, OFFSET msg1
	 call WriteString
	 call WriteInt
	 call CrLf

;second
	mov esi, h						; esi  = 10+h
	add esi, 10

	mov ecx, f						; ecx = f-g
	sub ecx, g
	
	mov eax, esi
	cdq								; convert word to doubleword immediatelly follows the mov line
	idiv ecx
	

	mov edx, OFFSET msg2
	call WriteString
	call WriteInt
	call CrLf

;third
	mov eax, 3	 
	imul g							
	mov esi, eax							; 3g = si
	 
	mov eax, 4	 
	imul h							
	add esi, eax							; 4h = dx 

	mov eax, 6	 
	imul f							
	
	xchg eax, esi

	cdq						
	idiv esi
	

	mov edx, OFFSET msg3
	call WriteString
	call WriteInt
	call CrLf



	    exit
main ENDP
END main