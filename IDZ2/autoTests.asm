.include "macrolib.inc"
.global autoTests
.data
.align 3
test1: .double -1
test2: .double 1
test3: .double 0
test4: .double 0.5
test5: .double -0.23
test6: .double 0.99
testEnd:

.text
autoTests:
	push(ra)
	la  s0, test1
	la s1, testEnd
	loop:
	fld ft0, (s0)
	arctan(ft0)
	printArctanFrom(fa0)
	addi s0, s0,8
	beq s1, s0, end
	j loop
	end:
	pop(ra)
	ret
