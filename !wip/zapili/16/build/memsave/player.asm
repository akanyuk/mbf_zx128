play	; DE = starting screen address (#4000, #c000, etc...)
        ld	hl,FRAME_0000
        ld	a,h : sub high FRAME_END : or l : sub low FRAME_END
        jr	nz,1f
        ld	hl,FRAME_0000
1	ld	c,(hl)  :  inc hl	; Screen shift
        ld	b,(hl)  :  inc hl
        ex	de,hl
        add	hl,bc
        ld	b,0
cycle	ld	a,(de)  :  inc de
        ld	c,a
        add	a
        jr	nc,2f
        jp	m, nextFrame
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
nextFrame   ld	(play+1),de
        ret

FRAME_0000	include "res/0000.asm"
;FRAME_0001	include "res/0001.asm"
FRAME_0002	include "res/0002.asm"
;FRAME_0003	include "res/0003.asm"
FRAME_0004	include "res/0004.asm"
;FRAME_0005	include "res/0005.asm"
FRAME_0006	include "res/0006.asm"
;FRAME_0007	include "res/0007.asm"
FRAME_0008	include "res/0008.asm"
;FRAME_0009	include "res/0009.asm"
FRAME_000a	include "res/000a.asm"
;FRAME_000b	include "res/000b.asm"
FRAME_000c	include "res/000c.asm"
;FRAME_000d	include "res/000d.asm"
FRAME_000e	include "res/000e.asm"
;FRAME_000f	include "res/000f.asm"
FRAME_0010	include "res/0010.asm"
;FRAME_0011	include "res/0011.asm"
FRAME_0012	include "res/0012.asm"
;FRAME_0013	include "res/0013.asm"
FRAME_0014	include "res/0014.asm"
;FRAME_0015	include "res/0015.asm"
FRAME_0016	include "res/0016.asm"
;FRAME_0017	include "res/0017.asm"
FRAME_0018	include "res/0018.asm"
;FRAME_0019	include "res/0019.asm"
FRAME_001a	include "res/001a.asm"
;FRAME_001b	include "res/001b.asm"
FRAME_001c	include "res/001c.asm"
;FRAME_001d	include "res/001d.asm"
FRAME_001e	include "res/001e.asm"
;FRAME_001f	include "res/001f.asm"
FRAME_0020	include "res/0020.asm"
;FRAME_0021	include "res/0021.asm"
FRAME_0022	include "res/0022.asm"
;FRAME_0023	include "res/0023.asm"
FRAME_0024	include "res/0024.asm"
;FRAME_0025	include "res/0025.asm"
FRAME_0026	include "res/0026.asm"
;FRAME_0027	include "res/0027.asm"
FRAME_0028	include "res/0028.asm"
;FRAME_0029	include "res/0029.asm"
FRAME_002a	include "res/002a.asm"
;FRAME_002b	include "res/002b.asm"
FRAME_002c	include "res/002c.asm"
;FRAME_002d	include "res/002d.asm"
FRAME_002e	include "res/002e.asm"
;FRAME_002f	include "res/002f.asm"
FRAME_0030	include "res/0030.asm"
;FRAME_0031	include "res/0031.asm"
FRAME_0032	include "res/0032.asm"
;FRAME_0033	include "res/0033.asm"
FRAME_0034	include "res/0034.asm"
;FRAME_0035	include "res/0035.asm"
FRAME_0036	include "res/0036.asm"
;FRAME_0037	include "res/0037.asm"
FRAME_0038	include "res/0038.asm"
;FRAME_0039	include "res/0039.asm"
FRAME_003a	include "res/003a.asm"
;FRAME_003b	include "res/003b.asm"
FRAME_003c	include "res/003c.asm"
;FRAME_003d	include "res/003d.asm"
FRAME_003e	include "res/003e.asm"
;FRAME_003f	include "res/003f.asm"
FRAME_0040	include "res/0040.asm"
;FRAME_0041	include "res/0041.asm"
FRAME_0042	include "res/0042.asm"
;FRAME_0043	include "res/0043.asm"
FRAME_0044	include "res/0044.asm"
;FRAME_0045	include "res/0045.asm"
FRAME_0046	include "res/0046.asm"
;FRAME_0047	include "res/0047.asm"
FRAME_0048	include "res/0048.asm"
;FRAME_0049	include "res/0049.asm"
FRAME_004a	include "res/004a.asm"
;FRAME_004b	include "res/004b.asm"
FRAME_004c	include "res/004c.asm"
;FRAME_004d	include "res/004d.asm"
FRAME_004e	include "res/004e.asm"
;FRAME_004f	include "res/004f.asm"
FRAME_0050	include "res/0050.asm"
;FRAME_0051	include "res/0051.asm"
FRAME_0052	include "res/0052.asm"
;FRAME_0053	include "res/0053.asm"
FRAME_0054	include "res/0054.asm"
;FRAME_005f	include "res/005f.asm"
FRAME_END
