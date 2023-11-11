.macro strcmp (%s1, %s2)
	la a0 %s1
	la a1 %s2
	jal strcmp
.end_macro

.macro strlen (%s1)
	la a0 %s1
	jal strlen
.end_macro

.macro strlen_register(%s1)
	mv a0 %s1
	jal strlen
.end_macro

.macro strnlen (%s1, %size)
	la a0 %s1
	li a1 %size
	jal strnlen
.end_macro

.macro strncpy(%dest, %src, %cnt)
	la a0, %dest
	la a1, %src
	mv a2, %cnt
	jal strncpy
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

.macro vowelsAndConsonants(%str)
	la a0, %str
	jal count_vowels
.end_macro
