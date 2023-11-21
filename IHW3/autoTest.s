.include "macro-syscalls.m"
.include "macro-string-extension.m"
.include "macro-custom.m"

.global autoTests
.data
input1: .asciz "test1.txt"
input2: .asciz "test2.txt"
input3: .asciz "test3.txt"
input4: .asciz "test4.txt"
input5: .asciz "test5.txt"
testReadEnd:
output1: .asciz "output1.txt"
output2: .asciz "output2.txt"
output3: .asciz "output3.txt"
output4: .asciz "output4.txt"
output5: .asciz "output5.txt"
testWriteEnd:

.text
autoTests:
	prologue
	
	push(t0)
	push(t1)
	la s0, input1
	la s1, output1
	la s7, testReadEnd
	la s8, testWriteEnd
	print_str("Starting autotests! Be patient, it will take some time..\n")
	testingLoop:
		print_str("Processing test..\n")
		open_from_reg(s0, READ_ONLY)
		loadTextFrom(a0) # loadTextFrom(descriptor) - function to read text from file to heap, returns address of text's start in a0
    		mv s3, a0
    		vowelsAndConsonants(s3) # vowelsAndConsonants(address of string) -> num of vowels in a0, num of consonants in a1
    		mv s10, a0
    		mv s11, a1
    		open_from_reg(s1, WRITE_ONLY)
    		mv s4, a0
    		write_result_to(s10,s11, s4)
		strlen_reg(s0)
		addi a0, a0, 1
		add s0, s0, a0
		strlen_reg(s1)
		addi a0, a0, 1
		add s1, s1, a0
		beq s0, s7, end
		j testingLoop
	end:
	print_str("Tests end successfully!! Check files(names output*.txt) with result in current directory")
	pop(t1)
	pop(t0)
	
	epilogue
	ret
