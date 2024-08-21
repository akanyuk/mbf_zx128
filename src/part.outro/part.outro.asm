	di

	ifdef _MUSIC_
	call PT3PLAY
	ld a, #01 : ld (MUSIC_STATE), a
	endif

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	ld a, %01000111 : call setScreenAttr

	; jp .skip

	ifndef _NOPAUSE_
	ld hl, (INTS_COUNTER) : ld de, 256 : sbc hl, de : : jr c, $-8
	endif

	call clearScreen
	
	ld hl, partA1.start
	call interrStart
	call printText1

	ld b, 150 : halt : djnz $-1
	call interrStop
	call clearScreen
	ld b, 50 : halt : djnz $-1

	ld hl, partA1.start
	call interrStart
	call printText2

	ld b, 150 : halt : djnz $-1
	call interrStop
	call clearScreen
	ld b, 50 : halt : djnz $-1

	ld hl, partA1.start
	call interrStart
	call printText3

	ld b, 150 : halt : djnz $-1
	call interrStop
	call clearScreen
	ld b, 50 : halt : djnz $-1

	ld hl, partA1.start
	call interrStart
	call printText4
	
	ld hl, (INTS_COUNTER) : ld de, 2048 + 70 : sbc hl, de : : jr c, $-8
	call interrStop
	call clearScreen
	ld hl, partA1.start
	call interrStart
	call printText6

	ld hl, (INTS_COUNTER) : ld de, 2560 - 1 : sbc hl, de : : jr c, $-8
	call interrStop
	call clearScreen

.skip

	ld hl, partA2.start
	call interrStart
	call printText5

	ld hl, (INTS_COUNTER) : ld de, 3225 : sbc hl, de : : jr c, $-8

	ifdef _MUSIC_
	xor a : ld (MUSIC_STATE), a
	call PT3PLAY + 8	
	endif

	jr $

	; Fill screen by color
	; a - attribute color
setScreenAttr	ld hl, #5800 : ld de, #5801 : ld bc, #02ff : ld (hl), a : ldir : ret

clearScreen	ld hl, #4000 : ld de, #4001 : ld bc, #17ff : ld (hl), 0 : ldir : ret

	; запуск нужной процедуры на прерываниях
	; HL - адрес процедура
interrStart	ld de, interrCurrent
	ex de, hl
	ld (hl), #c3 ; jp
	inc hl : ld (hl), e
	inc hl : ld (hl), d
	ret

	; остановка процедуры на прерываниях
interrStop	ld hl, interrCurrent
	ld (hl), #c9 ; ret
	ret

interrCurrent	ret
	nop
	nop

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy
	ifdef _DEBUG_ : ld a, #01 : out (#fe), a : endif ; debug

	ifdef _MUSIC_
MUSIC_STATE	equ $+1	
	ld a, #00 : or a : jr z, $+5
	call PT3PLAY + 5	
	endif

	call interrCurrent

INTS_COUNTER	equ $+1
	ld hl, #0000 : inc hl : ld ($-3), hl

	ifdef _DEBUG_ : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

	include "text.asm"

	ifdef _MUSIC_
PT3PLAY	include "lib/PTxPlay.asm"
	incbin "res/t3.pt3"
	endif

	module partA1
start	include "src/part.outro-a1/part.outro-a1.asm"
	endmodule

	module partA2
start	include "src/part.outro-a2/part.outro-a2.asm"
	endmodule
