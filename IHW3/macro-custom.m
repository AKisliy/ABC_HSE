.eqv    NAME_SIZE 256	

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

.macro getReadingPath
.data
file_name:      .space	NAME_SIZE
.text
    print_str("ATTENTION!! Only files with a size <= 10 KB will be fully read!\n")
inputFileLoop:
    push(s1)
    print_str ("Input path to file for reading: ")
    str_get(file_name, NAME_SIZE)
    open(file_name, READ_ONLY)
    li		s1 -1			
    beq		a0 s1 tryInputAgain
    j continue
    tryInputAgain:
    	print_str("Incorrect file path!\n")
    	j inputFileLoop
    continue:
    pop(s1)
.end_macro

.macro getWritingPath
.data
file_name:   .space  NAME_SIZE
.text
	push(s1)
	outputFileLoop: 
	    print_str ("Input path to file for writing: ")
	    str_get(file_name, NAME_SIZE) 
	    open(file_name, WRITE_ONLY)
	    li		s1 -1
	    beq		a0 s1 tryOutputAgain
	    j	continue
	tryOutputAgain:
		print_str("Incorrect file path!\n")
	    	j outputFileLoop
	 continue:
	 pop(s1)
.end_macro

.macro userInputType
	print_str("Please, choose program type: 0 - normal mode, 1 - auto tests:")
	li t0, 1
	typeLoop:
	read_int_a0
	bltz a0, tryAgainType
	bgt a0,t0,tryAgainType
	j endTypeLoop
	tryAgainType:
	print_str("Wrong type!! Try again:")
	j typeLoop
	endTypeLoop:
.end_macro

.macro prologue # prorlogue before subprogramm starts working. Saves all s-register and ra. Use with epilogue
	push(ra)
   	push(s0)
    	push(s1)
    	push(s2)
    	push(s3)
    	push(s4)
    	push(s5)
    	push(s6)
    	push(s7)
    	push(s8)
    	push(s9)
    	push(s10)
   	push(s11)
.end_macro

.macro epilogue # epilogue after subprogramm ends working. Recover all saved s-registers and ra. Use with prologue
	pop(s11)
	pop(s10)
	pop(s9)
	pop(s8)
	pop(s7)
	pop(s6)
	pop(s5)
	pop(s4)
	pop(s3)
	pop(s2)
	pop(s1)
	pop(s0)
	pop(ra)
.end_macro

