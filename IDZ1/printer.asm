.global printArray
.include "macros.inc"

.data
printMessage: .asciz "Result array:"
ln:     .asciz "\n"
space: .asciz " "
.text
printArray:
	print_str(printMessage)
	print_str(ln)
	pop(t0) # get array size from stack
	pop(t1) # get array pointer from stack
	push(ra) # store returning adress to stack
	beqz t0, noPrint
	printLoop:
	li a7, 1
	lw a0, (t1) # get value from array
	ecall
	addi t1,t1,4
	sub, t0,t0,s2
	print_str(space)
	bgtz t0, printLoop
	print_str(ln)
	pop(ra) # get returning adress from stack
	ret
	noPrint:
	print_str(ln)
	pop(ra)
	ret
