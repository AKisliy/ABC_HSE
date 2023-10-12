.global main

.include "macrolib.inc"

.align  2                    
array:  .space  40
arrend:

main:
.text
	li s2,1		# s2:s3 - array borders
	li s3, 10
	li s4, 2147483647  	# s4 - max sum
	li s5, -2147483648	# s5 - min sum
	userInputSize
	mv s1, a1
	fillArray(array, s1)
	countSum(array,s1)
	resultPrint(a0, a1)
        #la  t0 array    # t0 - pointer
        #mv t2,t1	#t1 - array size, t2 - temp counter
        #fillLoop:
        #jal userInputNum
        #sw t3 (t0)  # t3 - user input num
        #addi    t0 t0 4
        #sub t2, t2, s2
        #and t3, t3,s2
        #beqz t3, addEven	
     	#addi s6,s6,1 # s6 - number of odd elements
     	#j continueLoop
     	#addEven:
     	#	addi s7,s7, 1 # s7 - number of even elements
     	#continueLoop:
        #bgtz t2, fillLoop
        
        #la t0, array
        # t2 - sum
        # t3 - current num from array
	# t4 - count
	# t5 - checking for error
	#countLoop:
	#lw t3, (t0)
	#bltz t3, negativeOverFlow
	#bgtz t3, positiveOverFlow
	#negativeOverFlow:
	#	jal checkNegativeOverFlow
	#	j continue
	#positiveOverFlow:
	#	jal checkPositiveOverFlow
	
	#continue:
	#addi t4, t4,1
	#add t2, t2, t3
	#addi t0 t0 4
	#blt t4, t1, countLoop
	
	#la a0, ln
        #li a7,4
        #ecall 
        
        
        #la a0, resultCount
        #li a7, 4
        #ecall
        #mv a0, t4
        #li a7, 1
        #ecall
        
        #la a0, ln
        #li a7,4
        #ecall 
        
        #la a0, resultSum
        #li a7, 4
        #ecall
        #mv a0, t2
        #li a7, 1
        #ecall
        
        #jal parityPrint
        
	exit
