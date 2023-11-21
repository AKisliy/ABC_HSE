.global strlen

.include "macro-syscalls.m"

.text
strlen:
    push(ra)
    li      t0 0 
loop:
    lb      t1 (a0)  
    beqz    t1 end
    addi    t0 t0 1		
    addi    a0 a0 1		
    b       loop
end:
    pop(ra)
    mv      a0 t0
    ret
fatal:
    pop(ra)
    li      a0 -1
    ret
