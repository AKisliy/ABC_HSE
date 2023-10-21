.global main

.include "macrolib.inc"

.data
delta: .double 0.0001

.text
main:
	fld fs1, delta, t0
	jal autoTests
	exit
	userInput
	arctan(fa0)
	printArctanFrom(fa0)
	exit
