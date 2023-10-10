.include "macros.inc"
.global autoTests
.data
.align 2
arr1:  .space  40
arr1end:
arr2: .space 4
arr2end:
arr3:  .space  20
arr3end:
arr4: .space 20
arr4end:
arr5: .space 12
arr5end:
resultArr: .space 40
resultArrend:

.text
autoTests:
	jal fillTestArrays
	la s1, resultArr
	
	la t1, arr1
	li t0, 10
	push(t0)
	push(s1)
	push(t1)
	jal makeNewArray
	pop(t1) # result arr size
	push(s1)
	push(t1)
	jal printArray
	
	la t1, arr2
	li t0, 1
	push(t0)
	push(s1)
	push(t1)
	jal makeNewArray
	pop(t1) # result arr size
	push(s1)
	push(t1)
	jal printArray
	
	la t1, arr3
	li t0, 5
	push(t0)
	push(s1)
	push(t1)
	jal makeNewArray
	pop(t1) # result arr size
	push(s1)
	push(t1)
	jal printArray
	
	la t1, arr4
	li t0, 5
	push(t0)
	push(s1)
	push(t1)
	jal makeNewArray
	pop(t1) # result arr size
	push(s1)
	push(t1)
	jal printArray
	
	la t1, arr5
	li t0, 3
	push(t0)
	push(s1)
	push(t1)
	jal makeNewArray
	pop(t1) # result arr size
	push(s1)
	push(t1)
	jal printArray
	
	exit
fillTestArrays:
	la t0, arr1
	#10 items 
	putNumInArray(t0, 1)
	putNumInArray(t0, 2)
	putNumInArray(t0, 3)
	putNumInArray(t0, 4)
	putNumInArray(t0, 5)
	putNumInArray(t0, 6)
	putNumInArray(t0, 7)
	putNumInArray(t0, 8)
	putNumInArray(t0, 9)
	putNumInArray(t0, 10)
	la t0, arr2
	#singleItem
	putNumInArray(t0,0)
	la t0, arr3
	# all even
	putNumInArray(t0, 24)
	putNumInArray(t0, 2)
	putNumInArray(t0, 18)
	putNumInArray(t0, 400)
	putNumInArray(t0, 554)
	la t0, arr4
	#all odd
	putNumInArray(t0, 13)
	putNumInArray(t0, 457)
	putNumInArray(t0, -15)
	putNumInArray(t0, 19)
	putNumInArray(t0, 43)
	la t0, arr5
	#negative items
	putNumInArray(t0, -933)
	putNumInArray(t0, -29)
	putNumInArray(t0, -14)
	ret
	
