	device zxspectrum128

	; define DEBUG 1

PART_START	equ  #7000

	org #6000
start	module lib
	include "../../lib/shared.asm"	
	endmodule

	ei : ld sp, start
	
	xor a : out (#fe), a
	ld a, %00000111 : call lib.SetScreenAttr

	ld de, #4000
	call part4slowIterr

	ld de, #4010
	call part4slowIterr

	ld de, #4800
	call part4slowIterr

	ld de, #4810 
	call part4slowIterr

	ld de, #5000
	call part4slowIterr

	ld de, #5010
	call part4slowIterr

	jr $

part4slowIterr	ld b, 32
1	push bc
	push de
	halt
	call PART_START
	pop de
	pop bc 
	djnz 1b
	ret

	org PART_START
	include "part.4slow.asm"

	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
