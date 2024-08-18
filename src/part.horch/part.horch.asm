	define COLOR1_DEFAULT #47

	jp partInit
	jp INC_BRGHT 	; $+3
	jp DEC_BRGHT 	; $+6
	jp partBlink 	; $+9

	; $+12
	; interrupts proc
	ld a, (COLOR1) : ld (CUR_ATTR), a
	jp PLAY

partInit	ld a, COLOR1_DEFAULT : call lib.SetScreenAttr

	; player initalization
	ld a, %01000000		; screen in #c000 / animation bright = 0
	ld hl, data.START	; animation start
	ld de, data.END		; animation end
	jp INIT	

	; change color
partBlink	ld a, #43 : ld (COLOR1), a

	halt : halt : halt : halt

	; restore color
	ld a, COLOR1_DEFAULT : ld (COLOR1), a

	ret

	; два цвета, раздельные для каждого экрана
COLOR1	db COLOR1_DEFAULT

	; таблица яркостей
BRIGHT_TABLE	include "lib/chunks.bright.table.asm"
		
	; таблица чанков
	align #100
CHE_TABLES 	block 512	
CHUNK_SRC	include "lib/chunks.src.table.alt.asm"
	include "lib/chunks.player-attr.asm"

	module data
START	include "res/parsed-2s-attr.asm"
END	endmodule
