.data
    string:  .asciz "Max available argument is:"
    stringRecursive: .asciz "Max available argument is(recursive):"
    ln: .asciz "\n"
    boundary: .word 4294967295
.text
	lw s0, boundary
	li a7, 4
	la a0, string
	ecall
	jal findFactorial
	li a7, 1
	ecall
	li a7, 4
	la a0, ln
	ecall
	li a7, 4
	la a0, stringRecursive
	ecall
	li a1, 1
	li a2, 1
	jal findFactorialRecursive
	li a7, 1
	ecall
	li a7,10
	ecall
findFactorial:
	li t0, 1
	li t1, 1
	loop:
	divu t2, s0, t1
	bltu t2, t0, endLoop
	addi t1,t1, 1
	mul t0, t1, t0
	j loop
	endLoop:
	mv a0, t1
	ret
findFactorialRecursive:
	addi sp, sp, -12
	sw ra, 8(sp)
	sw a1, 4(sp) # last counted factorial
	sw a2, (sp) # last number
	addi a2, a2,1
	divu t0, s0, a1
	bltu t0, a2, end
	j cont
	end:
	addi a2, a2, -1
	add a0, zero, a2
	lw ra, 8(sp)
	addi sp, sp, 12
	ret
	cont:
	mul a1, a1, a2
	jal findFactorialRecursive
	lw a2, (sp)
	lw a1, 4(sp)
	lw ra, 8(sp)
	addi sp, sp, 12
	ret
