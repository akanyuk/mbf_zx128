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

partHousesDoubleIteration	
	ld b, 16
1	push bc
	call EXTERNAL_PARTS_ADDR
	pop bc
	halt
	djnz 1b

	ld b, 10 : halt : djnz $-1

	ld b, 16
1	push bc
	call EXTERNAL_PARTS_ADDR
	pop bc
	halt
	djnz 1b

	ret

partTV	ld a, 3 : call lib.SetPage
	call tv.start	
	call rndNoiseTV
	call tv.start + 3
	call rndNoiseTV
	call tv.start + 6
	call rndNoiseTV
	call tv.start + 9
	call rndNoiseTV
	call tv.start + 12
	ret

rndNoiseTV
	ld b, 25 : halt : djnz $-1
	ld b, 25
1	push bc
	call randomNoise
	call randomNoise
	call randomNoise		
	pop bc
	halt
	djnz 1b
	ret

partChunks1Main
	call clearScreen
	call EXTERNAL_PARTS_ADDR

	ld hl, EXTERNAL_PARTS_ADDR + 12
	call interrStart

	// fade in	
	ld b, 14
1	push bc
	call interrStop
	halt
	call EXTERNAL_PARTS_ADDR + 3
	halt
	ld hl, EXTERNAL_PARTS_ADDR + 12
	call interrStart
	halt
	halt
	pop bc : djnz 1b

	ld b, 25 : halt : djnz $-1
	call EXTERNAL_PARTS_ADDR + 9
	ld b, 25 : halt : djnz $-1
	call EXTERNAL_PARTS_ADDR + 9
	ld b, 25 : halt : djnz $-1
	call EXTERNAL_PARTS_ADDR + 9
	ld b, 25 : halt : djnz $-1
	call EXTERNAL_PARTS_ADDR + 9
	ld b, 25 : halt : djnz $-1

	// fade out	
	ld b, 10
1	push bc
	call interrStop
	halt
	call EXTERNAL_PARTS_ADDR + 6
	halt
	ld hl, EXTERNAL_PARTS_ADDR + 12
	call interrStart
	halt
	pop bc : djnz 1b

	call interrStop
	ret	

part12AnmFlow	define PART_12ANM_PAUSE_IN 8
	ld a, 0 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 1 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 4 : call EXTERNAL_PARTS_ADDR

	ld b, 25 : halt : djnz $-1

	ld a, 2 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 5 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 8 : call EXTERNAL_PARTS_ADDR
	
	ld b, 25 : halt : djnz $-1

	ld a, 3 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 6 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 9 : call EXTERNAL_PARTS_ADDR

	ld b, 25 : halt : djnz $-1

	ld a, 7 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 10 : call EXTERNAL_PARTS_ADDR
	ld b, PART_12ANM_PAUSE_IN : halt : djnz $-1
	ld a, 11 : call EXTERNAL_PARTS_ADDR

	ret

catText	ld b, 17
	ld de, #4000
	ld hl, CAT_FINE_TEXT
1	push bc
	push hl
	push de
	ld a, (hl)
	call lib.PrintChar_8x8
	halt
	halt
	halt
	pop de
	call downDE8
	pop hl
	inc hl
	pop bc : djnz 1b
	ret
CAT_FINE_TEXT	db "A CAT IS FINE TOO"

part4SlowFlow
	ld de, #4800
	call part4slowIterr

	ld de, #5010
	call part4slowIterr

	ld de, #4000
	call part4slowIterr

	ld de, #4010
	call part4slowIterr

	ld de, #5000
	call part4slowIterr

	ld de, #4810 
	call part4slowIterr

	ret

part4slowIterr	ld b, 48
1	push bc
	push de
	halt
	halt
	call EXTERNAL_PARTS_ADDR
	pop de
	pop bc 
	djnz 1b
	ret

; Print one attribute char with ROM font
; DE - Attributes address
; A  - char
; C  - attribute value
PrintCharAttr 	push bc
	sub #1f
	ld hl, #3d00 - #08
	ld bc, #08
1	add hl, bc
	dec a
	jr nz, 1b
	ex de, hl
	pop bc

	ld b, 8
1	ld a, (de) 

	dup 8
	sla a : jr nc, $ + 3
	ld (hl), c
	inc hl
	edup

	push bc
	ld bc, 24
	add hl, bc
	pop bc

	inc de
	djnz 1b

	ret 

downDE8	ld a, d : add 8 : ld d, a : ld a,e : sub #e0 : ld e,a : sbc a,a : and #f8 : add a,d : ld d,a : ret

clearScreen	ld hl, #4000 : ld de, #4001 : ld bc, #17ff : ld (hl), l : ldir : ret

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
