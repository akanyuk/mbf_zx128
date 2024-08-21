	ld a, 0 : inc a : and 1 : ld ($-4), a
	or a : ret nz
	ld de, #4000
	include "player.asm"
	ret
