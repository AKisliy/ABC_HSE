.include "macro-syscalls.m"
.include "macro-string-extension.m"

.eqv    NAME_SIZE 256	
.eqv    MAX_SIZE 10240
.eqv    TEXT_SIZE 512

.global writeResult

.data
er_name_mes:    .asciz "Incorrect file name\n"
er_read_mes:    .asciz "Incorrect read operation\n"
er_write_mes: .asciz "Incorrect write operation\n"
resultVowels: .asciz "Number of vowels in your file: "
resultConsonants: .asciz "Number of consonants in your file: "
newLineFile: .asciz "\n"

file_name:      .space	NAME_SIZE	
strbuf:	.space TEXT_SIZE
vowelsString: .space MAX_SIZE
consonantsString: .space MAX_SIZE

.text
writeResult:
    push(ra)
    push(s0)
    push(s1)
    push(s3)
    push(s6)
    push(s7)
    push(s8)
    mv s7, a0
    mv s8, a1
    la s3, resultVowels
    strlen(resultVowels)
    mv s6, a0
outputFileLoop: 
    print_str ("Input path to file for writing: ")
    str_get(file_name, NAME_SIZE) 
    open(file_name, WRITE_ONLY)
    li		s1 -1
    beq		a0 s1 tryOutputAgain
    j	continue
tryOutputAgain:
	print_str_from_label(er_name_mes)
    	j outputFileLoop
continue:
    mv   s0 a0   
    li   a7, 64       		
    mv   a0, s0 			
    mv   a1, s3  			
    mv   a2, s6    			
    ecall
    
    to_string(vowelsString, s7)
    strlen(vowelsString)
    mv s6, a0
    la s3, vowelsString
    li   a7, 64       		
    mv   a0, s0 			
    mv   a1, s3  			
    mv   a2, s6    			
    ecall
    
    strlen(newLineFile)
    mv s6, a0
    la s3, newLineFile
    li   a7, 64       		
    mv   a0, s0 			
    mv   a1, s3  			
    mv   a2, s6    			
    ecall
    
    strlen(resultConsonants)
    mv s6, a0
    la s3, resultConsonants
    li   a7, 64       		
    mv   a0, s0 			
    mv   a1, s3  			
    mv   a2, s6    			
    ecall
    
    
    to_string(consonantsString, s8)
    strlen(consonantsString)
    mv s6, a0
    la s3, consonantsString
    li   a7, 64       		
    mv   a0, s0 			
    mv   a1, s3  			
    mv   a2, s6    			
    ecall

    #print_str ("There is bytes in the source file: ")
    #print_int(s6)
    #newline
    mv a0, s3
    pop(s8)
    pop(s7)
    pop(s6)
    pop(s3)
    pop(s1)
    pop(s0)
    pop(ra)
    ret
er_read:
    print_str_from_label(er_read_mes)
    exit
