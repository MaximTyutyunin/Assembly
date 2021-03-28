INCLUDE Irvine32.inc

.data


temp DWORD ?

.code
main PROC

	mov temp, 5
	fild temp								; st(0) = 5, st(1) = e^3
	call showFPUStack
	mov temp, 3
	fiadd temp	
	;mov temp, 12
	;fidiv temp	
	call showFPUStack

	    exit
main ENDP
END main