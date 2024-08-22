	define CHE_TABLES #bb00	; адрес, с которого начинаются таблицы плеера (1к)
	define COLOR1_DEFAULT #07
	define COLOR2_DEFAULT #47

	jp init
	jp chnk_main.INC_BRGHT 	; $+3
	jp chnk_main.DEC_BRGHT 	; $+6
	jp blink 		; $+9

	; $+12
	; interrupts proc
	; выбираем цвет, которым отображать фрейм (в зависимости от текущего экрана)
	ld a, (lib.CUR_SCREEN) : cp %00001101 : jr z, 1f
	ld a, (COLOR1) : jr 2f
1	ld a, (COLOR2) 
2	ld (chnk_main.CUR_ATTR), a

	call chnk_main.PLAY
	jp lib.SwapScreen

init	ld a, COLOR1_DEFAULT : call setScreenAttrA
	call lib.SwapScreen
	ld a, COLOR2_DEFAULT : call setScreenAttrA

	; player initalization
	ld a, %11000000		; screen in #c000 / animation bright = 0
	ld hl, CHNK_START	; animation start
	ld de, CHNK_END		; animation end
	jp chnk_main.INIT	

	; change color
blink	ld a, #42 : ld (COLOR1), a
	ld a, #42 : ld (COLOR2), a

	halt : halt : halt : halt

	; restore color
	ld a, COLOR1_DEFAULT : ld (COLOR1), a
	ld a, COLOR2_DEFAULT : ld (COLOR2), a

	ret

	; два цвета, раздельные для каждого экрана
COLOR1	db COLOR1_DEFAULT
COLOR2	db COLOR2_DEFAULT

setScreenAttrA	ld hl, #d800 : ld de, #d801 : ld bc, #02ff : ld (hl), a : ldir : ret
	; таблица яркостей
BRIGHT_TABLE	include "lib/chunks.bright.table.asm"
		
	; таблица чанков
	align #100
CHUNK_SRC	include "lib/chunks.src.table.alt.asm"

	module chnk_main
	include "lib/chunks.player-attr.asm"
	endmodule

CHNK_START	include "res/parsed-2s-attr.asm"
CHNK_END