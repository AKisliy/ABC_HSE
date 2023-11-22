.include "macrolib.m"

.global hexPrinter

.data
zeroMy: .byte 0x3f 
one: .byte 0x06
two: .byte 0x5b
three: .byte 0x4f
four: .byte 0x66
five: .byte  0x6d
six: .byte 0x7d
seven: .byte 0x07
eight: .byte 0x7f
nine: .byte 0x6f
ten: .byte 0x77
eleven: .byte 0x7f
twelve: .byte 0x39
thirteen: .byte 0x3f
fourteen: .byte 0x79
fifteen: .byte 0x71
point: .byte 0x80
end:


.text 
hexPrinter:
	push(ra)
	push(s0)
	push(s1)
	push(s2)
	push(s3)
	
	lui t3, 0xffff0
	add t3, t3, a1
	la s0, zeroMy
	lb s1, point
	li s2, 0xf
	mv s3, a0
	
	and s3, s3, s2 # take two last
	add s0,s0, s3
	lb t1, (s0)
	bne a0, s3, needPoint
	j noPoint
	needPoint:
	or t1, t1, s1
	noPoint:
	sb t1, (t3)
	
	pop(s3)
	pop(s2)
	pop(s1)
	pop(s0)
	pop(ra)
	ret
