.global userInputNum, userInputSize, userInputType
.include "macros.inc"

.data
askMessage: .asciz "Input array size(1-10):"
wrongSizeMessage: .asciz "Wrong size!!! Try again!\n"
wrongTypeMessage: .asciz "Wrong type!! Try again:"
enterNum: .asciz "Please enter number:"
chooseProgramType: .asciz "Please, choose program type: 0 - normal mode, 1 - auto tests:"

.text
userInputNum:
	push(ra) # store returning adress to stack
	print_str(enterNum)
	read_int
	pop(ra) # get returning adress from stack
	push(a0) # store returning value
	ret
userInputSize:
	push(ra) # store returning adress to stack
	inputLoop:
	print_str(askMessage)
	read_int
	blt a0,s2, tryAgain
	bgt a0, s3, tryAgain
	j endInputLoop
	tryAgain:
	print_str(wrongSizeMessage)
	j inputLoop
	endInputLoop:
	mv a1, a0
	pop(ra) # get returning adress from stack
	ret
userInputType:
	push(ra)
	print_str(chooseProgramType)
	typeLoop:
	read_int
	bltz a0, tryAgainType
	bgt a0,s2,tryAgainType
	j endTypeLoop
	tryAgainType:
	print_str(wrongTypeMessage)
	j typeLoop
	endTypeLoop:
	pop(ra)
	push(a0)
	ret
