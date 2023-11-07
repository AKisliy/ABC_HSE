.include "macro-syscalls.m"
.include "macro-string.m"

.eqv     BUF_SIZE 102

.data
inputbuf: .space BUF_SIZE
outputbuf: .space BUF_SIZE   
empty_test_str: .asciz ""
short_test_str: .asciz "Hello!" 
long_test_str:  .asciz "I am pretty long string!!!"

.text
.globl main
main:
    print_str("Input your string(max length - 101):")
    newline
    la      a0 inputbuf
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    newline
    remove_extra_symbols(inputbuf)

    print_str("Input the argument n for strncpy:")
    read_int(s0)
    
    print_str("Here are results in format: (source string) -> (string after strncpy)\n")
    print_str("Your string:\n")
    strncpy(outputbuf, inputbuf, s0)
    print_change_of_string(inputbuf,outputbuf)
    newline
    newline
   
    print_str("Some extra test cases:\n")
    strncpy(outputbuf, empty_test_str, s0)
    print_change_of_string(empty_test_str,outputbuf)
    print_str(" (empty string)")
    newline

    strncpy(outputbuf, short_test_str, s0)
    print_change_of_string(short_test_str,outputbuf)
    newline
    
    strncpy(outputbuf, long_test_str, s0)
    print_change_of_string(long_test_str,outputbuf)
    newline

    exit
