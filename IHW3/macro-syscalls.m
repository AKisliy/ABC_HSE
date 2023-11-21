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

.macro loadTextFrom(%path)
	mv a0, %path
	jal loadText
.end_macro

.macro write_result_to(%vowels, %consonants, %path)
	mv a0, %vowels
	mv a1, %consonants
	mv a2, %path
	jal writeResult
.end_macro
	

.macro str_get(%strbuf, %size)
    la      a0 %strbuf
    li      a1 %size
    li      a7 8
    ecall
    push(s0)
    push(s1)
    push(s2)
    li	s0 '\n'
    la	s1	%strbuf
next:
    lb	s2  (s1)
    beq s0   s2	replace
    addi s1 s1 1
    b	next
replace:
    sb	zero (s1)
    pop(s2)
    pop(s1)
    pop(s0)
.end_macro

.eqv READ_ONLY	0	
.eqv WRITE_ONLY	1	
.eqv APPEND	9	
.macro open(%file_name, %opt)
    li   a7 1024     	
    la   a0 %file_name 
    li   a1 %opt 
    ecall
.end_macro

.macro open_from_reg(%reg, %opt)
    li   a7 1024     	
    mv   a0 %reg 
    li   a1 %opt 
    ecall
.end_macro

.macro close(%file_descriptor)
    li   a7, 57     
    mv   a0, %file_descriptor  
    ecall  
.end_macro

.macro allocate(%size)
    li a7, 9
    li a0, %size
    ecall
.end_macro

.macro read_addr_reg(%file_descriptor, %reg, %size)
    li   a7, 63
    mv   a0, %file_descriptor    
    mv   a1, %reg   
    mv   a2, %size 		
    ecall             	
.end_macro



