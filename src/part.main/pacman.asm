	jp moveLeft
	jp moveRight
	; triple pacmans
	ld b, 91
1	push bc
	ld hl, TRIPLE_STATE
	ld a, (hl)
	dec (hl)
	inc hl
	push hl
	ld de, #5900
	call main
	pop hl
	ld a, (hl)
	dec (hl)
	inc hl
	push hl
	ld de, #5800
	call main
	pop hl
	ld a, (hl)
	dec (hl)
	ld de, #5a00
	call main
	pop bc
	halt 
	djnz 1b
	ret
TRIPLE_STATE	db 31, 50, 70
moveRight	ld a, -10
1	push af
	ld de, #5900
	call main
	pop af
	halt	
	inc a : cp 32 : jr nz, 1b
	ret

moveLeft	ld a, 31
1	push af
	ld de, #5900
	call main
	pop af
	halt	
	dec a : cp -10 : jr nz, 1b
	ret

main	ex af, af'
.phase	ld a, 0 : inc a : and 3 : ld (.phase+1), a
	ld hl, SPRITE1
	cp 2 : jr c, $+5
	ld hl, SPRITE2
	ld (.sprite + 1), hl
	ex af, af'

	dec a
	push af
	ex af, af'
	pop af
	ex af, af'

	inc a : add e : ld e, a
	
.sprite	ld hl, SPRITE1
	
	ld a, 8
1	push af

	ex af, af'
	ld (.pkmChkOnScr + 1), a
	ex af, af'

	ld b, 10
2	
	; check onscreen
.pkmChkOnScr	ld a, 0 : inc a : ld (.pkmChkOnScr + 1), a
	cp 128 : jr nc, .skipPkmLine
	cp 32 : jr nc, .skipPkmLine

	ld a, (hl)
	ld (de), a
.skipPkmLine	inc hl
	inc e
	djnz 2b

	ex de, hl
	ld bc, 32-10
	add hl, bc
	ex de, hl
	pop af
	dec a : jr nz, 1b

	ret

	define c1 %01000111
	define c2 %01011011

SPRITE1	db c1, c1, c1, c2, c2, c2, c2, c1, c1, c1
	db c1, c1, c2, c2, c2, c2, c2, c2, c1, c1
	db c1, c2, c2, c1, c2, c2, c2, c2, c2, c1
	db c1, c2, c2, c2, c2, c2, c2, c2, c2, c1
	db c1, c2, c2, c2, c2, c2, c2, c2, c2, c1
	db c1, c1, c1, c1, c1, c2, c2, c2, c2, c1
	db c1, c1, c2, c2, c2, c2, c2, c2, c1, c1
	db c1, c1, c1, c2, c2, c2, c2, c1, c1, c1

SPRITE2	db c1, c1, c1, c2, c2, c2, c2, c1, c1, c1
	db c1, c1, c2, c2, c2, c2, c2, c2, c1, c1
	db c1, c2, c2, c1, c2, c2, c2, c2, c2, c1
	db c1, c2, c2, c2, c2, c2, c2, c2, c2, c1
	db c1, c2, c2, c2, c2, c2, c2, c2, c2, c1
	db c1, c1, c1, c1, c1, c2, c2, c2, c2, c1
	db c1, c1, c1, c1, c1, c2, c2, c2, c1, c1
	db c1, c1, c1, c2, c2, c2, c2, c1, c1, c1	