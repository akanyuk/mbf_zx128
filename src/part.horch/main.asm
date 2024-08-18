	device zxspectrum128

	; define _DEBUG_ 1

PART_START	equ  #7000

	org #6000
start	module lib
	include "../../lib/shared.asm"	
	endmodule

	di : ld sp, start
	
	xor a : out (#fe), a

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	call PART_START

	ld hl, PART_START + 12
	call interrStart

	// fade in	
	ld b, 14
1	push bc
	halt : halt : halt : halt
	call PART_START + 3
	pop bc : djnz 1b

	ld b, 25 : halt : djnz $-1
	call PART_START + 9
	ld b, 25 : halt : djnz $-1
	call PART_START + 9
	ld b, 25 : halt : djnz $-1
	call PART_START + 9
	ld b, 25 : halt : djnz $-1
	call PART_START + 9
	ld b, 25 : halt : djnz $-1

	// fade out	
	ld b, 10
1	push bc
	call interrStop
	halt
	call PART_START + 6
	halt
	ld hl, PART_START + 12
	call interrStart
	halt
	pop bc : djnz 1b

	jr $

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

	org PART_START
	module horch
	include "part.horch.asm"
	endmodule
	
	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
