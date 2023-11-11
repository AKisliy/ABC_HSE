.include "macro-syscalls.m"
.include "macro-string.m"

.eqv     BUF_SIZE 102

.data
inputbuf: .space BUF_SIZE

.text
.globl main
main:
    print_str("Input your string(max length - 101) in ASCII:")
    newline
    la      a0 inputbuf
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    newline
    remove_extra_symbols(inputbuf)

    vowelsAndConsonants(inputbuf)
    
    print_str("Number of vowels in your string: ")
    print_int(a0)
    newline
    
    print_str("Number of consonants in your string: ")
    print_int(a1)
    exit
