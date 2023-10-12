.macro print_str(%str)
	la a0, %str
	li a7, 4
	ecall
.end_macro

.macro read_int
	li a7 5
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

.macro exit
	li a7,10
	ecall
.end_macro

.macro putNumInArray(%arrReg, %num)
	li t1, %num
	sw t1, (%arrReg)
	addi %arrReg, %arrReg, 4
.end_macro

.macro putRegInArray(%arrReg, %reg)
	sw %reg, (%arrReg)
	addi %arrReg, %arrReg, 4
.end_macro
