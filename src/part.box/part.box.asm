	ld de, #4000
	call box01

	ld de, #4008
	call box02

	ld de, #4010
	call box03

	ld de, #4018
	call box04

	ret

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