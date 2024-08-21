	device zxspectrum128

	; define DEBUG 1

PART_START	equ  #7000

	org #6000
start	module lib
	include "../../lib/shared.asm"	
	endmodule

	ei : ld sp, start
	
	ld a, %00000111 : call lib.SetScreenAttr

1	halt
	halt
	halt
	ld a, 1 : out #fe, a
	call PART_START
	ld a, 0 : out #fe, a
	jr 1b

	org PART_START
	include "part.anim2.asm"

	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
