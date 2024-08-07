	; define _INTRO_DEBUG_ 
	define _INTRO_MUSIC_
	; define _NOPAUSE_

	di

	; ld a, %00000101 : ld (PT3PLAY+10), a 
	call PT3PLAY
	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	ifndef _NOPAUSE_ : ld b, 150 : halt : djnz $-1 : endif

	call displayBG

	; ld hl, 0 : ld de, #4000 : ld bc, #1b00 : ldir
	ifndef _NOPAUSE_ : ld b, 200 : halt : djnz $-1 : endif

	call printText

	ifndef _NOPAUSE_ : ld b, 250 : halt : djnz $-1 : endif

	call fadeScreen

	; jr $

	ifndef _NOPAUSE_ : ld b, 86 : halt : djnz $-1 : endif

	di

	jp PT3PLAY + 8	

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy
	ifdef _INTRO_DEBUG_ : ld a, #01 : out (#fe), a : endif ; debug

	ifdef _INTRO_MUSIC_
	call PT3PLAY + 5	
	endif

	ifdef _INTRO_DEBUG_ : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

	include "bg.asm"
	include "text.asm"

PT3PLAY	include "lib/PTxPlay.asm"
	ifdef _INTRO_MUSIC_
	incbin "res/t1.pt3"
	endif