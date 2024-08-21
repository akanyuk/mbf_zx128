	ld a, %01000111 : call lib.SetScreenAttr
	xor a : out (#fe), a

	jp .skip

	; zapili4 here
	ld a, 1 : call lib.SetPage

	call horch.init

	ld b, 20 : halt : djnz $-1

	ld a, 4
	ld d, #40
	call jswWalkRight

	ld b, 40 : halt : djnz $-1

	ld a, 3
	ld d, #48
	call jswWalkLeft

	ld b, 40 : halt : djnz $-1

	ld a, 32 : ld (zap4WithDelay + 1), a
	ld hl, zap4WithDelay
	call interrStart

	ld a, 2
	ld d, #50
	call jswWalkRight

	call interrStop

	ld hl, horch.interr
	call interrStart

	ld b, 14
1	push bc
	halt 
	call zapili4.start
	halt 
	call zapili4.start
	halt 
	call zapili4.start
	halt 
	call zapili4.start
	halt 	
	call horch.fadein
	pop bc : djnz 1b

	ld bc, #1003
	call z4Iteration

	call horch.blink

	ld b, 14
1	push bc
	halt 
	call zapili4.start
	halt 
	call zapili4.start
	halt 
	call zapili4.start
	halt 
	call zapili4.start
	call horch.fadeout
	pop bc : djnz 1b
	call interrStop

	ld a, #47 : call lib.SetScreenAttr
	call clearScreen

	call enoughtText

	ld bc, #0802
	call z4Iteration

	call partCubo + 3
	ld hl, partCubo
	call interrStart

	ld b, 70
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

	call pacman
	ld b, 90 : halt : djnz $-1
	call pacman
	ld b, 85 : halt : djnz $-1
	call pacman + 6 ; triple
	ld b, 35 : halt : djnz $-1
	call pacman + 3 ; move back

	; part box depacking
	xor a : call lib.SetPage
	ld hl, PART_BOX_PACKED
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack

	ld b, 64 : halt : djnz $-1
	call interrStop

	; part box
	ld a, 2 : call EXTERNAL_PARTS_ADDR
	ld b, 130 : call partBoxIteration

	ld a, 6 : call EXTERNAL_PARTS_ADDR
	ld b, 115 : call partBoxIteration

	ld a, 4 : call EXTERNAL_PARTS_ADDR
	ld b, 20 : call partBoxIteration

	ld a, 3 : call EXTERNAL_PARTS_ADDR
	ld b, 40 : call partBoxIteration
	
	ld a, 5 : call EXTERNAL_PARTS_ADDR
	ld b, 80 : call partBoxIteration
	
	ld a, 1 : call EXTERNAL_PARTS_ADDR
	ld b, 136 : call partBoxIteration

	call partBoxText

	ld b, 200 : call partBoxIteration

	ld a, %01111000 : call lib.SetScreenAttr

	ld hl, randomNoise
	call interrStart

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld b, 30 : call rndNoiseIterA
	
	call interrStop

	; Part `greets`
	ld a, 1 : call lib.SetPage

	ld a, 7 : out (#fe), a
	ld a, %00111111 : call lib.SetScreenAttr
	halt
	call greets.start + 6
	xor a : out (#fe), a

	ifndef _NOPAUSE_ : ld b, 20 : halt : djnz $-1 : endif

	call greets.start + 3

	ifndef _NOPAUSE_ : ld b, 160 : halt : djnz $-1 : endif

	ld bc, 300
1	push bc
	call greets.start
	pop bc
	dec bc
	ld a, b : or c : jr nz, 1b

	ld hl, randomNoise
	call interrStart

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, 7 : call lib.SetScreenAttr
	ld b, 50 : call rndNoiseIterA

	; Part houses depacking
	xor a : call lib.SetPage
	ld hl, PART_HOUSES_PCK
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack	

	call interrStop

	call clearScreen
	ld a, %01000111 : call lib.SetScreenAttr

	call partHousesDoubleIteration
	ld b, 30 : halt : djnz $-1

	call partHousesDoubleIteration
	ld b, 30 : halt : djnz $-1

	ld a, 1 : call lib.SetPage
	ld hl, zapili4.start
	call interrStart

	ld b, 30 : halt : djnz $-1
	
	ld a, "1"
1	push af

	ld b, 5 : halt : djnz $-1

	ex af, af'
	ld a, %01000111 : call lib.SetScreenAttr
	ex af, af'

	ld b, 5 : halt : djnz $-1

	ld de, #5800
	ld c, %00111000
	call PrintCharAttr

	call partHousesDoubleIteration

	pop af
	inc a : cp "8" : jr nz, 1b

	ld b, 50 : halt : djnz $-1

	ld a, %01000111 : call lib.SetScreenAttr
	
	ld a, "1"
	ld de, #5800
	ld c, %00111000
	call PrintCharAttr

	call partHousesDoubleIteration
	ld b, 30 : halt : djnz $-1

	ld a, %01000111 : call lib.SetScreenAttr

	ld b, 100 : call rndNoiseIterA

	call interrStop
	
	call partTV

	ld b, 50 : halt : djnz $-1
	ld a, %01000111 : call lib.SetScreenAttr

	ld a, 1 : call lib.SetPage
	ld hl, zapili4.start
	call interrStart

	ld b, 100 : call rndNoiseIterA
	call interrStop

	; Part 12anim depacking
	xor a : call lib.SetPage
	ld hl, PART_12ANM_PCK
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack	

	ld hl, EXTERNAL_PARTS_ADDR + 3
	call interrStart
	call part12AnmFlow

	ld b, 50 : halt : djnz $-1

	ld a, 1 : call lib.SetPage

	ld b, 100
1	push bc
	halt
	call zapili4.start
	pop bc
	djnz 1b

	ld b, 100
1	push bc
	halt
	call zapili4.start
	call randomNoise
	call randomNoise
	call randomNoise		
	pop bc
	djnz 1b

	call interrStop

	; Part chunks1 depacking
	ld a, 4 : call lib.SetPage
	ld hl, PART_CHNK1_PCK
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack	
	
	call partChunks1Main

	xor a : call lib.SetScreen
	ld a, 1 : call lib.SetPage
	ld a, #47 : call lib.SetScreenAttr

	ld b, 50
1	push bc
	halt
	call zapili4.start
	call randomNoise
	call randomNoise
	call randomNoise		
	pop bc
	djnz 1b

	xor a : call lib.SetPage
	ld hl, CAT1_PCK
	ld de, #4000
	call lib.Depack	

	ld b, 25 : halt : djnz $-1

	call catText

	ld b, 50
1	push bc
	halt
	call randomNoise
	call randomNoise
	call randomNoise		
	pop bc
	djnz 1b

.skip
	call clearScreen
	ld a, 7 : call lib.SetScreenAttr

	; Part `4slow` depacking
	ld a, 6 : call lib.SetPage
	ld hl, PART_4SLOW_PCK
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack	
	
	ld hl, randomNoiseA
	call interrStart
	ld b, 50 : halt : djnz $-1

	ld a, 1 : call lib.SetPage
	call part4SlowFlow1

	; Part `anima2` depacking
	ld a, 4 : call lib.SetPage
	ld hl, PART_ANM2_PCK
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack	

 	ld b, 30
1	push bc
 	halt
 	halt	
 	call EXTERNAL_PARTS_ADDR
 	pop bc
 	djnz 1b

	; Part `4slow` depacking again
	ld a, 6 : call lib.SetPage
	ld hl, PART_4SLOW_PCK
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack	

	ld a, 1 : call lib.SetPage
	call part4SlowFlow2

	; Part `anima2` depacking again
	ld a, 4 : call lib.SetPage
	ld hl, PART_ANM2_PCK
	ld de, EXTERNAL_PARTS_ADDR
	call lib.Depack	

 	ld b, 30
1	push bc
 	halt
 	call EXTERNAL_PARTS_ADDR
 	pop bc
 	djnz 1b

	ld b, 64 : halt : djnz $-1
	call interrStop
	
	ret
	
	include "common.asm"
