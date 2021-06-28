;macros for SNES


;mesen-s can use wdm is as a breakpoint
;for debugging purposes
.macro WDM_BREAK number
	.byte $42, number
.endmacro



.macro A8
	sep #$20
.endmacro

.macro A16
	rep #$20
.endmacro

.macro AXY8
	sep #$30
.endmacro

.macro AXY16
	rep #$30
.endmacro

.macro XY8
	sep #$10
.endmacro

.macro XY16
	rep #$10
.endmacro





; memcpy, block move
;for WRAM to WRAM data transfers (can't be done with DMA)
.macro BLOCK_MOVE  length, src_addr, dst_addr
;mnv changes the data bank register, need to preserve it
	phb
.if .asize = 8
	rep #$30
.elseif .isize = 8
	rep #$30
.endif
	lda #(length-1)
	ldx #.loword(src_addr)
	ldy #.loword(dst_addr)	
;	mvn src_bank, dst_bank
	.byte $54, ^dst_addr, ^src_addr
	plb
.endmacro




.macro DMA_VRAM  length, src_addr, dst_addr
;dst is address in the VRAM
;a should be 8 bit, xy should be 16 bit
	ldx #dst_addr
	stx $2116 ; vram address
	
	lda #1
	sta $4300 ; transfer mode, 2 registers 1 write
			  ; $2118 and $2119 are a pair Low/High
	lda #$18  ; $2118
	sta $4301 ; destination, vram data
	ldx #.loword(src_addr)
	stx $4302 ; source
	lda #^src_addr
	sta $4304 ; bank
	ldx #length
	stx $4305 ; length
	lda #1
	sta $420b ; start dma, channel 0
.endmacro

