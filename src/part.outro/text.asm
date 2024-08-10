	define _PRN_TXT_LINE_PAUESE_ 30

printText1	ld hl, TEXT1_1
	ld de, #4846 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT1_2
	ld de, #486d 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT1_3
	ld de, #4889 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT1_4
	ld de, #48a7 
	jp PrintHuman

TEXT1_1	db "YOU HAS BEN WATCHING", 0
TEXT1_2	db "A DEMO", 0
TEXT1_3	db "WITH LONG, BUT", 0
TEXT1_4	db "NOT IMPORTANT NAME", 0

printText2	ld hl, TEXT2_1
	ld de, #4844 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT2_2
	ld de, #486a 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT2_3
	ld de, #4889 
	jp PrintHuman

TEXT2_1	db "ALL PICTURES AND VISUALS", 0
TEXT2_2	db "OF THIS DEMO", 0
TEXT2_3	db "GENERATED BY AI", 0

printText3	ld hl, TEXT3_1
	ld de, #4849 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT3_2
	ld de, #4869 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT3_3
	ld de, #4886 
	call PrintHuman

	ld hl, TEXT3_4
	ld de, #48a8 
	jp PrintHuman

TEXT3_1	db "ALL SOUNDTRACKS", 0
TEXT3_2	db "GENERATED BY AI", 0
TEXT3_3	db "AND CONVERTED TO PT3", 0
TEXT3_4	db "BY AUTOSIRIL TOOL", 0

printText4	ld hl, TEXT4_1
	ld de, #4847 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT4_2
	ld de, #486b 
	call PrintHuman
	ifndef _NOPAUSE_ : ld b, _PRN_TXT_LINE_PAUESE_ : halt : djnz $-1 : endif

	ld hl, TEXT4_3
	ld de, #4888 
	jp PrintHuman

TEXT4_1	db "HUGE PARTS OF CODE", 0
TEXT4_2	db "STOLEN FROM", 0
TEXT4_3	db "PREVIOUS RELEASES", 0

printText5	ld hl, TEXT5_1
	ld de, #4888 
	jp PrintHuman

TEXT5_1	db "HAVE A NICE DAY", 0

; Print zero ended string with font 8х8; human speed;
; HL - Text pointer
; DE - Screen address
PrintHuman 	
1	ld a, (hl)
	or a : ret z
	push af
	ld a,"_"
	call PrintChar_8x8
	pop af
	dec de
	dec hl
	ifndef _NOPAUSE_
	dup 3
	halt
	edup
	endif
	call PrintChar_8x8
	jr 1b

; Print one char with ROM font
; DE - Screen memory address
; A  - char
PrintChar_8x8 	push hl, de, bc
	sub #1f
	ld hl, #3d00 - #08
	ld bc, #08
1	add hl, bc
	dec a
	jr nz, 1b

	dup 8 
	ld a,(hl) : ld (de),a		; normal
	inc d : inc l
	edup 

	pop bc, de, hl
	inc hl : inc de
	ret 
