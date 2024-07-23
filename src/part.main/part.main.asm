	ld a, %01000111 : call lib.SetScreenAttr

;	jp .skip

	ld b, 20 : halt : djnz $-1

	ld a, 4
	ld d, #40
	call jswWalkRight

	ld b, 40 : halt : djnz $-1

	ld a, 3
	ld d, #48
	call jswWalkLeft

	ld b, 40 : halt : djnz $-1

	ld a, 50 : ld (zap4WithDelay + 1), a
	ld hl, zap4WithDelay
	call interrStart

	ld a, 2
	ld d, #50
	call jswWalkRight

	call interrStop

	ld bc, #0808
	call z4Iteration
.skip	
	call partCubo + 3
	ld hl, partCubo
	call interrStart

	ld b, 255
1	push bc
	call zapili4.start
	halt 
	pop bc
	djnz 1b

	call interrStop
loop2
	halt
	call zapili4.start

	halt
	call zapili4.start

	call randomNoise
	jr loop2

z4Iteration	ld a, c
1	call zapili4.start + 6
	push af
	push bc
	ld b, 14
3	push bc
	halt
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

zap4WithDelay	ld a, 10 
	or a : jp z, zapili4.start
	dec a : ld (zap4WithDelay + 1), a
	ret

	include "common.asm"
	include "jsw.asm"

	module zapili4
start	ld de, #4000
	include "zapili4/player.asm"
	endmodule
