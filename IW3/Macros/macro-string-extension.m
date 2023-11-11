.macro vowelsAndConsonants(%str)
	la a0, %str
	jal count_vowels
.end_macro
