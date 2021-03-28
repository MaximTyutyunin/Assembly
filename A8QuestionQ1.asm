INCLUDE Irvine32.inc
;	      Maxim Tyutyunin
;		  Ass#10
;		  Question Q1
;		  Purpose: This function will return in the target string a new string representing the characters from the first
;				   character of the source string to the index to the first character to be removed (but not including this
;				   character – and then continuing from the character represented by the end index to the last character
;				   of the source stringnt.
Str_remove PROTO,
	sours: PTR BYTE,
	targ: PTR BYTE,
	indexF: DWORD,
	indexL: DWORD

.data
numOfChars = 100
prompt BYTE " Enter first and last indexes --> ", 0
source BYTE "The quick brown fox jumped over the lazy dog.", 0
target BYTE numOfChars DUP (?), 0
indexFirst DWORD ?
indexLast DWORD ?

.code
main PROC
	
	call ReadInt
	mov indexFirst, eax 
	call ReadInt
	mov indexLast, eax

	INVOKE Str_remove, ADDR source, ADDR target, indexFirst, indexLast
																	
	mov edx, OFFSET target 
	call WriteString														


	    exit
main ENDP
Str_remove PROC uses ecx,
	sours: PTR BYTE,
	targ: PTR BYTE,
	indexF: DWORD,
	indexL: DWORD
	

	mov eax, indexF
	cmp eax, indexL
	jg badInp1										;If the end index is less than or equal to the first index --> return original string
	cmp eax, LENGTHOF source
	jg badInp1										;If the first index is greater than the source length --> return original string
	mov eax, indexL
	cmp eax, LENGTHOF source
	jg	badInp2										;If the end index is greater than the string length	--> indexF = LENGTHOF source 				


	mov esi, sours														
	mov edi, targ
	mov ecx, indexF									;clone the part of the string that comes before the "indexF"
	rep movsb

	mov esi, sours									; move the rest of the string after the "indexL"									
	mov edi, targ	
	mov ecx, LENGTHOF source
	add esi, indexL									;
	add edi,indexF									;	
	rep movsb
	jmp done


badInp1:
	mov ecx, LENGTHOF source 
	mov esi, sours
	mov edi, targ 
	rep movsd
	jmp done

badInp2:
	mov esi, sours														
	mov edi, targ
	mov ecx, indexF									;clone the part of the string that comes before the "indexF"
	rep movsb
done:

	ret
Str_remove ENDP
END main