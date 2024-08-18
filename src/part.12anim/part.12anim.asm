	jp startAnim

instCnt	ld a, 0 : inc a : and 3 : ld (instCnt + 1), a

_a1	ld a, 0 : or a : jr z, $+8
	ld de, #4000 : call play1
_a2	ld a, 0 : or a : jr z, $+8
	ld de, #4000 + 8 : call play1
_a3	ld a, 0 : or a : jr z, $+8
	ld de, #4000 + 16 : call play1
_a4	ld a, 0 : or a : jr z, $+8
	ld de, #4000 + 24 : call play1

_a5	ld a, 0 : or a : jr z, $+8
	ld de, #4800 : call play2
_a6	ld a, 0 : or a : jr z, $+8
	ld de, #4800 + 8 : call play2
_a7	ld a, 0 : or a : jr z, $+8
	ld de, #4800 + 16 : call play2
_a8	ld a, 0 : or a : jr z, $+8
	ld de, #4800 + 24 : call play2

_a9	ld a, 0 : or a : jr z, $+8
	ld de, #5000 : call play3
_a10	ld a, 0 : or a : jr z, $+8
	ld de, #5000 + 8 : call play3
_a11	ld a, 0 : or a : jr z, $+8
	ld de, #5000 + 16 : call play3
_a12	ld a, 0 : or a : jr z, $+8
	ld de, #5000 + 24 : call play3

	ld a, (instCnt + 1) : cp 3 : ret nz 
	jp nextFrame

startAnim	add a : ld l, a : ld h, 0
	ld de, pointers
	add hl, de 
	ex de, hl
	ld a, (de) : ld l, a
	inc de
	ld a, (de) : ld h, a
	ld (hl), 1
	ret
pointers	dw _a1 + 1, _a2 + 1, _a3 + 1, _a4 + 1
	dw _a5 + 1, _a6 + 1, _a7 + 1, _a8 + 1
	dw _a9 + 1, _a10 + 1, _a11 + 1, _a12 + 1

play1	ld a, (instCnt + 1) : or a : ret nz : jp play
play2	ld a, (instCnt + 1) : cp 1 : ret nz : jp play
play3	ld a, (instCnt + 1) : cp 2 : ret nz : jp play

	include "player.asm"
