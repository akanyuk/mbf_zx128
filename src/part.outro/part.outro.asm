	di

	call PT3PLAY
	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	ld a, %01000111 : call setScreenAttr

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

	call PT3PLAY + 8	
	
	jr $

	; Fill screen by color
	; a - attribute color
setScreenAttr	ld hl, #5800 : ld de, #5801 : ld bc, #02ff : ld (hl), a : ldir : ret

clearScreen	ld hl, #4000 : ld de, #4001 : ld bc, #17ff : ld (hl), 0 : ldir : ret

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy
	ifdef _DEBUG_ : ld a, #01 : out (#fe), a : endif ; debug

	ifdef _MUSIC_
	call PT3PLAY + 5	
	endif

	ifdef _DEBUG_ : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

	include "text.asm"

PT3PLAY	include "lib/PTxPlay.asm"
	ifdef _MUSIC_
	incbin "res/t1.pt3"
	endif