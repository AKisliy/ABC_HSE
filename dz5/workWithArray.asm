.global _fillArray, _countSum
.include "macrolib.inc"

.text
_fillArray:
	push(ra) # store returning adress to stack
	mv t0, a1
	mv t1, a2
	loop: 
	userInputNum # userInputNum() -> (int num)
	sw a1, (t0) # put in array A
	addi t0, t0,4 
	sub t1, t1,s2
	bgtz t1, loop
	pop(ra) # get returning adress from stack
	ret

_countSum:
	push(ra)
	mv t0, a1
	mv t1, a2
	li t2, 0
	li t4, 0
	countLoop:
	lw t3, (t0)
	bltz t3, negativeOverFlow
	bgtz t3, positiveOverFlow
	negativeOverFlow:
		checkNegativeOverFlow(t3, t2)
		j continue
	positiveOverFlow:
		checkPositiveOverFlow(t3, t2)
	continue:
	bgtz a0, endWithOverFlow
	addi t4, t4,1
	add t2, t2, t3
	addi t0 t0 4
	blt t4, t1, countLoop
	j normalEnding
	endWithOverFlow:
	overFlowEnding(t4, t2)
	normalEnding:
	mv a0, t4
	mv a1, t2
	pop(ra)
	ret
