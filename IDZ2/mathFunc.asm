.global findArctan

.include "macrolib.inc"

.text
findArctan:
	push(ra)
	fmv.d ft0, fa0 # get x argument, prevRes
	power(ft0,2) 
	fmv.d ft1, fa0 # x ^ 2
	putInFRegister(2,ft2)
	fmul.d ft3, ft0, ft1 # cur x power
	putInFRegister(1,ft4)
	fadd.d ft4, ft2, ft4 # cur divider
	fdiv.d ft5, ft3,ft4 # cur x^k/k
	fmv.d ft6, ft0
	li t0, 1 # count
	loop:
	fabs.d ft7,ft5
	flt.d t1, ft7, fs1
	bgtz t1, endLoop
	beqz t0, noChange
	mult(ft5,-1)
	li t0, 0
	j cont 
	noChange:
	li t0, 1
	cont:
	fadd.d ft6, ft6, ft5
	fmul.d ft3, ft3, ft1
	fadd.d ft4, ft4, ft2
	fdiv.d ft5, ft3,ft4
	j loop
	endLoop:
	fmv.d fa0, ft6
	pop(ra)
	ret
