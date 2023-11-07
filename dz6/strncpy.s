.global strncpy

.include "macro-syscalls.m"
.include "macro-string.m"

.text
strncpy:
	push(ra)
	push(s0)
	push(s1)
	push(s2)
	push(s3)
	mv s2, a2 # count
	mv s0, a0 # destination
	mv s1, a1 # source
	strlen_register(s1)
	mv s3, a0 # source len
	loop:
	beqz s2, end
	beqz s3, end
	lb t2, (s1)
	sb t2, (s0)
	addi s0, s0, 1
	addi s1, s1, 1
	addi s2,s2, -1
	addi s3,s3, -1
	j loop
	end:
	li t2 '\0'
	sb t2, (s0)
	pop(s3)
	pop(s2)
	pop(s1)
	pop(s0)
	pop(ra)
	ret
