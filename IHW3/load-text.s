.include "macro-syscalls.m"
.include "macro-string-extension.m"
.include "macro-custom.m"

.eqv    MAX_SIZE 10000
.eqv    TEXT_SIZE 512

.global loadText

.data
er_read_mes:    .asciz "Incorrect read operation\n"
strbuf:	.space TEXT_SIZE

.text
loadText:
    prologue
    
    mv   	s0 a0 
    allocate(TEXT_SIZE)		
    mv 		s3, a0		
    mv 		s5, a0			
    li		s4, TEXT_SIZE	
    mv		s6, zero
    li 		s11, MAX_SIZE		
  
read_loop:
    blez s11, end_loop
    blt s11, s4, makeLess
    j contRead
    makeLess:
    mv s4, s11
    contRead:
    read_addr_reg(s0, s5, s4)
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
    epilogue
    ret
    
er_read:
print_str_from_label(er_read_mes)
exit
