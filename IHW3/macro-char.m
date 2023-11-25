.data 
lowerStr: .asciz "aoeiuy"
upperStr: .asciz "AOEIUY"
.macro isVowel(%ch) # check whether %ch is vowel or not( a0 = 1 - True, a0 = 0 - False)
	push(t0) # we don't have to save t-registers, but for convenience i did it
	push(t1)
	li a0, 0
	la t0, lowerStr
	findLoopLower: # iterate over lower vowel string
		lb t1, (t0)
		beqz t1, findLoopUpper # if didn't find - try to find in upper 
		beq t1,%ch, change # if find - return 1
		addi t0, t0, 1
		j findLoopLower
	findLoopUpper:
		la t0, upperStr
		loop:
		lb t1, (t0)
		beqz t1, end # if didn't find - return 0
		beq t1,%ch, change # if find - return 1
		addi t0, t0, 1
		j loop
	change:
		li a0, 1
	end:
	pop(t1)
	pop(t0)
.end_macro
	

.macro isUpper(%ch) # check whether %ch is upper(a0 = 1 - Yes, a0 = 0 - No)
	push(t0)
	push(t1)
	li t0, 'A' # borders of [A-Z]
	li t1, 'Z'
	li a0, 1
	blt %ch, t0, change # %ch must be in [A-Z]
	bgt %ch, t1, change
	j end
	change:
	li a0, 0
	end:
	pop(t1)
	pop(t0)
.end_macro

.macro isLower(%ch) # check whether %ch is lower(a0 = 1 - Yes, a0 = 0 - No)
	push(t0)
	push(t1)
	li t0, 'a' # borders of [a-z]
	li t1, 'z'
	li a0, 1
	blt %ch, t0, change # %ch must be in [a-z]
	bgt %ch, t1, change
	j end
	change:
	li a0, 0
	end:
	pop(t1)
	pop(t0)
.end_macro
	
