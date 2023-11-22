.include "macro-syscalls.m"
.include "macrolib.m"

.global convert_from_key_board

.data
zeroMy: .byte 0x11
one: .byte 0x21
two: .byte 0x41
three: .byte 0x81
four: .byte 0x12
five: .byte  0x22
six: .byte 0x42
seven: .byte 0x82
eight: .byte 0x14
nine: .byte 0x24
ten: .byte 0x44
eleven: .byte 0x84
twelve: .byte 0x18
thirteen: .byte 0x28
fourteen: .byte 0x48
fifteen: .byte 0x88
point: .byte 0x00

.text
convert_from_key_board:
	push(ra)
	push(s1)
	push(s2)
	push(s3)
	push(s4)
	
	mv s1, a0
	la s2, zeroMy
	li s3, 0
	la s4, point
	loop:
		beq s2, s4, endPoint
		lb t2, (s2)
		beq t2, s1, found
		addi s3, s3, 1
		addi s2, s2, 1
		j loop
	endPoint:
		lb a0, point
		pop(s4)
		pop(s3)
		pop(s2)
		pop(s1)
		pop(ra)
		ret
	found:
		mv a0, s3
		pop(s4)
		pop(s3)
		pop(s2)
		pop(s1)
		pop(ra)
		ret
		
