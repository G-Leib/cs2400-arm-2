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
check_lsb
		TST		r1, #1		;check if least significant bit is 1
		Beq		adder		;if least significant bit is 1, branch to adder
increment
		ASRs		r1, r1, #1	;use arithmetic right shift instead of left to maintain negative number
		LSL		r2, r2, #1
		CMP		r1, #0
		Bne		check_lsb
		ADR		r1, result
		ADR		r2, carry
		STR		r0, [r1]		;store result in "result" fill of memory
		MOV		r1, #0		;set r1 to 0
		ADC		r1, r1, #0	;sets r1 to 1 if carry is flagged
		STR		r1, [r2]		;store carry bit in "carry" fill of memory
		END
adder
		ADDs		r0, r0, r2	;add shifted amount to sum set carry bit
		B		increment
		
		
		
		
		
