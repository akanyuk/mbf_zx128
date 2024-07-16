	ld a, %01000111 : call lib.SetScreenAttr

	ld a, 2 : out (#fe), a 
	
	ld a, 6
	ld d, #40
	call jswWalkRight

	ld a, 3
	ld d, #50
	call jswWalkRight

	ld a, 1 : out (#fe), a 
	di : halt

	ld bc, #2008
	call z4Iteration

loop2
	halt
    	ld de, #4000
	call zapili4.start

	halt
    	ld de, #4000
	call zapili4.start

	call randomNoise
	jr loop2

z4Iteration	ld a, c
1	call zapili4.start + 3
	push af
	push bc
	ld b, 14
3	push bc
	halt
    	ld de, #4000
	call zapili4.start
	pop bc
	djnz 3b
	
	pop bc
	push bc
	halt : djnz $-1
	pop bc

	pop af
	dec a : jr nz, 1b
	ret

randomNoise	ld b, #40
	call rl1

	ld b, #48
	call rl1

	ld b, #50

rl1	call rnd16
	ld a, h : and %00000011
	rla
	or b
	ld d, a

	ld a, l : and %11100000 : ld e, a
	ld bc, 32
	push de
	call rnd16
	pop de
	ld h, 0
	ldir
	ret

	include "common.asm"
	include "jsw.asm"

	module zapili4
start	include "zapili4/player.asm"
	endmodule
