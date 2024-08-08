	; -- Стартовый блок -- 
	; Подгружается в каждом `main.asm` для совпадения адресов библиотечных функций во всех частях
	jp _start

	; Заливка цветом
	; a - цвет атрибута
SetScreenAttr	ld hl, #5800 : ld de, #5801 : ld bc, #02ff : ld (hl), a : ldir : ret


SwapScreen	ld a, (CUR_SCREEN) : xor %00001000 : ld (CUR_SCREEN), a
	or a : jr z, $+4 : sub 2 : add 7
	; устанавливаем страницу, оставляя текущий экран
SetPage	ld (CUR_PAGE), a : ld b, a
	ld a, (CUR_SCREEN) : or b : or %00010000
	ld bc, #7ffd : out (c), a 
	ret
	; a=0 - normal screen
	; a=8 - alt screen
SetScreen	ld (CUR_SCREEN), a : ld b, a 
	ld a, (CUR_PAGE) : or b : or %00010000
	ld bc, #7ffd : out (c), a
	ret
CUR_PAGE	db #00
CUR_SCREEN	db #00

DownDE	inc d : ld a,d : and #07 : ret nz : ld a,e : sub #e0 : ld e,a : sbc a,a : and #f8 : add a,d : ld d,a : ret
DownHL	inc h : ld a,h : and #07 : ret nz : ld a,l : sub #e0 : ld l,a : sbc a,a : and #f8 : add a,h : ld h,a : ret
UpDE	dec d : ld a, d : cpl : and #07 : ret nz : ld a, e : sub #20 : ld e, a : ret c : ld a, d : add a, #08 : ld d,a : ret
UpHL	dec h : ld a, h : cpl : and #07 : ret nz : ld a, l : sub #20 : ld l, a : ret c : ld a, h : add a, #08 : ld h,a : ret

; Print zero ended string with font 8х8
; HL - Text pointer
; DE - Text address
PrintText 	
1	ld a, (hl)
	or a : ret z
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
	ld a, (hl) : ld (de), a
	inc d : inc l
	edup 

	pop bc, de, hl
	inc hl : inc de
	ret 

Depack	include "dzx0_fast.asm"

_start