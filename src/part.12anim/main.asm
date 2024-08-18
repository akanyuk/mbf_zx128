	device zxspectrum128

	; define DEBUG 1

PART_START	equ  #7000

	org #6000
start	module lib
	include "../../lib/shared.asm"	
	endmodule

	ei : ld sp, start
	
	ld a, %00000111 : call lib.SetScreenAttr

	define PAUSE_IN 4

	ld a, 0 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 1 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 4 : call PART_START

	ld b, 25 : call iteration

	ld a, 2 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 5 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 8 : call PART_START
	
	ld b, 25 : call iteration

	ld a, 3 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 6 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 9 : call PART_START

	ld b, 25 : call iteration

	ld a, 7 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 10 : call PART_START
	ld b, PAUSE_IN : call iteration
	ld a, 11 : call PART_START

	call iteration
	jr $ - 3

iteration	halt
	push bc
	ld a, 1 : out #fe, a
	call PART_START + 3
	ld a, 0 : out #fe, a
	pop bc
	djnz iteration
	ret

	org PART_START
	include "part.12anim.asm"

	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
