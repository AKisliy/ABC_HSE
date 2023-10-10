.global fillArray, makeNewArray
.include "macros.inc"

.text
fillArray:
	pop(t0) # load array pointer to t0
	pop(t1) # load array size to t1
	push(ra) # store returning adress to stack
	loop: 
	jal userInputNum # userInputNum() -> (int num)
	pop(t2) # get input num from stack
	sw t2, (t0) # put in array A
	addi t0, t0,4 
	sub t1, t1,s2
	bgtz t1, loop
	pop(ra) # get returning adress from stack
	ret
makeNewArray:
	pop(t2) # source array
	pop(t1) # destination array
	pop(t0) # put size argument in t0
	li t3, 2 # variable for checking parity
	push(ra) # # store returning adress to stack
	push(t3) # store parity checker on stack
	li t5,0 # t5 - destination array size
	loopA:
	lw t3, (t2) # load element from source
	pop(t4) # load 2 for parity checking
	rem t6, t3, t4 # find remainder of t3 / 2
	push(t4) # store 2 back to stack
	beqz t6, skipAddition
	putRegInArray(t1,t3)
	addi t5,t5,1
	skipAddition:
	addi t2,t2,4
	sub t0,t0, s2
	bgtz t0, loopA
	pop(zero) # pop parity checker
	pop(ra) # get returning adress from stack
	push(t5) # put destination size on stack
	ret
