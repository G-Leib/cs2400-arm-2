		;		ARM Programming Assignment #2: 32 bit signed integer multiplier
		;
		;		Write a 32-bit SIGNED multiplier. It should take only a small modification to your
		;       unsigned version. Remember (-6)*(-6) = 36, (-6)*6 = -36.
		;		Use the standard shift-and-add operation.
		;		Use the two numbers as an example but write it so it works for any two 16-bit numbers.
		;		Write the result in the provided "fill" word.
		;		Indicate if there was a high-bit carry using the provided "fill" word.

		;		Your code here

numbers	DCD		0xA0BCFF0D, 0xFFF0ADEA
result	FILL		8
carry	FILL		4
		ADR		r6, numbers	;load address of numbers into r6
		LDMia	r6!, {r1, r2}	;load numbers to be multiplied (added) into r1 and r2
		MOV		r0, #0		;initialize product (sum) as 0
		MOV		r8, #0		;initialize sign as 0 (positive)
		MOV		r7, r1
		CMP		r1, #0
		BLlt		sign_track
		MOV		r1, r7
		MOV		r7, r2
		CMP		r2, #0
		BLlt		sign_track
		MOV		r2, r7
check_lsb
		TST		r1, #1		;check if least significant bit is 1
		Beq		adder		;if least significant bit is 1, branch to adder
increment
		LSR		r1, r1, #1
		LSL		r2, r2, #1
		CMP		r1, #0
		Bne		check_lsb
		ADR		r1, result
		ADR		r2, carry
		CMP		r8, #1		;check if the sign should be 1 (negative)
		RSBeq	r0, r0, #0	;subtract result by zero to make negative
		STR		r0, [r1]		;store result in "result" fill of memory
		MOV		r1, #0		;set r1 to 0
		ADC		r1, r1, #0	;sets r1 to 1 if carry is flagged
		STR		r1, [r2]		;store carry bit in "carry" fill of memory
		END
adder
		ADDs		r0, r0, r2	;add shifted amount to sum set carry bit
		B		increment
sign_track
		EOR		r8, r8, #8	;flip sign for each negative multiplicand
		RSB		r7, r7, #0	;subtract negative number from 0 to make positive
		MOV		pc, lr
		
		
		
		
