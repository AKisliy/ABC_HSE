.data
    arg01:  .asciz "Input divisible: "
    arg02:  .asciz "Input divider: "
    result: .asciz "Result = "
    remainder: .asciz "Remainder = "
    ln:     .asciz "\n"
    exception: .asciz"Dividing by zero!!!!"
.text
        la 	a0, arg01
        li 	a7, 4    
        ecall
        li      a7 5        
        ecall               
        mv      t0 a0   
        blt t0,zero, makePositiveDivisible
        j continue1
        makePositiveDivisible:
        	sub t0,zero,t0
        	li t3, -1 
	continue1:
        la 	a0, arg02   
        li 	a7, 4       
        ecall
        li      a7 5        
        ecall               
        mv      t1 a0
        blt t1, zero, makePositiveDivider
        j continue2
        makePositiveDivider:
        	sub t1, zero,t1
        	li t4, -1
        continue2:
        beqz t1,dividingByZero
        # t0 - делимое
        # t1 - divider
        # t2 - result
        # t3 - знак делимого
        # t4 - знак делителя
            
	blt t0, t1, loopEnd
	loop:
		addi t2, t2,1
		sub t0,t0,t1
		bge t0, t1, loop
	loopEnd:
	blt t3, zero, changeRemainderSign
	j noChangeRemainder
	changeRemainderSign:
		sub, t0, zero, t0
		beqz t4, changeResultSign
		j end
	noChangeRemainder:
	blt t4, zero, changeResultSign
	j end
	changeResultSign:
		sub t2, zero, t2
	end:
		j printResult
dividingByZero:
	la a0,exception      
        li a7, 4           
        ecall
	j programEnd
printResult:
	la a0, result
	li a7, 4
	ecall		
	mv a0, t2
	li a7, 1
	ecall
	
	la a0, ln
	li a7, 4
	ecall
	
	la a0, remainder
	li a7, 4
	ecall
		
	mv a0, t0
	li a7, 1
	ecall
programEnd:
	li      a7 10
        ecall
