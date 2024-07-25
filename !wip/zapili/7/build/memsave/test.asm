	device zxspectrum128

	org #5d00
	ld sp, $-2
	ld hl, #5800
	ld de, #5801
	ld bc, #02ff
	ld (hl), %01000111
	ldir

	xor a : out (#fe),a

1   	ei 
	halt
	halt
	halt
	halt
	ld de, #4000
	call	player

	jp	1b

player	module memsave
	include "player.asm"
	endmodule

	display /d, "Animation size: ", $-player
	savebin "memsave.bin", player, $-player
	savesna "memsave.sna", #5d00
