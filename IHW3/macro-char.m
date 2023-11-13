.data 
lowerStr: .asciz "aoeiuy"
upperStr: .asciz "AOEIUY"
.macro isVowel(%ch)
	push(t0)
	push(t1)
	isUpper(%ch)
	bgtz a0, upper
	isLower(%ch)
	bgtz a0, lower
	li a0, 1
	upper:
	la t0, upperStr
	j findLoop
	lower:
	la t0, lowerStr
	findLoop:
		lb t1, (t0)
		beqz t1, changeResult
		beq t1,%ch, end
		addi t0, t0, 1
		j findLoop
	changeResult:
		li a0, 0
	end:
	pop(t1)
	pop(t0)
.end_macro
	

.macro isUpper(%ch)
	push(t0)
	push(t1)
	li t0, 'A'
	li t1, 'Z'
	li a0, 1
	blt %ch, t0, change
	bgt %ch, t1, change
	j end
	change:
	li a0, 0
	end:
	pop(t1)
	pop(t0)
.end_macro

.macro isLower(%ch)
	push(t0)
	push(t1)
	li t0, 'a'
	li t1, 'z'
	li a0, 1
	blt %ch, t0, change
	bgt %ch, t1, change
	j end
	change:
	li a0, 0
	end:
	pop(t1)
	pop(t0)
.end_macro
	
