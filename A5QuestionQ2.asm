INCLUDE Irvine32.inc
		 ; Maxim Tyutyunin
		 ; Ass#7
		 ; Question Q2
		 ; Purpose: program uses the Sieve of Eratosthenes method to find all the prime numbers between 2 and 1000
 


.data
elements = 1000
primeNumbers WORD elements DUP(0)
validNumPositions BYTE elements DUP(1)					; initialize primes to true
.code
main PROC
	

	call sieveOfEratosthenes

;in this loop i campare the value at which an index points to 0,
;if its not 0 --> print the index(index = number)
;if its 0 --> skip the printing part and increment esi(index)
	mov eax, 0
	mov esi, 0
	mov ecx, LENGTHOF validNumPositions
L:
	cmp [validNumPositions + esi], 0
	je badNum
	mov eax, esi
	call WriteDec
	call CrLf
badNum:
	inc esi
	loop L


		

	 exit
main ENDP
;******************************************************
sieveOfEratosthenes PROC uses eax ebx esi
;Resieves: nothing
;Returns: nothing
;Int the method indexies are equal to numbers. it checks if the current
;index is prime and assigns a value of 0(false) 

;Sourses: Introduction to java programming from	cosc1046/1047
;		 https://stackoverflow.com/questions/5606895/integer-overflow-problem for lones 61 and 71
;		 Mike

;for (int k = 2; k <= n / k; k++) {									  
;            if (primes[k] == true) {
;                for (int i = k; i <= n / k; i++) {
;                    primes[k * i] = false; 
;                }
;            }
;        }
;EBX = K
;ESI = i
;EAX = n
;******************************************************	
	mov [validNumPositions], 0
	mov [validNumPositions+1], 0

	mov ebx, 2							; first assign 2 to k
	mov esi, 2							; first assign 2 to k
L1:
	mov edx, 0							; for (int k = 2; k <= n / k; k++) {
	mov eax, LENGTHOF validNumPositions
	div ebx
	cmp ebx, eax
	ja done

	cmp [validNumPositions + ebx], 1	; if (primes[k] == true) {
	jne incEBX
	
L2:										; for (int i = k; i <= n / k; i++) {
	mov edx, 0
	mov eax, LENGTHOF validNumPositions
	div ebx
	cmp esi, eax
	ja incEBX

								
	mov eax, ebx						; primes[k * i] = false; 
	mul esi
	mov [validNumPositions + eax], 0
	

	inc esi								; i++
	jmp L2


incEBX:	
	inc ebx								; k++
	mov esi, ebx						; ESI should be equal to EBX at the beginning of the next iteration
	jmp L1

done:
	ret
sieveOfEratosthenes ENDP
END main