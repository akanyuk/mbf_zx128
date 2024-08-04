	ld a, %01000111 : call lib.SetScreenAttr
	
	; zapili4 here
	ld a, 1 : call lib.SetPage

	; jp .skip

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

	ld bc, #1005
	call z4Iteration

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

	ld b, 100
1	push bc
	halt
	call zapili4.start
	halt
	call zapili4.start
	call randomNoise
	pop bc 
	djnz 1b

	ld hl, randomNoise
	call interrStart

	ld a, 31
1	push af
	ld de, #5900
	call pacman
	pop af
	halt	
	dec a : cp -9 : jr nz, 1b

	ld b, 90 : halt : djnz $-1

	ld a, 31
1	push af
	ld de, #5900
	call pacman
	pop af
	halt	
	dec a : cp -9 : jr nz, 1b

	; TODO: one more packman with freezing and moving back

	; part box depacking
	xor a : call lib.SetPage
	ld hl, PART_BOX_PACKED
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack

	ld b, 255 : halt : djnz $-1
	ld b, 100 : halt : djnz $-1
	call interrStop

	; part box
	ld a, 2 : call EXTERNAL_PARTS_ADDR
	ld b, 150 : call partBoxIteration
	ld a, 6 : call EXTERNAL_PARTS_ADDR
	ld b, 100 : call partBoxIteration
	ld a, 4 : call EXTERNAL_PARTS_ADDR
	ld b, 200 : call partBoxIteration
	ld a, 3 : call EXTERNAL_PARTS_ADDR
	ld b, 3 : call partBoxIteration
	ld a, 5 : call EXTERNAL_PARTS_ADDR
	ld b, 3 : call partBoxIteration
	ld a, 1 : call EXTERNAL_PARTS_ADDR
	ld b, 255 : call partBoxIteration

	ld hl, randomNoise
	call interrStart

	jr $

	include "common.asm"
