TITLE   Fibonacci Version 1 - Using Register Parameters  (FibVer1.asm)
; This is a recursive version of Fibonacci
; using registers for parameter passing

INCLUDE Irvine32.inc

.data
prompt	BYTE	"Enter value n for fib(n): ", 0
msg1a	BYTE	"Calculating fib(", 0
msg1b	BYTE	") - please wait...", 0dh, 0ah, 0
msg2a	BYTE	"Fib(", 0
msg2b	BYTE	") = ", 0
		
n		DWORD	10

.code

main PROC
	mov	edx, OFFSET prompt
	call WriteString
	call ReadDec
	mov n, eax
    
	mov	edx, OFFSET msg1a
	call WriteString
	call WriteDec
	mov edx, OFFSET msg1b
	call WriteString

	mov eax, n
	call Fib

	mov edx, OFFSET msg2a
	call WriteString
	mov ebx, n
	xchg eax, ebx
	call WriteDec
	mov edx, OFFSET msg2b
	call WriteString
	xchg eax, ebx
	call WriteDec
	call Crlf

	exit
main ENDP

;****************************************************************
Fib PROC
; Receives: EAX is N
; Internally, ebx used to hold an interim(промежуточный) value 
; Returns: EAX is Fib(n-1)+Fib(n-2), Fib(0) = 0, Fib(1) = 1
;****************************************************************

	push ebp			; once ebp set its forever
	mov ebp, esp
	sub ebp, 4

	mov eax, [EBP + 8] ; error step g1 
	cmp eax, 1			; base case: n=0 or n=1, jmp to end and return n	
	jbe fibEnd			

	dec DWORD PTR [EBP + 8] 			; n-1
	push DWORD PTR [EBP + 8] 
	call Fib			; calculate Fib(n-1)

	mov DWORD PTR [EBP + 12], eax		;  wrong

	dec DWORD PTR [EBP + 8] 				; n-2
	push DWORD PTR [EBP + 8] ;step g4
	call Fib			; calculate Fib(n-2)

	add eax, DWORD PTR [EBP + 12]		; add Fib(n-1) to Fib(n-2)

fibEnd:
	mov ebp, esi; potential error  step e
	pop ebp
	ret	8; potential error step f				; return answer in eax
fib ENDP

END main