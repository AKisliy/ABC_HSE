.include "macrolib.inc"
.global autoTests
.data
startingMessage: .asciz "Auto tests:\n"
.align 3
# test cases
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
	printStr(startingMessage)
	la  s0, test1 
	la s1, testEnd
	loop:
	fld fs0, (s0)
	arctan(fs0) # find arctan of current test
	fmv.d fa1, fa0
	printArctan(fs0, fa1) # print arctan
	addi s0, s0,8 # move to the next test case
	beq s1, s0, end # if no more tests - end loop
	j loop
	end:
	pop(ra)
	ret
