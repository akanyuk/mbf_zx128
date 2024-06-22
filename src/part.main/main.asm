	ld a, %01000111 : call lib.SetScreenAttr

1	halt
	halt
	halt
    	ld de, #4000
	call zapili4.start
	jp 1b

	module zapili4
start	include "zapili4/player.asm"
	endmodule
