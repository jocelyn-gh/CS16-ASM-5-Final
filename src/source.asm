; Program Template (Template.asm)
; Program Description: Assignmet 5
; Author: Jocelyn
; Creation Date: 9/8/2015
; Revisions:
; Date:		Modified by:
;-----		------------
;9/8/2015	First revision


TITLE Assignmet 5

;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

;//////////////////////////////////////////////////////////////////////////////////////////;
;declare GLOBAL variables here
;//////////////////////////////////////////////////////////////////////////////////////////;

DECIMAL_OFFSET=5

;//////////////////////////////////////////////////////////////////////////////////////////;
.data ;declare variables here
;//////////////////////////////////////////////////////////////////////////////////////////;


decimal_one BYTE "100123456789765"
;decimal_one BYTE "012345678"

string_one BYTE "all your base are belong to us"


key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6


;//////////////////////////////////////////////////////////////////////////////////////////;
.code ;write your code here
;//////////////////////////////////////////////////////////////////////////////////////////;

main PROC 
_START:


CALL FUNCTION_ONE

	XOR EAX,EAX
	XOR ECX,ECX
	XOR EBX,EBX
	XOR EDX,EDX

;CALL WriteScaled


CALL Encryption


call DumpRegs; display the registers
exit
main ENDP


;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////;

FUNCTION_ONE PROC

	
	XOR EBX,EBX
	XOR EDX,EDX
	CALL Randomize 
	MOV EAX, 11
	CALL RandomRange
	MOV BX, AX
	XOR EAX,EAX

	
	MOV DX, BX
	SHL DX, 1
	ADD AX, DX
	XOR DX,DX
	;///
	MOV DX, BX
	SHL DX, 3
	ADD AX, DX
	XOR DX,DX
	;///
	MOV DX, BX
	SHL DL, 4
	ADD AL, DL
	XOR DX,DX


	RET

FUNCTION_ONE ENDP


WriteScaled PROC
	;MOV ECX, LENGTHOF decimal_one
	;mov ESI, OFFSET decimal_one

	;XOR ESI,ESI
	;SHR decimal_one[ESI+2],1 ; shift right 5 bits





	MOV ECX, LENGTHOF decimal_one
	MOV ESI, OFFSET decimal_one

	SHR ESI,5 ; shift right 5 bits


	WriteScaled_LOOP:
		MOV AL,  BYTE PTR [esi] ; Debuging
		INC ESI ; inc to the next part of the array

	LOOP WriteScaled_LOOP


	MOV DX, 0010011001101010b
	mov ax,dx ; make a copy of DX		; 0010011001101010
	shr ax,5 ; shift right 5 bits		; 0001001100000011
	and al,00001111b ; clear bits 4-7	; 0001000000000011
	;mov month,al ; save in month variable

	RET

WriteScaled ENDP

Encryption PROC

	mov EDI, OFFSET string_one
	mov ESI, OFFSET key

	L1:
	;{

		MOV CL, BYTE PTR [ESI] ; Load key in array
		MOV AL, BYTE PTR [EDI] ; Load char
	
		TEST AL, AL    ; End if end of string
			JZ EndLoop
		CMP CL, 0
			JS EShiftLeft

		EShiftRight:
			ROR AL , CL  ; rot CL right
		JMP Bottem1

		EShiftLeft:			
			neg cl
			ROL AL , CL ; rot CL left

		Bottem1:
			MOV BYTE PTR [EDI], AL
			INC ESI
			INC EDI


		JMP L1
	;}

	EndLoop:


	RET

Encryption ENDP
;//////////////////////////////////////////////////////////////////////////////////////////;
END main
;//////////////////////////////////////////////////////////////////////////////////////////;