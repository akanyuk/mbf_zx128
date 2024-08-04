	jp doStart

box1cnt	ld a, 1 : nop : and 7 : ld (box1cnt + 1), a : or a : jr nz, .box1skp
	ld de, #4000
	call box01
.box1skp

box2cnt	ld a, 1 : nop : and 3 : ld (box2cnt + 1), a : or a : jr nz, .box2skp
	ld de, #4000 + 11
	call box02
.box2skp

box3cnt	ld a, 1 : nop : and 3 : ld (box3cnt + 1), a : or a : jr nz, .box3skp
	ld de, #4000 + 22
	call box04
.box3skp

box4cnt	ld a, 1 : nop : and 7 : ld (box4cnt + 1), a : or a : jr nz, .box4skp
	ld de, #4800
	call box05
.box4skp

box5cnt	ld a, 1 : nop : cp 5 : jr nz, $+3 : xor a : ld (box5cnt + 1), a : jr nz, .box5skp
	ld de, #4800 + 11
	call box08
.box5skp

box6cnt	ld a, 1 : nop : and 7 : ld (box6cnt + 1), a : or a : jr nz, .box6skp
	ld de, #4800 + 22
	call box03
.box6skp
	ret

doStart	dec a : add a : ld e, a : ld d, 0
	ld hl, startAddr : add hl, de
	ex de, hl
	ld a, (de) : ld l, a
	inc de
	ld a, (de) : ld h, a
	jp (hl)

startAddr	dw startBox1, startBox2, startBox3, startBox4, startBox5, startBox6

startBox1	ld hl, #4000 
	call _prepareScr
	ld hl, box1cnt + 2
	ld de, #5800
	jr _start

startBox2	ld hl, #4000 + 11 
	call _prepareScr
	ld hl, box2cnt + 2
	ld de, #5800 + 11
	jr _start

startBox3	ld hl, #4000 + 22
	call _prepareScr
	ld hl, box3cnt + 2
	ld de, #5800 + 22
	jr _start

startBox4	ld hl, #4860
	call _prepareScr
	ld hl, box4cnt + 2
	ld de, #5960
	jr _start

startBox5	ld hl, #4860 + 11
	call _prepareScr
	ld hl, box5cnt + 2
	ld de, #5960 + 11
	jr _start

startBox6	ld hl, #4860 + 22
	call _prepareScr
	ld hl, box6cnt + 2
	ld de, #5960 + 22
	jr _start

_prepareScr	ld d, h : ld e, l : inc de
	ld a, 80
1	push af
	push hl
	push de
	ld bc, 9
	ld (hl), 0
	ldir
	pop de
	call lib.DownDE
	pop hl
	call lib.DownHL
	pop af
	dec a : jr nz, 1b
	ret
_start	ld a, #3c ; inc a
	ld (hl), a
	ex de, hl
	ld de, #0020
	ld a, 10
1	ld b, 10
	push hl
	ld (hl), %01111000 : inc hl
	djnz $-3
	pop hl 
	add hl, de
	dec a : jr nz, 1b
	ret

box01	module box01
	include "01/player.asm"
	endmodule

box02	module box02
	include "02/player.asm"
	endmodule	

box04	module box04
	include "04/player.asm"
	endmodule		

; 2nd line

box05	module box05
	include "05/player.asm"
	endmodule		

box08	module box08
	include "08/player.asm"
	endmodule		

box03	module box03
	include "03/player.asm"
	endmodule
