INCLUDE Irvine32.inc

.data

prompt BYTE "enter three signed word values F, G and H: ", 0
f SWORD ?
g SWORD ?
h SWORD ?
msg1 BYTE " 4G + (F - 1) * 2H = ", 0
msg2 BYTE " (10 + H) / (F - G) = ", 0
msg3 BYTE " (3G + 4H) / 6F = ", 0


.code
main PROC
;first
	 mov edx, OFFSET prompt
	 call WriteString
	 call ReadInt
	 mov f, ax
	 call ReadInt
	 mov g, ax	 
	 call ReadInt
	 mov h, ax

	 mov ax, 4	 
	 imul g							; g already knows what is inside so no need to move it  into a register
	 mov si, ax						; si = 4g

	 mov cx, f
	 sub cx, 1						; cx = f-1
		 
	 mov ax, 2	 
	 imul h							; g already knows what is inside so no need to move it  into a register
	 mov dx, ax						; dx = 2h
	 	
	 mov ax, dx
	 imul cx						; ax = (F – 1) * 2H PROBLEM
		
	 add ax, si						; 4G + (F – 1) * 2H 
	 movsx eax, ax

	 mov edx, OFFSET msg1
	 call WriteString
	 call WriteInt
	 call CrLf

;second
	mov si, h						; si  = 10+h
	add si, 10

	mov cx, f						; cx = f-g
	sub cx, g
	
	mov ax, si
	cwd								; convert word to doubleword immediatelly follows the mov line
	idiv cx
	movsx eax, ax

	mov edx, OFFSET msg2
	call WriteString
	call WriteInt
	call CrLf

;third
	mov ax, 3	 
	imul g							
	mov si, ax							; 3g = si
	 
	mov ax, 4	 
	imul h							
	add si, ax							; 4h = dx 

	mov ax, 6	 
	imul f							
	
	xchg ax, si

	cwd							
	idiv si
	movsx eax, ax

	mov edx, OFFSET msg3
	call WriteString
	call WriteInt
	call CrLf



	    exit
main ENDP
END main