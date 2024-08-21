	device zxspectrum128

	define _DEBUG_ 
	define _MUSIC_
	; define _NOPAUSE_

	org #6000
start	ei : ld sp, start
	ld a, 1 : out (#fe), a

	jp PART_START

PART_START	include "part.outro.asm"
	
	display /d, 'Part length: ', $ - PART_START
	display /d, 'Part free: ', 65536 - $, ' (', $, ')'

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
