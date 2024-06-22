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

_start