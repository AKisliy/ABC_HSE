.include "macro-syscalls.m"
.include "macro-string-extension.m"

.eqv    NAME_SIZE 256	
.eqv    MAX_SIZE 10240
.eqv    TEXT_SIZE 512

.global loadText

.data
er_name_mes:    .asciz "Incorrect file name\n"
er_read_mes:    .asciz "Incorrect read operation\n"

file_name:      .space	NAME_SIZE	
strbuf:	.space TEXT_SIZE
.text
loadText:
    push(ra)
inputFileLoop:
    print_str ("Input path to file for reading: ")
    str_get(file_name, NAME_SIZE)
    open(file_name, READ_ONLY)
    li		s1 -1			
    beq		a0 s1 tryInputAgain
    j continue1
    tryInputAgain:
    	print_str_from_label(er_name_mes)
    	j inputFileLoop
continue1:
    mv   	s0 a0 
    allocate(TEXT_SIZE)		
    mv 		s3, a0		
    mv 		s5, a0			
    li		s4, TEXT_SIZE	
    mv		s6, zero
    li 		s11, MAX_SIZE		
  
read_loop:
    blez s11, end_loop
    read_addr_reg(s0, s5, TEXT_SIZE)
    beq		a0 s1 er_read	
    mv   	s2 a0    
    add 	s6, s6, s2
    bne		s2 s4 end_loop
    allocate(TEXT_SIZE)
    sub 	s11, s11, s2
    add		s5 s5 s2
    b read_loop
end_loop:
    close(s0)
    mv	t0 s3		
    add t0 t0 s6	
    addi t0 t0 1	
    sb	zero (t0)

    mv	a0 s3
    li 	a7 4
    ecall
outputFileLoop: 
    print_str ("Input path to file for writing: ")
    str_get(file_name, NAME_SIZE) 
    open(file_name, WRITE_ONLY)
    li		s1 -1
    beq		a0 s1 tryOutputAgain
    j	continue2
tryOutputAgain:
	print_str_from_label(er_name_mes)
    	j outputFileLoop
continue2:
    mv   	s0 a0   
    li   a7, 64       		
    mv   a0, s0 			
    mv   a1, s3  			
    mv   a2, s6    			
    ecall

    print_str ("There is bytes in the source file: ")
    print_int(s6)
    newline
    mv a0, s3
    pop(ra)
    ret
er_read:
    print_str_from_label(er_read_mes)
    exit
