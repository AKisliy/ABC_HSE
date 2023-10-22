.data
inputMessage: .asciz "Input x to calculate arctan(x): "
errorMessage: .asciz "We can calculate arctan(x) using Taylor series only for x in [-1,1]. Try again: "
wrongTypeMessage: .asciz "Wrong type!! Try again:"
chooseProgramType: .asciz "Please, choose program type: 0 - normal mode, 1 - auto tests:"
resultFirstPart: .asciz "arctan("
resultSecondPart: .asciz ") = "
ln: .asciz "\n"

.macro printArctan(%x, %res)
	printStr(resultFirstPart)
	printDouble(%x)
	printStr(resultSecondPart)
	printDouble(%res)
	printStr(ln)
.end_macro

.macro printStr(%str)
	la a0, %str
	li a7,4
	ecall
.end_macro

.macro printDouble(%reg)
	fmv.d fa0, %reg
	li a7,3
	ecall
.end_macro

.macro userInput
	printStr(inputMessage)
	inputLoop:
	readDouble
	putInFRegister(1, ft0)
	putInFRegister(-1, ft1)
	flt.d t0, fa0, ft1
	fgt.d t1, fa0, ft0
	bgtz t0, tryAgain
	bgtz t1, tryAgain
	j end
	tryAgain:
	printStr(errorMessage)
	j inputLoop
	end:
.end_macro

.macro userInputType
	printStr(chooseProgramType)
	li t0, 1
	typeLoop:
	readInt
	bltz a0, tryAgainType
	bgt a0,t0,tryAgainType
	j endTypeLoop
	tryAgainType:
	printStr(wrongTypeMessage)
	j typeLoop
	endTypeLoop:
.end_macro

.macro readInt
	li a7, 5
	ecall
.end_macro

.macro readDouble
	li a7, 7
	ecall
.end_macro

.macro arctan(%reg)
	fmv.d fa0, %reg
	jal findArctan
.end_macro

.macro push(%reg)
	addi sp, sp, -4
	sw %reg, (sp)
.end_macro

.macro pop(%reg)
	lw %reg, (sp)
	sw zero, (sp)
	addi sp,sp,4
.end_macro

.macro pushF(%reg)
	addi sp, sp, -8
	fsd %reg, (sp)
.end_macro

.macro popF(%reg)
	fld %reg, (sp)
	sw zero, (sp)
	addi sp,sp,8
.end_macro

.macro power(%num, %power)
	push(t0)
	li t0, %power
	putInFRegister(1, fa0)
	bgez t0, count
	j end
	count:
	fmul.d fa0, %num, fa0
	addi t0, t0, -1
	bgtz t0, count
	end:
	pop(t0)
.end_macro 

.macro mult(%reg, %num)
	pushF (ft0)
	putInFRegister(%num, ft0)
	fmul.d %reg, %reg, ft0
	popF(ft0)
.end_macro

.macro exit
	li a7,10
	ecall
.end_macro 

.macro putInFRegister(%num, %reg)
	push(t0)
	li t0, %num
	fcvt.d.w %reg, t0
	pop(t0)
.end_macro
