INCLUDE Irvine32.inc
comment * public class Results {
				static String str1 = “a + b = “; +
				static String str2 = “a - b = “;+ 
				static String prompt = “Enter an integer: “;+
				static int a, b;+

				public static void main(String[] args) {
						Scanner in = new Scanner(System.in);
						
						System.out.print(prompt);
						a = in.nextInt();
						System.out.print( prompt );
						b = in.nextInt();
						
						System.out.print(str1);
						System.out.println(a + b);
						System.out.print(str2);
						System.out.println(a - b);
					}
				}
		*
.data

prompt BYTE "Enter an integer: ", 0

msg1 BYTE "a + b = ", 0
msg2 BYTE "a - b = ", 0

a DWORD ?
b DWORD ?
;result DWORD ?


.code
main PROC

	mov edx, OFFSET prompt			;move offcet to edx
	call WriteString				;write prompt
	call ReadInt					;read userinput
	mov  a, eax						;store copy of num1 in "a"

	mov edx, OFFSET prompt			;move offcet to edx
	call WriteString				;write prompt
	call ReadInt					;read userinput
	mov  b, eax						;store copy of num2 in "b"

	add eax, a
	mov edx, OFFSET msg1			;move offcet to edx
	call WriteString				;write prompt
	call WriteInt

	call CrLf						;new empty line

	mov eax, a 
	sub eax, b
	mov edx, OFFSET msg2			;move offcet to edx
	call WriteString				;write prompt
	call WriteInt


	exit
main ENDP
END main