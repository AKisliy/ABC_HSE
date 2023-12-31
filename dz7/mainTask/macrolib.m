.macro sleep(%x)
    	li a0, %x
    	li a7, 32
    	ecall
.end_macro

.macro exit
	li a7, 10
	ecall
.end_macro

.macro hex_print(%num, %block)
	mv a0, %num
	mv a1, %block # break point
	jal hexPrinter
.end_macro

.macro push(%x)
	addi sp, sp, -4
	sw %x, (sp)
.end_macro

.macro pop(%x)
	lw %x, (sp)
	addi sp, sp, 4
.end_macro

.macro clear_block(%block)
	lui t3, 0xffff0
	addi t3, t3, %block
	sb zero, (t3)
.end_macro
