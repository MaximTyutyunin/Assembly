INCLUDE Irvine32.inc

.data

msg1 BYTE "Enter the n value for func(n) or negative to terminate: ", 0
msg21 BYTE "func(" , 0 
msg22 BYTE " ) = ", 0
msg3 BYTE "Good bye!", 0
num DWORD 0

;do {
;System.out.print("Enter the n value "
;+ "for func(n) or negative to terminate: ");
;num = in.nextInt();
;int eax = 0; //answer for func(0)
;if(num == 1 ) {
;eax = 3; //answer for func(1)
;} else if(num == 2){
;eax = 2; //answer for func(2)
;} else if(num > 2){
;eax = func(num);
;System.out.println("func(" + num+ ") = " + eax);
;}
;} while(num >= 0);
;System.out.println("Good bye!");
;}
.code
main PROC
	
	
L:										; do{
;*****************************************
	call CrLf
	mov edx, OFFSET msg1				;System.out.print(msg1);
	call WriteString
	call ReadInt						;num = in.nextInt();
	mov num, eax

	mov eax, 0

	cmp num, 1							;else if(num == 1 ) {						
	jne ifst2
	mov eax, 3
	jmp whilee

ifst2:
	cmp num, 2							;else if(num == 2 ) {	
	jne ifst3
	mov eax, 2
	jmp whilee

ifst3:
	cmp num, 2							;else if(num > 2 ) {
	jg func1
	jmp whilee; fix most probably

func1: 

	
	mov edx, OFFSET msg21				;System.out.print(msg2);
	call WriteString
	mov eax, num 
	call WriteDec
	mov edx, OFFSET msg22				;System.out.print(msg2);
	call WriteString



	call func							; pass eax to function coz readint reads into eax
	call WriteInt
	jmp whilee
	
;******************************************
whilee:
	cmp num, 0							;}while(num >= 0);
	jge L

	mov edx, OFFSET msg3				;System.out.print(msg3);
	call WriteString



	 exit
main ENDP
func PROC 

;//func(n) = func(n-3) + func(n-1) for n > 2
;int ebx = 0; //func(n) = 0 for n = 0
;int edx = 3; //func(n) = 3 for n = 1
;int esi = 2; //func(n) = 2 for n = 2
;int edi = 2 *esi - ebx; //answer for func(3) initally


;//this loop calculates each step up to func(eax)
;for( int ecx = eax; ecx > 3; ecx-- ){
;ebx = edx;
;edx = esi;
;esi = edi;
;edi = 2 *esi - ebx;
;}
;eax = edi; //return answer in eax
;return eax;
;}
	mov ebx, 0							;int ebx = 0; //func(n) = 0 for n = 0
	mov edx, 3							;int edx = 3; //func(n) = 3 for n = 1
	mov esi, 2							;int esi = 2; //func(n) = 2 for n = 2
	mov edi, esi						;int edi = 2 *esi - ebx; //answer for func(3) initally
	add edi, esi
	sub edi, ebx

	mov ecx, eax

	cmp ecx, 3							;for( int ecx = eax; ecx > 3; ecx-- ){
	je done
L:
	mov ebx, edx
	mov edx, esi
	mov esi, edi

	mov edi, esi						;edi = 2 *esi - ebx; 
	add edi, esi
	sub edi, ebx

	cmp ecx, 3
	jg L

done:									
mov eax, edi
ret
func ENDP

END main