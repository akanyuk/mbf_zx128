z4Iteration	ld a, c
1	push af
	push bc
	call zapili4.start + 3

	ld b, 14
3	push bc
	call zapili4.start
	halt
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

	include "jsw.asm"
	
pacman	module pacman
	include "pacman.asm"
	endmodule

;----------------------------------------
; in:  none
; out: HL = random 16bit value
;----------------------------------------
rnd16
.sd 	equ  $+1
	ld   de, 1234
	ld   a, d
	ld   h, e
	ld   l, 253
	or   a
	sbc  hl, de
	sbc  a, 0
	sbc  hl, de
	ld   d, 0
	sbc  a, d
	ld   e, a
	sbc  hl, de
	jr   nc, .st
	inc  hl
.st 	ld  (.sd), hl
    	ret
