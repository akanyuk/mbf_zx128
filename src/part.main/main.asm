	ld a, %01000111 : call lib.SetScreenAttr

loop	

	halt
	halt
	halt
    	ld de, #4000
	call zapili4.start

_attrRot	ld hl, 0
	inc hl
	ld (_attrRot + 1), hl

	ld de, #5800
	ld bc, #300

	jr loop

	ret

	module zapili4
start	include "zapili4/player.asm"
	endmodule
