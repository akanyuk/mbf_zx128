	ld a, %01000111 : call lib.SetScreenAttr


	ld b, 255
loop1	push bc
	halt
    	ld de, #4000
	call zapili4.start
	pop bc
	djnz loop1
loop2

	halt
    	ld de, #4000
	call zapili4.start

	halt
    	ld de, #4000
	call zapili4.start

	call rl0
	jr loop2

rl0  
	ld b, #40
	call rl1

	ld b, #48
	call rl1

	ld b, #50

rl1
	call rnd16
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

	module zapili4
start	include "zapili4/player.asm"
	endmodule
