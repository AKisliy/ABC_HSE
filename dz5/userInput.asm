.global _userInputSize
.include "macrolib.inc"
.data
errorSizeMessage: .asciz "Wrong size!!! Try again: "


.text
_userInputSize:
	push(ra)
	sizeLoop:
	blt a0,s2, tryAgain
	bgt a0, s3, tryAgain
	j endSizeLoop
	tryAgain:
	print_str(errorSizeMessage)
	readInt
	j sizeLoop
	endSizeLoop:
	mv a1, a0
	pop(ra)
	ret
