.include "macro-syscalls.m"
.include "macro-string.m"
.include "macro-char.m"


.global count_vowels

.text
count_vowels:
	push(ra)
	mv s1, a0 # input string
	li s2, 0 # count vowels
	li s3, 0 # count consonant
	loop:
		lb s4, (s1)
		beqz s4, end
		isVowel(s4)
		bgtz a0, addVowel
		isUpper(s4)
		bgtz a0, addConsonant
		isLower(s4)
		bgtz a0, addConsonant
		j nextIteration
		addVowel:
			addi s2, s2, 1
			j nextIteration
		addConsonant:
			addi s3, s3, 1
		nextIteration:
		addi s1, s1, 1
		j loop
	end:
	mv a0, s2
	mv a1, s3
	pop(ra)
	ret
		
