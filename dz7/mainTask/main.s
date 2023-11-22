.include "macrolib.m"

.text 
main:
	clear_block(0x10)
	clear_block(0x11)
	li s0, 0 # borders [0,15]
	li s1, 16
	li s2, 0x10 # mode to the right block
	loopFirst:
		beq s0, s1, endLoop
		hex_print(s0,s2)
		sleep(1)
		addi s0, s0, 1
		j loopFirst
	endLoop:
	clear_block(0x10)
	li s0, 0
	li s2, 0x11
	loopSecond:
		beq s0, s1, end
		hex_print(s0,s2)
		sleep(1)
		addi s0, s0, 1
		j loopSecond
	end:
	clear_block(0x11)
	exit
	

	
