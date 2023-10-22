.global findArctan

.include "macrolib.inc"

.text
findArctan:
	push(ra)
	fmv.d ft0, fa0 # get x argument
	power(ft0,2) # power(double x, int y) -> x^y in fa0
	fmv.d ft1, fa0 # x ^ 2
	putInFRegister(2,ft2) # putInFRegister(int num, register) -> puts (double)num in register
	fmul.d ft3, ft0, ft1 # cur x power
	putInFRegister(1,ft4)
	fadd.d ft4, ft2, ft4 # cur divider
	fdiv.d ft5, ft3,ft4 # cur x^k/k
	fmv.d ft6, ft0 # result
	li t0, 1 # shows with which sign we add current x^k/k: 1 -> (-x^k/k), 0 -> (+x^k/k)
	loop:
	fabs.d ft7,ft5
	flt.d t1, ft7, fs1 # check if |x^k/k| < delta, then end loop
	bgtz t1, endLoop
	beqz t0, noChange # if t0 = 0, we don't need to change sign to -
	mult(ft5,-1) # mult(%reg, int num) -> put %reg * num in %reg
	li t0, 0
	j cont 
	noChange:
	li t0, 1 # don't change sign, set t0 to 1
	cont:
	fadd.d ft6, ft6, ft5 # add current x^k/k to result
	fmul.d ft3, ft3, ft1 # count next x^k
	fadd.d ft4, ft4, ft2 # count next k
	fdiv.d ft5, ft3,ft4 # find next x^k/k
	j loop
	endLoop:
	fmv.d fa0, ft6
	pop(ra)
	ret
