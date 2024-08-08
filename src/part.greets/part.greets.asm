	jp main

	ld hl, BG
	ld de, #4000
	call lib.Depack

	ld hl, GREETS_HDR
	ld de, #4000
	jp lib.PrintText

main	ld ix, ERR_MV - 2
1	inc ix : inc ix
	ld a, (ix + 1) : or a : ret z
	ld h, a
	ld a, (ix + 0)
	ld l, a
	call errMvDo
	jr 1b	
errMvDo	jp (hl)
ERR_MV	dw norm, left, down, right, up, disort1
	dw up, left, up, down, down, disort2, down, norm, right, disort1
	db 0, 0

norm	ld de, #4074
	ld hl, ERROR_TXT
	jp lib.PrintText

disort1	ld hl, #4654
	ld a, 6
1	push af
	push hl
	dup 6
	rr (hl) : rr (hl) : inc hl
	edup
	pop hl
	call lib.DownHL
	pop af
	dec a : jr nz, 1b
	ret	

disort2	ld hl, #4474
	ld a, 6
1	push af
	push hl
	dup 5
	rl (hl) : inc hl
	edup
	pop hl
	call lib.DownHL
	pop af
	dec a : jr nz, 1b
	ret	

left	ld hl, #4654
	ld a, 12
1	push af
	push hl
	dup 7
	rl (hl) : inc hl
	edup
	pop hl
	call lib.DownHL
	pop af
	dec a : jr nz, 1b
	ret	

right	ld hl, #4654
	ld a, 12
1	push af
	push hl
	dup 7
	rr (hl) : inc hl
	edup
	pop hl
	call lib.DownHL
	pop af
	dec a : jr nz, 1b
	ret	

down	ld hl, #4674
	ld de, #4774
	ld a, 10
1	push af
	push hl
	push de
	ld bc, 7
	ldir
	pop de
	call lib.UpDE
	pop hl
	call lib.UpHL
	pop af
	dec a : jr nz, 1b
	ret

up	ld hl, #4074
	ld de, #4754
	ld a, 9
1	push af
	push hl
	push de
	ld bc, 7
	ldir
	pop de
	call lib.DownDE
	pop hl
	call lib.DownHL
	pop af
	dec a : jr nz, 1b
	ret

GREETS_HDR	db "GREETS PART", 0
ERROR_TXT	db " ERROR ", 0

BG	incbin "res/house-1-1.scr.zx0"
