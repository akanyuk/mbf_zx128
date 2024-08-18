	jp dispPic1
	jp dispPic2
	jp dispPic3
	jp dispPic4
	; pic 5
	ld hl, PIC5
	ld de, #4000
	jp lib.Depack

dispPic1	ld hl, PIC1
	ld de, #4000
	jp lib.Depack

dispPic2	ld hl, PIC2
	ld de, #4000
	jp lib.Depack

dispPic3	ld hl, PIC3
	ld de, #4000
	jp lib.Depack

dispPic4	ld hl, PIC4
	ld de, #4000
	jp lib.Depack

PIC1	incbin "res/1.scr.zx0"
PIC2	incbin "res/2.scr.zx0"
PIC3	incbin "res/3.scr.zx0"
PIC4	incbin "res/4.scr.zx0"
PIC5	incbin "res/5.scr.zx0"
