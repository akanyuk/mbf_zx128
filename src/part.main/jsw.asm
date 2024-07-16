
jswTest         ld a, 7
	ld de, #4000 - 8
1	push af
	
	ld hl, JSW_DATA1
	call jswSprite
	inc de
	dup 8 : halt : edup

	ld hl, JSW_DATA2
	call jswSprite
	inc de
	dup 8 : halt : edup

	ld hl, JSW_DATA3
	call jswSprite
	inc de
	dup 8 : halt : edup

	ld hl, JSW_DATA2
	call jswSprite
	inc de
	dup 8 : halt : edup

	pop af : dec a : jr nz, 1b
	ret

jswSprite	push de
	ld a, 8
1	push af
	push de
	ld b, 6
2	ld a, (hl)
	call printJswChar
.skipPjsw	djnz 2b
	pop de
	ld a, e : add #20 : ld e, a
	pop af : dec a : jr nz, 1b
	pop de
	ret

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
	inc hl : inc de
	ret 

JSW_DATA1	db 00, 00, 02, 01, 03, 00
	db 00, 00, 05, 04, 04, 00
	db 00, 00, 02, 01, 04, 00
	db 00, 00, 06, 01, 07, 00
	db 00, 00, 01, 02, 01, 00
	db 00, 00, 01, 08, 01, 00
	db 00, 00, 09, 01, 10, 00
	db 00, 00, 00, 01, 07, 00

JSW_DATA2	db 00, 00, 02, 01, 03, 00
	db 00, 00, 05, 04, 04, 00
	db 00, 00, 02, 01, 04, 00
	db 00, 00, 06, 01, 07, 00
	db 00, 00, 01, 01, 01, 00
	db 00, 02, 01, 11, 05, 03
	db 00, 00, 12, 04, 11, 00
	db 00, 00, 01, 08, 01, 07

JSW_DATA3	db 00, 00, 02, 01, 03, 00
	db 00, 00, 05, 04, 04, 00
	db 00, 00, 02, 01, 04, 00
	db 00, 00, 06, 01, 07, 00
	db 00, 06, 01, 01, 01, 07
	db 00, 01, 05, 01, 04, 01
	db 00, 00, 12, 04, 01, 06
	db 00, 02, 11, 00, 02, 04

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
