.include "macros.inc"
.data
askMessage: .asciz "Input array size(1-10):"
errorSizeMessage: .asciz "Wrong size!!! Try again!\n"
enterNum: .asciz "Please enter number:"
printMessage: .asciz "Result array:"
ln:     .asciz "\n"
space: .asciz " "
.align  2                    
arrA:  .space  40
arrAend:
arrB: .space 40
arrBend:
.text
main:
	li s2,1		# s2:s3 - array borders
	li s3, 10
	jal userInputSize # userInputSize() -> (int size in s1)
	push(s1) # put inputSize parametr on stack
	jal fillArray # call function fillArray(int Asize) -> ()
	push(s1)
	jal makeNewArray # makeNewArray(int size) ->(filling arrB) -> int BSize
	pop(s4) # s4 - B size
	# parametrs for printArray func - arr pointer and arr size
	la t1, arrB
	push(t1)
	push(s4)
	jal printArray # printArray(int* arr, int size) -> ()
	exit
fillArray:
	la t0, arrA # load arrA pointer to t0
	pop(t1) # load size to t1
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
userInputNum:
	push(ra) # store returning adress to stack
	print_str(enterNum)
	li a7,5
	ecall
	pop(ra) # get returning adress from stack
	push(a0) # store returning value
	ret
userInputSize:
	push(ra) # store returning adress to stack
	inputLoop:
	print_str(askMessage)
	li a7, 5
	ecall
	blt a0,s2, tryAgain
	bgt a0, s3, tryAgain
	j endInputLoop
	tryAgain:
	print_str(errorSizeMessage)
	j inputLoop
	endInputLoop:
	mv s1, a0
	pop(ra) # get returning adress from stack
	ret
makeNewArray:
	pop(t0) # put size argument in t0
	li t1, 2 # variable for checking parity
	push(ra) # # store returning adress to stack
	push(t1) # store parity checker on stack
	la t1, arrB # B pointer
	la t2, arrA # A pointer
	loopA:
	lw t3, (t2) # load element from A
	pop(t4) # load 2 for parity checking
	rem t6, t3, t4 # find remainder of t3 / 2
	push(t4) # store 2 back to stack
	beqz t6, skipAddition
	sw t3, (t1) # store element in arrB if it's odd
	addi t1,t1,4
	addi t5,t5,1 # B size
	skipAddition:
	addi t2,t2,4
	sub t0,t0, s2
	bgtz t0, loopA
	pop(zero) # pop parity checker
	pop(ra) # get returning adress from stack
	push(t5) # put B size on stack
	ret
printArray:
	print_str(printMessage)
	print_str(ln)
	pop(t0) # get array size from stack
	pop(t1) # get array pointer from stack
	push(ra) # store returning adress to stack
	printLoop:
	li a7, 1
	lw a0, (t1) # get value from array
	ecall
	addi t1,t1,4
	sub, t0,t0,s2
	print_str(space)
	bgtz t0, printLoop
	pop(ra) # get returning adress from stack
	ret
