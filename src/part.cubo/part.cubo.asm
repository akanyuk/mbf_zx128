	jp start
;	jp init
init	call KUBOGEN
	jp KUBOC_DECRUNCH

PEAKS	db 20,-20,-20
	db 20, 20,-20
	db -20,-20,-20
	db -20, 20,-20
	db 20,-20, 20
	db 20, 20, 20
	db -20,-20, 20
	db -20, 20, 20
NO_PEAKS 	equ ($-PEAKS) / 3

EDGES	db 0*3,1*3
	db 0*3,2*3
	db 1*3,3*3
	db 3*3,2*3
	db 0*3,4*3
	db 1*3,5*3
	db 3*3,7*3
	db 2*3,6*3
	db 4*3,5*3
	db 4*3,6*3
	db 5*3,7*3
	db 6*3,7*3
NO_EDGES	equ ($-EDGES) / 2

start	call KUBOCLEAN
	jp KUBODRAW

KUBOCLEAN	; next kubo
	ld hl, (ALPHA)
	inc l
	inc h : inc h : inc h
	ld (ALPHA), hl

	; clear 1/8 KUBO
	ld a, l
	and #07 : inc a
	ld hl, KUBOC1 - KUBOC_LEN
	ld de, KUBOC_LEN
	add hl, de
	dec a 
	jr nz, $-2
	jp (hl)

KUBODRAW	
PEAKS_SET	ld b, NO_PEAKS
	ld hl, PEAKS
	ld iy, PEAKS_TMP
ROTATE_PEAKS	push bc
	ld d,(hl)
	inc hl
	ld e,(hl)
	inc hl
	ld b,(hl)
	inc hl
	push hl

ROTATE	ld h, SINUSTAB/256
	ld a,e
	exx
	ld hl, ALPHA
	call COORDINATE
	ld e,a
	ld a,d
	exx
	ld hl, BETA
	call COORDINATE

	ld (iy+0), a
	ld (iy+1), e
	ld (iy+2), b
	ld de, 3
	add iy,de
	pop hl
	pop bc
	djnz ROTATE_PEAKS

EDGES_SET	ld a, NO_EDGES
	ld hl, EDGES
DRAW_EDGES 	ex af, af'
	ld a, (hl)
	inc hl
	ld c, (hl)
	inc hl
	push hl
	ld b, 0
	ld hl, PEAKS_TMP
	add hl, bc
	ld d, (hl)
	inc hl
	ld e, (hl)
	ld hl, 97*256 + 127	; x*y
	push hl	;->
	add hl, de
	ex de, hl
	ld c, a
	ld hl, PEAKS_TMP
	add hl, bc
	ld a, (hl)
	inc hl
	ld l, (hl)
	ld h, a
	pop bc	;<-
	add hl, bc
	call LINE
	pop hl
	ex af,af'
	dec a
	jr nz, DRAW_EDGES
	ret

	; Draw line
	; hl:	x1, y1
	; de:	x2, y2
	; Coordinates start from top left corner
LINE	ld ixl, 3	; line "density"
R_LINE 	ld a, l
	add a, e
	rra
	ld c, a
	exx
	ld l, a
	exx
	ld a, h
	add a, d
	rra
	ld b,a
	exx
	ld c,a

	ld h, PLOTTAB/256
	ld b, PLOTTAB/256 + 2
	ld a,(bc)
	inc b
	add a,(hl)
	inc h
	ld h,(hl)
	ld l,a
	ld a,(bc)
	or (hl)
	ld (hl),a

	exx
	dec ixl
	ret z

	push bc
	push de
	ld d,b
	ld e,c
	call R_LINE
	inc ixl
	pop hl
	pop de
	call R_LINE
	inc ixl
	ret

FORMULA 	exx
	ld l, a
	add a, 64
	ld c, a
	ld a, (hl)
	exx
	ld c, a
	call MULTI
	ld a, b
	ex af, af'
	exx 
	ld l, c
	ld a, (hl)
	exx
	ld c, a
	ld b, ixl
	call MULTI
	ex af, af'
	add a, b
	ret

MULTI	ld h, SqrTab/256
	ld d, h
	ld a, b
	add a, c
	ld l, a
	ld a, b
	sub c
	ld e, a
	ld a, (de)
	sub (hl)
	ld c, a
	inc h
	inc d
	ld a, (de)
	sbc a, (hl)
	ld b, a
	ret

COORDINATE	exx
	ld ixl,a
	ld a,b
	exx
	ld b,a
	ld a, (hl)
	push hl
	call FORMULA
	pop hl
	exx 
	push af
	ld a, ixl
	neg
	ld ixl, b
	exx
	ld b, a
	ld a, (hl)
	call FORMULA
	exx
	ld b,a
	pop af
	ret


	; decrunch KUBO cleaner
