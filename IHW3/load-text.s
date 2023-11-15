.include "macro-syscalls.m"
.include "macro-string-extension.m"

.eqv    NAME_SIZE 256	
.eqv    MAX_SIZE 10240
.eqv    TEXT_SIZE 512

.global loadText

.data
er_name_mes:    .asciz "Incorrect file name\n"
er_read_mes:    .asciz "Incorrect read operation\n"
er_write_mes: .asciz "Incorrect write operation\n"
resultVowels: .asciz "Number of vowels in your file: "
resultConsonants: .asciz "Number of consonants in your file: "

file_name:      .space	NAME_SIZE	
strbuf:	.space TEXT_SIZE
vowelsString: .space MAX_SIZE
consonantsString: .space MAX_SIZE

.text
loadText:
    push(ra)
    push(s0)
    push(s1)
    push(s2)
    push(s3)
    push(s4)
    push(s5)
    push(s6)
    push(s11)
inputFileLoop:
    print_str ("ATTENTION!! Only files with a size <= 10 KB will be fully read!\n")
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
    mv a0, s3
    pop(s11)
    pop(s6)
    pop(s5)
    pop(s4)
    pop(s3)
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret
    
er_read:
print_str_from_label(er_read_mes)
exit

