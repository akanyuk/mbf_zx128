displayBG
	ld hl, #5800
	ld de, #5801
	ld (hl), l
	ld bc, #02ff
	ldir

	ld hl, BG
	ld de, #4000
	ld bc, #1800
	ldir

	ld a, %00000001 : call copyColor
	ld a, %01000001 : call copyColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, %00000010 : call copyColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, %01000010 : call copyColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, %00000011 : call copyColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, %01000011 : call copyColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, %00000110 : call copyColor

	ifndef _NOPAUSE_ : ld b, 70 : halt : djnz $-1 : endif

	ld a, %01000110 : call copyColor
	
	ret

fadeScreen
	ld a, %00000110 : call fadeColor
	ld a, %01000110 : call fadeColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, %01000011 : call fadeColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld a, %00000011 : call fadeColor

	ifndef _NOPAUSE_ : ld b, 25 : halt : djnz $-1 : endif

	ld a, %01000010 : call fadeColor

	ifndef _NOPAUSE_ : ld b, 25 : halt : djnz $-1 : endif

	ld a, %00000010 : call fadeColor

	ifndef _NOPAUSE_ : ld b, 10 : halt : djnz $-1 : endif

	ld a, %00000001 : call fadeColor
	ld a, %01000001 : call fadeColor

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif
	
	ld a, %00000111 : call fadeColor
	
	ret

copyColor	ld c, a
	ld hl, BG + #1800
	ld de, #5800
1	ld a, (hl) : cp c : jr nz, .skipCC
	ld a, (hl) : ld (de), a
.skipCC	inc hl
	inc de
	ld a, d : cp #5b : jr nz, 1b
	ret

fadeColor	ld c, a
	ld hl, #5800
1	ld a, (hl) : cp c : jr nz, .skipFC
	ld (hl), 0
.skipFC	inc hl
	ld a, h : cp #5b : jr nz, 1b
	ret

BG	incbin "res/1.scr"
