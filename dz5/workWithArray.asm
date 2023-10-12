.global _fillArray
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
