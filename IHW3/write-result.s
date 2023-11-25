.include "macro-syscalls.m"
.include "macro-string-extension.m"
.include "macro-custom.m"

.eqv    TEXT_SIZE 512

.global writeResult

.data
er_write_mes: .asciz "Incorrect write operation\n"
resultVowels: .asciz "Number of vowels in your file: "
resultConsonants: .asciz "Number of consonants in your file: "
newLineFile: .asciz "\n"

vowelsString: .space TEXT_SIZE
consonantsString: .space TEXT_SIZE

.text
writeResult:
    prologue
    
    mv s7, a0
    mv s8, a1
    mv s0, a2
    la s3, resultVowels
    strlen(resultVowels)
    mv s6, a0

continue:
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

    mv a0, s3
    
    epilogue
    ret
er_read:
    print_str_from_label(er_write_mes)
    exit
