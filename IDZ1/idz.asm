.global main
.include "macros.inc"

.data
.align  2                    
arrA:  .space  40
arrAend:
arrB: .space 40
arrBend:

.text
main:
	li s2,1		# s2:s3 - array borders
	li s3, 10
	jal userInputType # userInputType() -> int mode
	pop(t0)
	beqz t0, noAutoTests
	jal autoTests
	noAutoTests:
	jal userInputSize # userInputSize() -> (int size in a1)
	mv s1,a1
	push(s1) # put inputSize parametr on stack
	la t0, arrA
	
	push(t0) # put array pointer on stack
	jal fillArray # call function fillArray(int* arrPointer, int size) -> ()
	
	la t0, arrA
	la t1, arrB
	push(s1)
	push(t1)
	push(t0)
	jal makeNewArray # makeNewArray(int* sourceArray, int* destinationArray, int size) -> int size
	
	pop(s4) # s4 - B size
	# parametrs for printArray func - arr pointer and arr size
	la t1, arrB
	push(t1)
	push(s4)
	jal printArray # printArray(int* arr, int size) -> ()
	exit
