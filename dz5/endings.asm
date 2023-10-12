.global _countSum,_overFlowEnding, _normalEnding
.include "macrolib.inc"
.data
resultCount: .asciz "Number of elements in sum:"
resultSum: .asciz "Sum:"
overFlowMessage: .asciz "Oops, it seems like we have an overflow. Here's the last info we could calculate:\n"
ln:     .asciz "\n"

.text
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
	
_overFlowEnding:
	push(ra)
	mv t1, a0
	mv t2, a1
	print_str(ln)
        print_str(overFlowMessage)
	print_str(resultCount)
	
	mv a0, t1
        li a7, 1
        ecall
        
        print_str(ln)
        print_str(resultSum)
        
        mv a0, t2
        li a7, 1
        ecall
        pop(ra)
        exit
       
_normalEnding:
	push(ra)
	mv t0, a0
	mv t1, a1
	
	print_str(ln)
        print_str(resultCount)
        
        mv a0, t0
        li a7, 1
        ecall
        
        print_str(ln)
        print_str(resultSum)

        mv a0, t1
        li a7, 1
        ecall
        pop(ra)
        ret