KUBOC_DECRUNCH
	; переносим на место
	ld hl, KUBOC_TPL
	ld de, KUBOC1
	ld bc, KUBOC_LEN
	ldir

	; делаем 7 копий
	ld hl, KUBOC1
	ld de, KUBOC1 + KUBOC_LEN
	ld bc, KUBOC_LEN * 7
	ldir

	// переносим указатель стека
	ld a, #08	
	ld hl, KUBOC1 + 2
	ld de, KUBOC1 + KUBOC_LEN - 3
	ld bc, KUBOC_LEN
1	ld (hl), e : inc hl : ld (hl), d : dec hl
	add hl,bc : ex de,hl : add hl,bc : ex de,hl
	dec a : jr nz, 1b

	; выставляем адреса
	ld de, #405a
	ld hl, KUBOC1 + 8
	ld a, #08

1	push af
	push de,hl
	ld a, 19
	ld bc, 12
2	ex af, af'
	ld (hl), e : inc hl : ld (hl), d
	add hl, bc

	; next 8 screen line address
	ld a,e : add a,32 : ld e,a : jr nc,$+6 : ld a,d : add 8 : ld d,a
	
	ex af, af'
	dec a : jr nz, 2b
 
 	pop hl,de
 	ld bc, KUBOC_LEN
 	add hl, bc
 	
	; next screen line address
	inc d : ld a,d : and 7 : jr nz,$+12 : ld a,e : add a,32 : ld e,a : jr c,$+6 : ld a,d : sub 8 : ld d,a

 	pop af
 	dec a : jr nz, 1b

	ret

KUBOC_TPL	ld (#0000),sp
	ld hl, #0000
	dup 19
	ld sp, #0000
	dup 10 : push hl : edup
	edup
	ld sp, #0000
	ret
KUBOC_LEN 	equ $ - KUBOC_TPL

KUBOGEN	ld de, #4000
	ld l,e
	ld c,10000000b

CREATEPTAB 	ld h,PLOTTAB/256
	ld (hl),e
	inc h
	ld (hl),d
	inc h
	ld a,l
	rra
	rra
	rra
	and 31
	ld (hl),a
	inc h
	ld (hl),c
	rrc c
DOWNDE	inc d
	ld a,d
	and 7
	jr nz,DOWNDE2
	ld a,e
	sub 224
	ld e,a
	sbc a,a
	and 248
	add a,d
	ld d,a
DOWNDE2	inc l
	jr nz,CREATEPTAB

	ld b,l	;sin(x-2*p)
	ld c,l
	ld hl,SINUSTAB+127	;SINUS GENERATOR
	ld (hl),b
	dec l
	ld de,402	;sin(x-p)
	ld (hl),d
	dec l

GEN_SIN	push hl
	push bc
	ld hl,0
	exx 
	ld hl,65519	;cos(p)

MPLY	ld b, 16	;*hl - a
MULTIPL	add hl, hl	;*hl' - 0
	exx		; de' - b
	jr nc, MULTI_NO_ADD	;*bc',hl'=a*b
	xor a	;* - reg. change
	add hl, de
	adc a, c
	ld c, a
	ld a, b
	adc a, 0
	ld b, a
MULTI_NO_ADD	add hl, hl
	rl c
	rl b
	exx
	djnz MULTIPL
	exx
	ld l, c
	ld h, b
	pop bc
	sbc hl, bc	;hl=sin(x)
	ld c, e
	ld b, d
	ex de, hl
	pop hl
	ld (hl), d
	dec l
	jp p, GEN_SIN
	inc l
	ld de, SINUSTAB+128
GEN_SIN_NEG	ld a, (hl)
	neg 
	ld (de), a
	inc l
	inc e
	jr nz, GEN_SIN_NEG

	ld hl, SqrTab	; must be a multiple of 256
	ld b,l
	ld c,l	; BC holds odd numbers
	ld d,l
	ld e,l	; DE holds squares

SqrGen	ld (hl), e
	inc h
	ld (hl), d	; store x^2
	ld a, l
	neg
	ld l, a
	ld (hl), d
	dec h
	ld (hl), e	; store -x^2
	ex de, hl
	inc c
	add hl, bc	; add next odd number
	inc c
	ex de, hl
	cpl 	; one byte replacement for NEG, DEC A
	ld l, a
	rla
	jr c, SqrGen
	ret

	; KUBO buffers	
	align #100
PLOTTAB 	ds 4*256
SINUSTAB	ds 256
SqrTab	ds 512
PEAKS_TMP 	ds NO_PEAKS*3
ALPHA	db	0	
BETA	db	0
KUBOC1	ds KUBOC_LEN * 8
