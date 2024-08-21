	di

	ifdef _MUSIC_
	call PT3PLAY
	ld a, #01 : ld (MUSIC_STATE), a
	endif

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	ld a, %01000111 : call setScreenAttr

	ld hl, a1interr
	call interrStart

	ifndef _NOPAUSE_ : ld b, 150 : halt : djnz $-1 : endif

	call clearScreen
	call printText1
	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif

	call clearScreen
	call printText2
	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif

	call clearScreen
	call printText3
	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif

	call clearScreen
	call printText4
	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif

	call clearScreen
	call printText5

	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif
	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif
	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif
	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif
	ifndef _NOPAUSE_ : ld b, 20 : halt : djnz $-1 : endif

	ifdef _MUSIC_
	xor a : ld (MUSIC_STATE), a
	call PT3PLAY + 8	
	endif

	call interrStop

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

PART_A1	include "src/part.outro-a1/part.outro-a1.asm"

a1interr	ld a, 0 : inc a : and 3 : ld ($-4), a
	or a : ret nz
	jp PART_A1