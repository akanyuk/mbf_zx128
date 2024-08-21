	device zxspectrum128

	; define _DEBUG_ 1

PART_START	equ  #7000

	org #6000
start	module lib
	include "../../lib/shared.asm"	
	endmodule

	ei : ld sp, start
	
	xor a : out (#fe), a
	ld a, %00000111 : call lib.SetScreenAttr

1	ld b, 16
2	push bc
	halt
	halt
	halt
	halt
	ifdef _DEBUG_ : ld a, 1 : out (#fe), a : endif
	call PART_START
	ifdef _DEBUG_ : xor a : out (#fe), a : endif
	pop bc
	djnz 2b

	ld b, 8 : halt : djnz $-1
	
	jr 1b

	org PART_START
	include "part.outro-a1.asm"

	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
