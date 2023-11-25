.include "macro-syscalls.m"
.include "macro-string-extension.m"
.include "macro-custom.m"

.text
.globl main
main:
    userInputType # -> a0 = 0 - manual mode, a0 = 1 - autotests mode
    beqz a0, manual
    jal autoTests
    exit
    
    manual:
    userChoice # userchoice() -> 1(no) or 0(yes) in a0
    mv s0, a0
    
    newline
    getReadingPath # getReadingPath -> return correct file descriptor for reading in a0
    loadTextFrom(a0)  # loadTextFrom(descriptor) - function to read text from file to heap, returns address of text's start in a0

    mv s3, a0
    vowelsAndConsonants(s3) # vowelsAndConsonants(address of string) -> num of vowels in a0, num of consonants in a1
    mv s10, a0
    mv s11, a1
    
    getWritingPath # getWritingPath -> return correct file descriptor for writing in a0
    mv s4, a0
    write_result_to(s10,s11, s4) # write_result(int numOfVowels, int numOfConsonants, descriptor) - writes results of count in file
    
    li t0, 0 # print in console or not?
    bne t0, s0, noPrint
    
    print_str("Number of vowels in your file: ")
    print_int(s10)
    newline
    
    print_str("Number of consonants in your file: ")
    print_int(s11)
    noPrint:
    exit
