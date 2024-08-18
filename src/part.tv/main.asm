	device zxspectrum128

	; define _NOPAUSE_ 1

PART_START	equ  #7500

	org #6000
start	module lib
	include "../../lib/shared.asm"	
	endmodule

	ei : ld sp, start

	xor a : out (#fe), a
		
1	call PART_START
	ifndef _NOPAUSE_ : ld b, 25 : halt : djnz $-1 : endif

	call PART_START + 3
	ifndef _NOPAUSE_ : ld b, 25 : halt : djnz $-1 : endif

	call PART_START + 6
	ifndef _NOPAUSE_ : ld b, 25 : halt : djnz $-1 : endif

	call PART_START + 9
	ifndef _NOPAUSE_ : ld b, 25 : halt : djnz $-1 : endif

	call PART_START + 12
	ifndef _NOPAUSE_ : ld b, 100 : halt : djnz $-1 : endif

	jr 1b

	org PART_START
	include "part.tv.asm"
	
	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif