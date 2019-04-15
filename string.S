		;		ARM Programming Assignment #2: Writing C-strings
		;
		;		Write a program that assembles the values in chars*
		;		into a C-style string. A C-style string is an array
		;		of byte-size characters, terminated by a NULL (0x0).
		;		Write the C-string to the FILL memory at 'string'.
		;		Note: It's up to you to declare the correct number
		;		of bytes to hold the result.
		
		;		Your code here
		
chars0	DCD		'T', 'h', 'e', ' ', '2', '0', '1', '8', ' ', 'T', 'u'
chars1	DCD		'r', 'i', 'n', 'g', ' ', 'A', 'w', 'a', 'r', 'd', ' '
chars2	DCD		'w', 'a', 's', ' ', 'a', 'w', 'a', 'r', 'd', 'e', 'd'
chars3	DCD		' ', 't', 'o', ' ', 'B', 'e', 'n', 'g', 'i', 'o'
chars4	DCD		' ', 'H', 'i', 'n', 't', 'o', 'n', ' ', 'a', 'n'
chars5	DCD		'd', ' ', 'L', 'e', 'C', 'u', 'n', 'n', ' ', 'f', 'o'
chars6	DCD		'r', ' ', 't', 'h', 'e', 'i', 'r', ' ', 'w', 'o', 'r'
chars7	DCD		'k', ' ', 'o', 'n', ' ', 'n', 'e', 'u', 'r', 'a', 'l'
chars8	DCD		'n', 'e', 't', 'w', 'o', 'r', 'k', 's', '.'
count	DCD		95
string	FILL		100
		mov		r0, #0		;start character count at 0
		mov		r1, #0		;start word size count at 0
		adr		r2, chars0	;find first letter
		adr		r3, string	;find location to store string
		adr		r4, count		;find character count
		ldr		r4, [r4]		;load character count into r4
		mov		r5, #0		;initialize first word as 0
fill_word
		cmp		r0, r4		;check if all characters are loaded
		bge		end_word
		cmp		r1, #4		;check if word is full
		bge		new_word
		lsl		r5, r5, #8	;shift word left
		ldr		r6, [r2], #4	;load character byte into r6 and increment
		add		r5, r5, r6	;add byte
		add		r1, r1, #1	;increment word size count
		add		r0, r0, #1	;increment character count
		b		fill_word
new_word
		str		r5, [r3], #4	;store word in "string" location and increment
		mov		r1, #0		;reset word size count
		b		fill_word
end_word
		cmp		r1, #4		;check if word is full
		bge		exit
		lsl		r5, r5, #8	;shift left if word is not full
		add		r1, r1, #1	;increment word size count
		b		end_word
exit
		str		r5, [r3], #4	;add final word and increment
		mov		r5, #0		;move null into r5
		str		r5, [r3],	#4	;store null into final position
		end
		
		
		
		
