.include "macro-syscalls.m"
.include "macro-string-extension.m"

.data

.text
.globl main
main:
    load_text

    vowelsAndConsonants(a0)
    
    print_str("Number of vowels in your string: ")
    print_int(a0)
    newline
    
    print_str("Number of consonants in your string: ")
    print_int(a1)
    exit
