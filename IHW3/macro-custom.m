.macro userChoice
	print_str("Do you want to show results in console? Y/N\n")
	li t0, 'Y'
	li t1, 'N'
	inputLoop:
	li a7, 12
	ecall
	beq a0, t0, endLoop
	beq a0, t1, endLoop
	newline
	print_str("Unknown input!! Try again!")
	j inputLoop
	endLoop:
.end_macro
