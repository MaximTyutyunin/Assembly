INCLUDE Irvine32.inc
;	      Maxim Tyutyunin
;		  Ass#5
;		  Question B
;		  Purpose: generate a random number from the lower number to the upper number inclusive.
;		  The questions are repeated 5 times before stopping
.data

msg BYTE "Enter the lower and the upper bounds: ",0




.code
main PROC
	call Randomize

	mov ecx, 5
	
L:
	mov edx, OFFSET msg
	call WriteString
	call ReadInt
	mov ebx, eax						;store the lower bound in ebx
	call ReadInt						;store the upper bound in eax

	call BetterRandomRange
	call CrLf
	loop L


	call DumpRegs


	    exit
main ENDP
;*******************************************************
BetterRandomRange PROC USES eax ebx
; RECIEVES: ebx => lower bound 
;		    eax => upper bound 
; RETURNS: eax
; PRINCIPLE OF OPERATION: 
; 1) first we get the range = upper -lower
; 2) then get a number within that range
; 3) add the lower bound to the result to get what we were looking for
;*******************************************************	
	dec ebx
	dec ebx
	inc eax
	sub eax, ebx						; get the range = upper -lower
	call RandomRange					; get a number within that range in eax
	add eax, ebx						; get what we were looking for
	call WriteInt


	ret
BetterRandomRange ENDP
END main