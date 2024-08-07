	device zxspectrum128

	; define DEBUG 1

	org #6000
start	ei : ld sp, start
	xor a : out (#fe), a

	call PART_START
	
	di : halt

PART_START	include "part.intro.asm"
		
	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
