.data
askMessage: .asciz "Input array size(1-10):"
enterNum: .asciz "Please enter number:"


.macro print_str(%str)
	la a0, %str
	li a7, 4
	ecall
.end_macro

.macro userInputSize
	print_str(askMessage)
	readInt
	jal _userInputSize
.end_macro

.macro userInputNum
	print_str(enterNum)
	readInt
	mv a1, a0
.end_macro

.macro readInt
	li a7, 5
	ecall
.end_macro

.macro push(%reg)
	addi sp, sp, -4
	sw %reg, (sp)
.end_macro

.macro pop(%reg)
	lw %reg, (sp)
	sw zero, (sp)
	addi sp,sp,4
.end_macro

.macro fillArray(%arr, %size)
	mv a2 %size
	la a1, %arr
	jal _fillArray
.end_macro

.macro countSum(%arr, %size)
	la a1, %arr
	mv a2, %size
	jal _countSum
.end_macro

.macro checkNegativeOverFlow(%element, %currentSum)
	push(t5)
	sub t5, s5, %element
	bgt t5, %currentSum, overflow
	noOverflow:
	li a0,0
	j end
	overflow:
	li a0, 1
	end:
	pop(t5)
.end_macro

.macro checkPositiveOverFlow(%element, %currentSum)
	push(t5)
	sub t5, s4, %element
	blt t5, %currentSum, overflow
	noOverflow:
	li a0,0
	j end
	overflow:
	li a0, 1
	end:
	pop(t5)
.end_macro

.macro overFlowEnding(%count, %sum)
	mv a0, %count
	mv a1, %sum
	jal _overFlowEnding
.end_macro

.macro exit
	li a7,10
	ecall
.end_macro

.macro resultPrint(%count, %sum)
	jal _normalEnding
.end_macro
	

