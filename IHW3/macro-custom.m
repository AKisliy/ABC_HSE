.eqv    NAME_SIZE 256	

.macro userChoice
.data
message: .asciz "Do you want to show results in console?"
.text
	#print_str("Do you want to show results in console? Y/N\n")
	la a0, message
	li t0, 0
	li t1, 1
	inputLoop:
	li a7, 50
	ecall
	beq a0, t0, endLoop
	beq a0, t1, endLoop
	newline
	print_warning("Please choose Yes/No!")
	j inputLoop
	endLoop:
.end_macro

.macro getReadingPath
.data
file_name:      .space	NAME_SIZE
input: .asciz "Input path to file for reading: "
err: .asciz "Incorrect file path!"
.text
    print_warning("ATTENTION!! Only files with a size <= 10 KB will be fully read!")
inputFileLoop:
    push(s1)
    str_get_java(input,file_name, NAME_SIZE)
    open(file_name, READ_ONLY)
    li		s1 -1			
    beq		a0 s1 tryInputAgain
    j continue
    tryInputAgain:
    	print_error("Incorrect file path!\n")
    	j inputFileLoop
    continue:
    pop(s1)
.end_macro

.macro getWritingPath
.data
file_name:   .space  NAME_SIZE
output: .asciz "Input path to file for writing: "
.text
	push(s1)
	outputFileLoop: 
	    str_get_java(output, file_name, NAME_SIZE) 
	    open(file_name, WRITE_ONLY)
	    li		s1 -1
	    beq		a0 s1 tryOutputAgain
	    j	continue
	tryOutputAgain:
		print_error("Incorrect file path!\n")
	    	j outputFileLoop
	 continue:
	 pop(s1)
.end_macro

.macro userInputType
	print_str_get_int("Please, choose program type: 0 - normal mode, 1 - auto tests:")
	li t0, 1
	typeLoop:
	bltz a0, tryAgainType
	bgt a0,t0,tryAgainType
	j endTypeLoop
	tryAgainType:
	print_str_get_int("Wrong type!! Try again:")
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

