.data
askMessage: .asciz "Input array size(1-10):"
errorSizeMessage: .asciz "Wrong size!!! Try again!\n"
enterNum: .asciz "Please enter number:"
resultCount: .asciz "Number of elements in sum:"
resultSum: .asciz "Sum:"
oddNum: .asciz "Number of odd elemnents in array: "
evenNum: .asciz "Number of even elements in array: "
overflowMessage: .asciz "Oops, it seems like we have an overflow. Here's the last info we could calculate:\n"
ln:     .asciz "\n"
.align  2                    
array:  .space  40
arrend:
.text
	li s2,1		# s2:s3 - array borders
	li s3, 10
	li s4, 2147483647  	# s4 - max sum
	li s5, -2147483648	# s5 - min sum
	jal userInputSize
        la  t0 array    # t0 - pointer
        mv t2,t1	#t1 - array size, t2 - temp counter
        fillLoop:
        jal userInputNum
        sw t3 (t0)  # t3 - user input num
        addi    t0 t0 4
        sub t2, t2, s2
        and t3, t3,s2
        beqz t3, addEven	
     	addi s6,s6,1 # s6 - number of odd elements
     	j continueLoop
     	addEven:
     		addi s7,s7, 1 # s7 - number of even elements
     	continueLoop:
        bgtz t2, fillLoop
        
        la t0, array
        # t2 - sum
        # t3 - current num from array
	# t4 - count
	# t5 - checking for error
	countLoop:
	lw t3, (t0)
	bltz t3, negativeOverFlow
	bgtz t3, positiveOverFlow
	negativeOverFlow:
		jal checkNegativeOverFlow
		j continue
	positiveOverFlow:
		jal checkPositiveOverFlow
	continue:
	addi t4, t4,1
	add t2, t2, t3
	addi t0 t0 4
	blt t4, t1, countLoop
	
	la a0, ln
        li a7,4
        ecall 
        
        la a0, resultCount
        li a7, 4
        ecall
        mv a0, t4
        li a7, 1
        ecall
        
        la a0, ln
        li a7,4
        ecall 
        
        la a0, resultSum
        li a7, 4
        ecall
        mv a0, t2
        li a7, 1
        ecall
        
        jal parityPrint
        
	li a7,10
	ecall
userInputNum:
	la a0, enterNum
	li a7, 4
	ecall
	li a7,5
	ecall
	mv t3, a0
	ret
checkPositiveOverFlow:
	sub t5, s4, t3
	blt t5, t2, overflowEnding
	ret
checkNegativeOverFlow:
	sub t5, s5, t3
	blt t2, t5, overflowEnding
	ret
userInputSize:
	la a0, askMessage
	li a7, 4
	ecall
	li a7, 5
	ecall
	blt a0,s2, tryAgain
	bgt a0, s3, tryAgain
	mv t1, a0
	ret
tryAgain:
	la a0, errorSizeMessage
	li a7,4
	ecall
	j userInputSize
overflowEnding:
	la a0, ln
        li a7,4
        ecall 
        
	la a0, overflowMessage
	li a7,4
	ecall
	
	la a0, resultCount
        li a7, 4
        ecall
        mv a0, t4
        li a7, 1
        ecall
        
        la a0, ln
        li a7,4
        ecall 
        
        la a0, resultSum
        ecall
        mv a0, t2
        li a7, 1
        ecall
        
        jal parityPrint
        
	li a7,10
	ecall
parityPrint:
	la a0, ln
        li a7,4
        ecall 
	
	la a0, oddNum
	li a7, 4
	ecall
	mv a0, s6
	li a7, 1
	ecall
	
	la a0, ln
        li a7,4
        ecall
        
        la a0, evenNum
        ecall
        mv a0, s7
        li a7, 1
        ecall
        ret
