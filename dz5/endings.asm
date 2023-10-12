.global _overFlowEnding, _normalEnding
.include "macrolib.inc"
.data
resultCount: .asciz "Number of elements in sum:"
resultSum: .asciz "Sum:"
overFlowMessage: .asciz "Oops, it seems like we have an overflow. Here's the last info we could calculate:\n"
ln:     .asciz "\n"

.text
	
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
