.global main

.include "macrolib.inc"

.data
delta: .double 0.001

.text
main:
	fld fs1, delta, t0
	userInputType # userInputType() -> int mode in a0(0 - noAuto, 1 - auto)
	beqz a0, noAutoTests 
	jal autoTests # starts auto tests
	exit
	noAutoTests:
	userInput # userInput() -> double x in [-1;1](in fa0)
	fmv.d fs0, fa0
	arctan(fa0) # arctan(double x) -> double result = arctan(x) in fa0
	fmv.d fa1, fa0
	printArctan(fs0, fa1) # printArctanFrom(double x, double arg) -> print in console "arctan(x) = arg"
	exit
