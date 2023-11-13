.macro vowelsAndConsonants(%str)
	mv a0, %str
	jal count_vowels
.end_macro

.macro remove_extra_symbols(%str)
	push(a0)
	push(t0)
	push(t1)
	li t1, '\n'
	la a0, %str
	loop:
	lb t0, (a0)
	beq t0, t1, remove
	addi a0,a0,1
	j loop
	remove:
	li t0, '\0'
	sb t0, (a0)
	pop(t1)
	pop(t0)
	pop(a0)
.end_macro
