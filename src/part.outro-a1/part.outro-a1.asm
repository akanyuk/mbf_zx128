	ld a, 0 : inc a : and 1 : ld ($-4), a
	or a : ret nz

	; Pause between iterations
	ld hl, (play + 1)
	ld de, FRAME_0015
	sbc hl, de
	jr nz, 1f
_a1p	ld a, 0 : dec a : ld (_a1p + 1), a
	or a : ret nz
1	ld a, 14 : ld (_a1p + 1), a
	ld de, #4000
	include "player.asm"
	ret