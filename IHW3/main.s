.include "macro-syscalls.m"
.include "macro-string-extension.m"
.include "macro-custom.m"

.text
.globl main
main:
    userChoice # userchoice() -> Y or N in a0
    mv s0, a0
    newline
    load_text # function to read text from file to heap, returns address of text's start in a0
    mv s3, a0
    vowelsAndConsonants(s3) # vowelsAndConsonants(address of string) -> num of vowels in a0, num of consonants in a1
    mv s10, a0
    mv s11, a1
    
    write_result(s10,s11) # write_result(int numOfVowels, int numOfConsonants), writes results of count in file
    
    li t0, 'Y' # print in console or not?
    bne t0, s0, noPrint
    
    print_str("Number of vowels in your file: ")
    print_int(s10)
    newline
    
    print_str("Number of consonants in your file: ")
    print_int(s11)
    noPrint:
    exit

