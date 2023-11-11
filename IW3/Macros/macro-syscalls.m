.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

.macro print_imm_int (%x)
   li a7, 1
   li a0, %x
   ecall
.end_macro

.macro read_int_a0
	li a7, 5
	ecall
.end_macro

.macro read_int(%x)
	push(a0)
	li a7, 5
	ecall
	mv %x, a0
	pop(a0)
.end_macro

.macro print_str (%x)
.data
str: .asciz %x
.text
	push (a0)
	li a7, 4
	la a0, str
	ecall
	pop(a0)
.end_macro

.macro print_str_from_label(%str)
	la a0, %str
	li a7,4
	ecall
.end_macro

.macro print_char(%x)
   	li a7, 11
   	li a0, %x
   	ecall
.end_macro

.macro newline
   	print_char('\n')
.end_macro

.macro exit
	li a7, 10
	ecall
.end_macro

.macro push(%x)
	addi sp, sp, -4
	sw %x, (sp)
.end_macro

.macro pushbyte(%b)
	push(t0)
	li t0, %b
	addi sp, sp, -1
	sb t0, (sp)
	pop(t0)
.end_macro

.macro pop(%x)
	lw %x, (sp)
	addi sp, sp, 4
.end_macro

.macro print_change_of_string(%before, %after)
.data
arrow: .asciz " -> "
.text
	print_str_from_label(%before)
	print_str_from_label(arrow)
	print_str_from_label(%after)
.end_macro
