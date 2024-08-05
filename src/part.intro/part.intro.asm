	xor a : out (#fe), a
	
	ld hl, BG
	ld de, #4000
	ld bc, #1b00
	ldir
	
	ret	
	
BG	incbin "res/1.scr"