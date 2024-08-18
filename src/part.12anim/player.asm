; DE = starting screen address (#4000, #c000, etc...)
play        	ld hl, FRAME_0000
	ld c,(hl) : inc hl	; Screen shift
	ld b,(hl) : inc hl
	ex de, hl
	add hl, bc
	ld b,0
cycle	ld a,(de)  :  inc de
	ld	c,a
	add	a
	jr	nc,2f
	jp m, storeFrame
	; long jump
	ld	a,c
	and	#0f
	add	a,h : ld h,a
	bit	4,c
	jr	z, cycle
	ld	c,#80
	add	hl,bc
	jp	cycle
    
2	jp	m,nearJmp
	inc	c
	ex	de,hl
	ldir
	ex	de,hl
	jp	cycle
    
nearJmp	res	6,c
	inc	c
	add	hl,bc
	jp	cycle
storeFrame	ld (nextFrame + 1), de
        	ret

nextFrame	ld hl, FRAME_0000
	ld a, h : cp high FRAME_END : jr nz, _nf
	ld a, l : cp low FRAME_END : jr nz, _nf
	ld hl, FRAME_0000
_nf	ld (play + 1), hl
	ret

FRAME_0000	include "res/0000.asm"
FRAME_0001	include "res/0001.asm"
FRAME_0002	include "res/0002.asm"
FRAME_0003	include "res/0003.asm"
FRAME_0004	include "res/0004.asm"
FRAME_0005	include "res/0005.asm"
FRAME_0006	include "res/0006.asm"
FRAME_0007	include "res/0007.asm"
FRAME_0008	include "res/0008.asm"
FRAME_0009	include "res/0009.asm"
FRAME_000a	include "res/000a.asm"
FRAME_000b	include "res/000b.asm"
FRAME_000c	include "res/000c.asm"
FRAME_000d	include "res/000d.asm"
FRAME_000e	include "res/000e.asm"
FRAME_000f	include "res/000f.asm"
FRAME_0010	include "res/0010.asm"
FRAME_0011	include "res/0011.asm"
FRAME_0012	include "res/0012.asm"
FRAME_0013	include "res/0013.asm"
FRAME_0014	include "res/0014.asm"
FRAME_0015	include "res/0015.asm"
FRAME_0016	include "res/0016.asm"
FRAME_0017	include "res/0017.asm"
FRAME_END
