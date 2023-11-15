.data 
lowerStr: .asciz "aoeiuy"
upperStr: .asciz "AOEIUY"
.macro isVowel(%ch) # check whether %ch is vowel or not( a0 = 1 - True, a0 = 0 - False)
	push(t0) # we don't have to save t-registers, but for convenience i did it
	push(t1)
	isUpper(%ch)
	bgtz a0, upper # if %ch is upper - try to find in upper vowels
	isLower(%ch)
	bgtz a0, lower # if %ch is lower - try to find in lower vowels
	li a0, 1
	upper:
	la t0, upperStr
	j findLoop
	lower:
	la t0, lowerStr
	findLoop: # iterate over upper or lower vowel string
		lb t1, (t0)
		beqz t1, changeResult # if didn't find - change result to 0
		beq t1,%ch, end # if find - return 1
		addi t0, t0, 1
		j findLoop
	changeResult:
		li a0, 0
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
	
	
