INCLUDE Irvine32.inc

.data

varA dword 4
varB dword 4
varC dword 4

.code
main PROC
  PUSH varC         ; varA, varB, var C
  PUSH varB         ; are REAL4 values
  PUSH varA
  call calculate
  call WriteFloat
  call showFPUStack

	    exit
main ENDP
calculate    PROC
push ebp
mov ebp, esp
sub esp,4



mov dword ptr [ebp-4], 6                 ;temp
fld real4 ptr [ebp+12]
fimul real4 ptr [ebp-4]        ;6b

mov  dword ptr [ebp-4], 4
fisub real4 ptr [ebp-4]      ;6b-4

fsqrt                                 ;(6b-4)^0.5

fld real4 ptr [ebp+8]        ; st(0) = a
fimul real4 ptr [ebp-4]     ;st(0) = 4a
fadd                                 ;4a + (6b-4)^0.5

fidiv real4 ptr [ebp+16]   ; st(0) = (4a + (6b-4)^0.5)/c



mov esp, ebp
pop esp
ret
calculate    ENDP
END main