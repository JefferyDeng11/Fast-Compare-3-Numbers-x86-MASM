; MASMTest.asm a test bench for MASM Code

.386
.MODEL FLAT, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	;DATA VARIABLES GO HERE

	;QUESTION 1 VARIABLES
	num1	db	5;
	num2	db	8;
	num3	db	2;

	;VARIABLES ARE UNINITIALIZED
	min		db	?;
	max		db	?;

	;DATA VARIABLES GO HERE
.code
main proc
	;MAIN CODE HERE

	;CLEARING REGISTERS
	XOR		EAX, EAX
	XOR		EBX, EBX

	MOV		AL, [num1]			;AL CONTAINS NUM1 WHICH IS CURRENT MAX
	CMP		AL, [num2]			;COMPARE NUM1 WITH NUM2
	JB		less2				;NUM1 IS LESS THAN NUM2

	;NUM1 >= NUM2
	MOV		BL, [num2]
	MOV		min, BL				;BECAUSE NUM2 <= NUM1, IT IS CURRENT MIN
	CMP		AL, [num3]			;COMPARE NUM1 WITH NUM3
	JMP		solve				;NUM IS LESS THAN NUM3, NUM2 < NUM1 < NUM3

	;NUM1 >= NUM3		
	MOV		max, AL				;MAX = NUM1
	MOV		AL, [num3]			;MIN = NUM2, AL = NUM3
	JMP		compareMin			;COMPARE NUM2 AND NUM3

	less2:
		MOV		min, AL			;NUM1 WAS LESS THAN NUM2
		MOV		AL, [num2]		;AL NOW CONTAINS NUM2
		CMP		AL, [num3]		;COMPARE NUM2 WITH NUM3
		JB		SOLVE			;NUM2 IS LESS THAN NUM3, NUM1 < NUM2 < NUM3

		;NUM2 >= NUM3			 MIN = NUM1
		MOV		max, AL			;MAX = NUM2
		MOV		AL, [num3]		;AL  = NUM3
		JMP		compareMin		;COMPARE NUM1 WITH NUM3

	compareMin:
		CMP		[min], AL
		JA		swap
		jmp		exit

	swap:
		MOV		min, AL
		jmp		exit

	solve:
		MOV		BL, [num3]
		MOV		max, BL

	exit:

	;MAIN CODE ENDS HERE
	INVOKE ExitProcess, 0
main ENDP
END main
