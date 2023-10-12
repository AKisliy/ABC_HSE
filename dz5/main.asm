.global main

.include "macrolib.inc"

.align  2                    
array:  .space  40
arrend:

main:
.text
	li s2,1		# s2:s3 - array borders
	li s3, 10
	li s4, 2147483647  	# s4 - max sum
	li s5, -2147483648	# s5 - min sum
	userInputSize
	mv s1,a1
	fillArray(array, s1)
	countSum(array,s1)
	resultPrint(a0, a1)
	exit
