INCLUDE Irvine32.inc
;	      Maxim Tyutyunin
;		  Ass#9
;		  Question Q1
;		  Purpose: calculate the total surface area, the volume, and the mid-sphere radius of the icosahedron.

calcVolume PROTO,
	edge: REAL4
.data
prompt BYTE " Edge length here plesss --> ", 0
error BYTE " (/o^o)/ NEGATIVES WON'T BE ACCAPTED", 0
msgDone BYTE " (/*''*)/ WE ARE DONE MY LORD", 0
msgArea BYTE " Area --> ", 0
msgVolume BYTE " Volume --> ", 0
msgMidsphereRadius BYTE " MidsphereRadius --> ", 0
edge REAL4 ?

area REAL4 ?
volume REAL4 ?
midsphereRadius REAL4 ?


.code
main PROC
	FINIT									; restore FPU stack settings
again:

badNum:
	mov edx, oFFSET prompt
	call WriteString
	call ReadFloat							; automatically push input on the FPU stack in st(0)
	fldz									; store zero in st(0), move user to st(1)
	fcomip	st(0), st(1)					; compare( automatically store flags in ax and EFLAGS)and remove value at st(0)
	je done
	jb next									; if 0 < userInput => all good, else clean stack and repeat

	ffree st(0)
	mov edx, oFFSET ERROR
	call WriteString
	call CrLf
	jmp badNum
next:
	fstp edge

;area
	push edge
	call calcArea
	mov edx, OFFSET msgArea
	call WriteString
	call WriteFloat
	fstp area
	call CrLf

;volume
	invoke calcVolume, edge
	mov edx, OFFSET msgVolume
	call WriteString
	call WriteFloat
	fstp volume
	call CrLf

;midsphereRadius
	push edge
	call calcMidsphereRadius
	mov edx, OFFSET msgMidsphereRadius
	call WriteString
	call WriteFloat
	fstp midsphereRadius
	call CrLf

	call showFPUStack
	call CrLf
	jmp again

done:
	mov edx, oFFSET msgDone
	call WriteString
	exit
main ENDP
five EQU <DWORD PTR [ebp-4]>
three EQU <DWORD PTR [ebp-8]>
calcArea PROC
;******************************************************
;Recieves: edge Real4
;Returns: st(0) = 5*3^0.5*e^2
;Description: push numbers on the FPU stack and calculate them one by one 
;******************************************************
	push ebp
	mov ebp, esp
	sub esp, 8
	mov DWORD PTR [ebp-4], 5
	mov DWORD PTR [ebp-8], 3

	fld REAL4 PTR [ebp + 8]					; st(0) = edge
	fld REAL4 PTR [ebp + 8]					; st(0) = edge, st(1) = edge
	fmul									; st(0) = edge^2

	fimul five
	fild three
	fsqrt									; st(0) = 3^0.5, st(1) = 5e^2
	fmul

	mov esp, ebp
	pop ebp
	ret 8
calcArea ENDP
calcVolume PROC,
	e: REAL4
	LOCAL temp: DWORD						; so it seems that i can have only one local variable of a sertain type
;******************************************************
;Recieves: edge Real4
;Returns: st(0) = 5/12 *(3 + 5^0.5) ? e^3
;Description: push numbers on the FPU stack and calculate them one by one 
;******************************************************
	fld e
	fld e
	fld e
	fmul
	fmul									; st(0) = e^3
	
	mov temp, 5
	fild temp								; st(0) = 5, st(1) = e^3
	mov temp, 12
	fidiv temp								; st(0) = 5/12, st(1) = e^3
	fmul									; st(0) = (5/12)* e^3

	mov temp, 5
	fild temp	
	fsqrt									; st(0) = 5^0.5 , st(1) = (5/12)* e^3

	mov temp, 3
	fiadd temp								; st(0) = 5^0.5 + 3, st(1) = (5/12)* e^3

	fmul									; st(0) = 5^0.5 + 3 * (5/12)* e^3

	ret
calcVolume ENDP

e EQU <REAL4 PTR [ebp + 8]	>
five EQU <DWORD PTR [ebp-4]>
four EQU <DWORD PTR [ebp-8]>
one EQU <DWORD PTR [ebp-12]>
calcMidsphereRadius PROC
;******************************************************
;Recieves: edge Real4
;Returns: st(0) = (e*(1+5^0.5))/4
;Description: push numbers on the FPU stack and calculate them one by one 
;*********************************************
	push ebp 
	mov ebp, esp
	sub esp, 12

	mov five, 5
	mov four, 4
	mov one, 1
	fld e									; st(0) = e

	fild five								; st(0) = 5; st(1) = e
	fsqrt									; st(0) = 5^0.5; st(1) = e

	fiadd one								; st(0) = (5^0.5) + 1; st(1) = e

	fmul

	fidiv four

	mov esp, ebp
	pop ebp
	ret 12
calcMidsphereRadius ENDP
END main