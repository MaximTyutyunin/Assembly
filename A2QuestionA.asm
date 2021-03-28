INCLUDE Irvine32.inc

;	      Maxim Tyutyunin
;		  Ass#4
;		  Question A
;		  Purpose: assembly program that uses a loop to calculate the first thirty values of a
;				   number sequence described by the formula: F(0) = 1, F(1) = 3, F(2) = 2, F(3) = 5, and then F(n) =
;				   F(n-1) + 2* Fib(n-4) for n >=4.
		

;int a = 1, b = 3, c = 2, d = 5;

;int current = d + 2 * a;                   ;current = F(4)

;for( int i = 4: i < n: ++I ) {
;
;		;at this point, current = F(i)
;		a = b;
;		b = c;
;		c = d;
;		d = current;
;		current = d + 2 * a;
;	}

.data
aInt WORD 1
bInt WORD 3
cInt WORD 2
dInt WORD 5

current WORD ?
string BYTE ", ", 0

.code
main PROC
	mov eax, 0					; clear the register

	mov ax, aInt				; print first four numbers
	call WriteDec
	mov al, ","					; for printing comma
	call WriteChar

	mov ax, bInt
	call WriteDec
	mov al, ","					
	call WriteChar

	mov ax, cInt
	call WriteDec
	mov al, ","					
	call WriteChar

	mov ax, dInt
	call WriteDec
	mov al, ","					
	call WriteChar

	mov eax, 0					; clear the register

	
	mov ax, aInt				; current = d + 2 * a;
	add ax, aInt				; 
	add ax, dInt				; 
	mov current , ax			; save value to "current"
	
	call WriteDec				; print current when it is calculated for the first time
	mov al, ","					; for comma
	call WriteChar
	
	
	mov ecx, 24					; set the loop counter to 24 dont know yet how to avoid writing a comma at the end in a more beautiful way
	L:							;for( int i = : i < ;++I)
		mov ax, bInt
		mov aInt, ax			; a = b

		mov ax, cInt
		mov bInt, ax			; b = c

		mov ax, dInt
		mov cInt, ax			; c = d

		mov ax, current
		mov dInt, ax			; d = current

		mov eax, 0				; clear the register

		mov ax, aInt			; 
		add ax, aInt			; current = d + 2 * a;
		add ax, dInt			; 
		mov current, ax			; save value to "current"
		call WriteDec
		mov al, ","				
		call WriteChar

	loop L
		
		mov ax, bInt			; write the last number without comma
		mov aInt, ax			; a = b

		mov ax, cInt
		mov bInt, ax			; b = c

		mov ax, dInt
		mov cInt, ax			; c = d

		mov ax, current
		mov dInt, ax			; d = current

		mov eax, 0				; clear the register

		mov ax, aInt			; 
		add ax, aInt			; current = d + 2 * a;
		add ax, dInt			; 
		mov current, ax			; save value to "current"
		call WriteDec


	exit
main ENDP
END main