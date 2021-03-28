INCLUDE Irvine32.inc
;	      Maxim Tyutyunin
;		  Ass#9
;		  Question Q2
;		  Purpose: procedure that receives a single-precision floating-point binary value as a stack value and
;				   displays it in the following format: sign 1. significand x 2^exponent.
.data

prompt BYTE "Enter a float value, my lord!! --> ", 0
msg1 BYTE "Real number in binary: ", 0
num dWORD ?

.code
main PROC
	FINIT

	mov edx, OFFSET prompt
	call  WriteString
	call ReadFloat
	fstp num
	push num
	call convert

	call showfpustack

	    exit
main ENDP

realNum EQU <REAL4 PTR [ebp + 8]>
;**************************************************************
convert PROC
	mov ebp, esp
	sub esp, 4

	mov edx, OFFSET msg1
	call  WriteString

	mov eax, realNum
	shl eax, 1
	jc negative
	jmp positive
negative:
	mov al, "-"					
	call WriteChar
positive:
	

	call WriteBin
	mov esp, ebp
	pop ebp
	ret
convert ENDP
END main;resieves: num
;returns: nothing
;desc: i wanted to 1)shift left and get the sign in CF, then probably rotat and store exponent in al
; then rotate again and get the mantissa. i dont know if its the right way
;**************************************************************
	push ebp 
