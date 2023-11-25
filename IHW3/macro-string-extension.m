.macro reverse(%str) # reverse the string from label 
	push(s0)
	push(s1)
	push(t0)
	push(t1)
	la s0, %str # left pointer
	la s1, %str # right pointer
	loop: # find end
		lb t0, (s1) 
		beqz t0, endLoop
		addi s1, s1, 1
		j loop
	endLoop:
	addi s1, s1, -1 # s1 now points to the last symbol
	changeLoop:
		bge s0, s1, endChange
		lb t0, (s0) # char from left pointer
		lb t1, (s1) # char from right pointer
		sb t0, (s1) # swap
		sb t1, (s0)
		addi s1, s1, -1
		addi s0, s0, 1
		j changeLoop
	endChange:
	pop(t1)
	pop(t0)
	pop(s1)
	pop(s0)
.end_macro

.macro vowelsAndConsonants(%str)
	mv a0, %str
	jal count_vowels # count_vowels(string address) -> a0 - num of vowels in str, a1 - num of consonants in str
.end_macro

.macro remove_extra_symbols(%str) # removes \n from the end of the %str
	push(a0)
	push(t0)
	push(t1)
	li t1, '\n'
	la a0, %str
	loop:
	lb t0, (a0)
	beq t0, t1, remove
	addi a0,a0,1
	j loop
	remove:
	li t0, '\0'
	sb t0, (a0)
	pop(t1)
	pop(t0)
	pop(a0)
.end_macro

.macro to_string(%in, %number) # convert int number from register %number into string on label %in (max number's length - 10000)
	push(t0)
	push(t1)
	push(t2)
	push(t3)
	push(t4)
	push(t5)
	mv t0, %number
	li t1, '0'
	li t2, 10
	la t5, %in
	bnez t0, cont
	sb t1, (t5)
	li t1, '\0'
	addi t5, t5, 1
	sb t1, (t5)
	j end
	cont:
	loop:
	blez t0, endLoop
	rem t3, t0, t2
	add t4, t1, t3
	sb t4, (t5)
	div t0, t0, t2
	addi t5,t5,1
	j loop
	endLoop:
	li t1,'\0'
	sb t1, (t5)
	reverse(%in)
	end:
	pop(t5)
	pop(t4)
	pop(t3)
	pop(t2)
	pop(t1)
	pop(t0)
.end_macro

.macro strlen (%s1) # returns length of string %s1
	la a0 %s1
	jal strlen
.end_macro

.macro strlen_reg(%reg) # returns length of string in register %reg
	mv a0 %reg
	jal strlen
.end_macro


