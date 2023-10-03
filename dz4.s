.data
    string:  .asciz "Max available argument is:"
    stringRecursive: .asciz "Max available argument is(recursive):"
    ln: .asciz "\n"
    boundary: .word 4294967295 # max 32-bit word
.text
main:
	lw s0, boundary
	li a7, 4
	# console message
	la a0, string
	ecall
	
	jal findFactorial
	li a7, 1
	ecall
	
	li a7, 4
	la a0, ln
	ecall
	li a7, 4
	# console message
	la a0, stringRecursive
	ecall
	# arguments for recursive function
	# a1 - n!
	# a2 - n
	li a1, 1
	li a2, 1
	jal findFactorialRecursive
	li a7, 1
	ecall
	li a7,10
	ecall
findFactorial:
	li t0, 1 # t0 - (n -1)!
	li t1, 1 #t1 - n
	loop:
	divu t2, s0, t1 # here we find boundary / n
	bltu t2, t0, endLoop # if boundary / n < (n - 1)! we can't continue
	addi t1,t1, 1 # otherwise n = n + 1
	mul t0, t1, t0 # (n-1)! * n = n!
	j loop
	endLoop:
	mv a0, t1
	ret
findFactorialRecursive:
	addi sp, sp, -12
	sw ra, 8(sp) # return adress
	sw a1, 4(sp) # last counted factorial - n!
	sw a2, (sp) # last number - n
	addi a2, a2,1 # n = n + 1
	divu t0, s0, a1 # here we find boundary / n!
	bltu t0, a2, end # if boundary / n! <  n + 1 - we can't calculate (n + 1)!
	j cont # otherwise we make recursive call
	end: # so we return n(a2)
	addi a2, a2, -1 # result = a2 - 1 = n
	add a0, zero, a2 # a0 = result
	lw ra, 8(sp) # load ret adress
	addi sp, sp, 12
	ret
	cont: # make next recursive call
	mul a1, a1, a2 # (n+1)!
	jal findFactorialRecursive
	lw a2, (sp)  # restore a2
	lw a1, 4(sp) # restore a1
	lw ra, 8(sp) # restore ra
	addi sp, sp, 12
	ret
