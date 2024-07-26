	device zxspectrum128

	; define DEBUG 1

PART_START	equ  #7000

	org #6000
start	module lib
	include "../../lib/shared.asm"	
	endmodule

	ei : ld sp, start
	
	ld a, %00000000 : call lib.SetScreenAttr

	ld a, 2 : call PART_START

	ld b, 150 : call iteration

	ld a, 6 : call PART_START

	ld b, 100 : call iteration

	ld a, 4 : call PART_START

	ld b, 200 : call iteration

	ld a, 3 : call PART_START

	ld b, 30 : call iteration

	ld a, 5 : call PART_START

	ld b, 30 : call iteration

	ld a, 1 : call PART_START

loop	halt
	ld a, 1 : out #fe, a
	call PART_START + 3
	ld a, 0 : out #fe, a
	jr loop

iteration	
1	halt
	push bc
	ld a, 1 : out #fe, a
	call PART_START + 3
	ld a, 0 : out #fe, a
	pop bc
	djnz 1b
	ret

	org PART_START
	module box
	include "part.box.asm"
	endmodule

	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
