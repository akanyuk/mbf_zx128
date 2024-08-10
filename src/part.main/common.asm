zap4WithDelay	ld a, 10 
	or a : jp z, zapili4.start
	dec a : ld (zap4WithDelay + 1), a
	ret

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

rndNoiseIterA
1	push bc
	call randomNoiseA
	halt
	halt
	pop bc
	djnz 1b
	ret

randomNoiseA	ld b, #41
	call rl1

	ld b, #49
	call rl1

	ld b, #51
	jr rl1

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

	; Jet Set Willy
	include "jsw.asm"
	
pacman	module pacman
	include "pacman.asm"
	endmodule

enoughtText
	ld hl, ENOUGHT_TXT1
	ld de, #5044
	call lib.PrintText
	ld hl, ENOUGHT_TXT2
	ld de, #5064
	jp lib.PrintText

ENOUGHT_TXT1	db "THAT'S ENOUGH", 0
ENOUGHT_TXT2	db "FOR THIS SCENE", 0

partBoxIteration	
1	push bc
	call EXTERNAL_PARTS_ADDR + 3
	pop bc
	halt
	djnz 1b
	ret

partBoxText
	ld hl, #5ac0
	ld de, #5ac1
	ld bc, #001f
	ld (hl), %01111000
	ldir

	ld hl, PART_BOX_TEXT
	ld de, #50c0
	jp lib.PrintText
PART_BOX_TEXT	db "   WE ALWAYS PUSHING THE BOX    ", 0

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
