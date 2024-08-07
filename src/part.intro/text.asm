printText	
	ld hl, #5b00 - #20 : call prepareLineColor
	ld hl, TEXT1 : call PrintHuman

	ifndef _NOPAUSE_ : ld b, 50 : halt : djnz $-1 : endif

	ld hl, #5b00 - #40 : call prepareLineColor
	ld hl, #50e0 : call moveLineUp
	ld hl, TEXT2 : call PrintHuman

	ifndef _NOPAUSE_ : ld b, 36 : halt : djnz $-1 : endif

	ld hl, #5b00 - #60 : call prepareLineColor
	ld hl, #50c0 : call moveLineUp
	ld hl, #50e0 : call moveLineUp
	ld hl, TEXT3 : call PrintHuman

	ret

TEXT1	db "MY THREE BEST FRIENDS", 0
TEXT2	db "CONVERTOR, PARSER AND GENERATOR", 0
TEXT3	db "ALWAYS COME WITH ME", 0

moveLineUp
	ld d, h : ld e, l
	ld bc, -32
	add hl, bc
	ex de, hl
	ld a, 8
1	push af
	push hl
	push de
	ld bc, #0020
	ldir
	pop de
	call DownDE
	pop hl
	call DownHL
	pop af 
	dec a : jr nz, 1b
	ret

prepareLineColor
	ld d, h
	ld e, l
	inc e
	ld (hl), %00000111
	ld bc, #001f
	ldir
	ret

; Print zero ended string with font 8х8; human speed; last screen line
; HL - Text pointer
PrintHuman 	push hl

	; clean screen line
	ld hl, #50e0
	ld a, 8
1	push af
	push hl
	ld d, h : ld e, l : inc e
	ld (hl), 0
	ld bc, #1f
	ldir
	pop hl
	call DownHL
	pop af
	dec a : jr nz, 1b

	ld de, #50e0
	pop hl
1	ld a, (hl)
	or a : ret z
	push af
	ld a,"_"
	call PrintChar_8x8
	pop af
	dec de
	dec hl
	ifndef _NOPAUSE_
	dup 3
	halt
	edup
	endif
	call PrintChar_8x8
	jr 1b

; Print one char with ROM font
; DE - Screen memory address
; A  - char
PrintChar_8x8 	push hl, de, bc
	sub #1f
	ld hl, #3d00 - #08
	ld bc, #08
1	add hl, bc
	dec a
	jr nz, 1b

	dup 8 
	ld a,(hl) : ld (de),a		; normal
	inc d : inc l
	edup 

	pop bc, de, hl
	inc hl : inc de
	ret 

DownHL	inc h : ld a,h : and #07 : ret nz : ld a,l : sub #e0 : ld l,a : sbc a,a : and #f8 : add a,h : ld h,a : ret
DownDE	inc d : ld a,d : and #07 : ret nz : ld a,e : sub #e0 : ld e,a : sbc a,a : and #f8 : add a,d : ld d,a : ret
