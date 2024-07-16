	; d - hight screen address
	; a - pause between frames
jswWalkRight	ld (jswHalt + 1), a
	ld a, -5
1	
	ld hl, JSW_DATA1
	call jswSprite
	inc a : cp 31 : ret z
	call jswHalt

	ld hl, JSW_DATA2
	call jswSprite
	inc a : cp 31 : ret z
	call jswHalt

	ld hl, JSW_DATA3
	call jswSprite
	inc a : cp 31 : ret z
	call jswHalt

	ld hl, JSW_DATA2
	call jswSprite
	inc a : cp 31 : ret z
	call jswHalt

	jr 1b

	; d - hight screen address
	; a - pause between frames
jswWalkLeft	ld (jswHalt + 1), a
	ld a, 31
1	
	ld hl, JSW_DATA1M
	call jswSprite
	dec a : cp -6 : ret z
	call jswHalt

	ld hl, JSW_DATA2M
	call jswSprite
	dec a : cp -6 : ret z
	call jswHalt

	ld hl, JSW_DATA3M
	call jswSprite
	dec a : cp -6 : ret z
	call jswHalt

	ld hl, JSW_DATA2M
	call jswSprite
	dec a : cp -6 : ret z
	call jswHalt

	jr 1b

jswHalt	ld b, 1 : halt : djnz $-1 : ret

	; a  - x pos
	; d  - screen high addr
	; hl - sprite addr
jswSprite	ld (.jswChkOnScr + 1), a
	push af 
	push de
	
	ld a, 6
1	push af

	; check onscreen
.jswChkOnScr	ld a, 0 : inc a : ld (.jswChkOnScr + 1), a
	cp -6 : jr nc, .skipJswLine2
	cp 32 : jr nc, .skipJswLine

	ld e, a
	push de
	ld b, 8
2	ld a, (hl)
	call printJswChar
	inc hl 
	ld a, e : add #20 : ld e, a
	djnz 2b
	pop de
.skipJswLine	inc e
	pop af : dec a : jr nz, 1b

	pop de
	pop af
	ret
.skipJswLine2	dup 8 : inc hl : edup
	jr .skipJswLine + 1

; Print one char with ROM font
; DE - Screen memory address
; A  - char
printJswChar 	push hl, de, bc
	ld h, 0 : ld l, a
	add hl, hl : add hl, hl : add hl, hl 
	ld bc, JSW_SPRITES
	add hl, bc

	dup 7 
	ldi : dec de : inc d
	edup 
	ldi

	pop bc, de, hl
	ret 

JSW_DATA1	db 00, 00, 00, 00, 00, 00, 00, 00
	db 00, 00, 00, 00, 00, 00, 00, 00
	db 02, 05, 02, 06, 01, 01, 09, 00
	db 01, 04, 01, 01, 02, 08, 01, 01
	db 03, 04, 04, 07, 01, 01, 10, 07
	db 00, 00, 00, 00, 00, 00, 00, 00

JSW_DATA1M	db 00, 00, 00, 00, 00, 00, 00, 00
	db 02, 05, 05, 06, 01, 01, 09, 00
	db 01, 05, 01, 01, 03, 13, 01, 01
	db 03, 04, 03, 07, 01, 01, 10, 00
	db 00, 00, 00, 00, 00, 00, 00, 00
	db 00, 00, 00, 00, 00, 00, 00, 00

JSW_DATA2	db 00, 00, 00, 00, 00, 00, 00, 00
	db 00, 00, 00, 00, 00, 02, 00, 00
	db 02, 05, 02, 06, 01, 01, 12, 01
	db 01, 04, 01, 01, 01, 11, 04, 08
	db 03, 04, 04, 07, 01, 05, 11, 01
	db 00, 00, 00, 00, 00, 03, 00, 07

JSW_DATA2M	db 00, 00, 00, 00, 00, 02, 00, 06
	db 02, 05, 05, 06, 01, 04, 12, 01
	db 01, 05, 01, 01, 01, 12, 05, 13
	db 03, 04, 03, 07, 01, 01, 11, 01
	db 00, 00, 00, 00, 00, 03, 00, 00
	db 00, 00, 00, 00, 00, 00, 00, 00
	
JSW_DATA3	db 00, 00, 00, 00, 00, 00, 00, 00
	db 00, 00, 00, 00, 06, 01, 00, 02
	db 02, 05, 02, 06, 01, 05, 12, 11
	db 01, 04, 01, 01, 01, 01, 04, 00
	db 03, 04, 04, 07, 01, 04, 01, 02
	db 00, 00, 00, 00, 07, 01, 06, 04

JSW_DATA3M	db 00, 00, 00, 00, 06, 01, 07, 05
	db 02, 05, 05, 06, 01, 05, 01, 03
	db 01, 05, 01, 01, 01, 01, 05, 00
	db 03, 04, 03, 07, 01, 04, 11, 12
	db 00, 00, 00, 00, 07, 01, 00, 03
	db 00, 00, 00, 00, 00, 00, 00, 00

	; 0
JSW_SPRITES	db %00000000
	db %00000000
	db %00000000
	db %00000000
	db %00000000
	db %00000000
	db %00000000
	db %00000000	

	; 1
	db %11111111
	db %11111111
	db %11111111
	db %11111111
	db %11111111
	db %11111111
	db %11111111
	db %11111111	

	; 2
	db %00001111
	db %00001111
	db %00001111
	db %00001111
	db %00001111
	db %00001111
	db %00001111
	db %00001111

	; 3
	db %11110000
	db %11110000
	db %11110000
	db %11110000
	db %11110000
	db %11110000
	db %11110000
	db %11110000

	; 4
	db %11111111
	db %11111111
	db %11111111
	db %11111111
	db %11110000
	db %11110000
	db %11110000
	db %11110000

	; 5
	db %11111111
	db %11111111
	db %11111111
	db %11111111
	db %00001111
	db %00001111
	db %00001111
	db %00001111

	; 6
	db %00000000
	db %00000000
	db %00000000
	db %00000000
	db %00001111
	db %00001111
	db %00001111
	db %00001111

	; 7
	db %00000000
	db %00000000
	db %00000000
	db %00000000
	db %11110000
	db %11110000
	db %11110000
	db %11110000

	; 8
	db %00001111
	db %00001111
	db %00001111
	db %00001111
	db %11110000
	db %11110000
	db %11110000
	db %11110000

	; 9
	db %00001111
	db %00001111
	db %00001111
	db %00001111
	db %00000000
	db %00000000
	db %00000000
	db %00000000

	; 10
	db %11110000
	db %11110000
	db %11110000
	db %11110000
	db %00000000
	db %00000000
	db %00000000
	db %00000000

	; 11
	db %11110000
	db %11110000
	db %11110000
	db %11110000
	db %11111111
	db %11111111
	db %11111111
	db %11111111

	; 12
	db %00001111
	db %00001111
	db %00001111
	db %00001111
	db %11111111
	db %11111111
	db %11111111
	db %11111111

	; 13
	db %11110000
	db %11110000
	db %11110000
	db %11110000
	db %00001111
	db %00001111
	db %00001111
	db %00001111
