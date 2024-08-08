	device zxspectrum128
	page 0

	; define _MUSIC_ 
	define _DEBUG_ 

	define P_TRACK 1 ; track and player here
	define EXTERNAL_PARTS_ADDR #7000

	org #6000
page0s	module lib
	include "lib/shared.asm"	
	endmodule

	di : ld sp, page0s

	ld hl, #4000 : ld de, #4001 : ld bc, #1aff : ld (hl), l : ldir

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	xor a : call lib.SetPage
	xor a : call lib.SetScreen
	
	call musicStart

	call partMain

	jr $

musicStart	ifdef _MUSIC_
	ld a, P_TRACK : call lib.SetPage
	call PT3PLAY
	ld a, #01 : ld (MUSIC_STATE), a
	endif
	ret

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
	ld a, #00 : or a : jr z, 1f
	ld a, (lib.CUR_SCREEN) : ld b, a
	ld a, P_TRACK : or b : or %00010000
	ld bc, #7ffd : out (c), a
	call PT3PLAY + 5	
	// Restore page
	ld a, (lib.CUR_SCREEN) : ld b, a 
	ld a, (lib.CUR_PAGE) : or b : or %00010000
	ld bc, #7ffd : out (c), a
1	
	endif

	call interrCurrent

	; ints counter
INTS_COUNTER	equ $+1
	ld hl, #0000 : inc hl : ld ($-3), hl

	ifdef _DEBUG_ : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

partMain	include "part.main/part.main.asm"
	display /d, '[page 0] hole 1: ', EXTERNAL_PARTS_ADDR - $, ' (', $, ')'

	org EXTERNAL_PARTS_ADDR
partCubo	include "part.cubo/part.cubo.asm"
	display /d, '[page 0] hole 2: ', #8c00 - $, ' (', $, ')'

	org #8c00
PART_BOX_PACKED	incbin "build/part.box.bin.zx0"
page0e	display /d, '[page 0] hole 3: ', #ffff - $, ' (', $, ')'

	define _page1 : page 1 : org #c000
page1s	
PT3PLAY	include "lib/PTxPlay.asm"
	incbin "res/t2.pt3"
	module zapili4
start	include "part.main/zapili4/player.asm"
	endmodule
page1e	display /d, '[page 1] free: ', 65536 - $, ' (', $, ')'

	include "src/builder.asm"
