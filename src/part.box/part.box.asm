	jp init

	ld de, #4000
	call box01

	ld de, #4000 + 11
	call box02

	ld de, #4000 + 21
	call box04

	ret

init	
	ld hl, #5800 + 10
	ld de, #20
	ld b, 24
1	ld (hl), 0
	add hl, de
	djnz 1b

	ld hl, #5800 + 20
	ld de, #20
	ld b, 24
1	ld (hl), 0
	add hl, de
	djnz 1b

	ld hl, #5800 + 31
	ld de, #20
	ld b, 24
1	ld (hl), 0
	add hl, de
	djnz 1b

	ld hl, #5940
	ld de, #5941
	ld (hl), 0
	ld bc, #1f
	ldir

	ld hl, #5b00 - 64
	ld de, #5b00 - 63
	ld (hl), 0
	ld bc, #3f
	ldir

	ret

	align #100
	
box01	module box01
	include "01/player.asm"
	endmodule

box02	module box02
	include "02/player.asm"
	endmodule	

box03	module box03
	include "03/player.asm"
	endmodule

box04	module box04
	include "04/player.asm"
	endmodule		