.include "macro-syscalls.m"
.include "macrolib.m"
.text
main:
	      clear_block(0x10)
	      clear_block(0x11)
        lui     t6 0xffff0          #  MMIO base
        li 	    s7 0x10             # right block
loop:
        mv      t1 zero             # scaning result
        li      t0 1                # first row
        sb      t0 0x12(t6)         
        lb      t0 0x14(t6)         # take the result
        or      t1 t1 t0            # add to result
        li      t0 2                # second row
        sb      t0 0x12(t6)
        lb      t0 0x14(t6)
        or      t1 t1 t0
        li      t0 4                # third row
        sb      t0 0x12(t6)
        lb      t0 0x14(t6)
        or      t1 t1 t0
        li      t0 8                # fourth
        sb      t0 0x12(t6)
        lb      t0 0x14(t6)
        or      t1 t1 t0
        beqz    t1 noButton
        convert_from_keyboard(t1)
        hex_print(a0, s7)
        j loop

noButton:   
	li a0, -1
       	hex_print(a0, s7)
       	j loop
