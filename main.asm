; example 13 SNES code

.p816
.smart



.include "regs.asm"
.include "variables.asm"
.include "macros.asm"
.include "init.asm"
.include "library.asm"
.include "MUSIC/music.asm"





.segment "CODE"

; enters here in forced blank
Main:
.a16 ; the setting from init code
.i16
	phk
	plb
	
	
; COPY PALETTES to PAL_BUFFER	
;	BLOCK_MOVE  length, src_addr, dst_addr
	BLOCK_MOVE  512, BG_Palette, PAL_BUFFER
	A8 ;block move will put AXY16. Undo that.
	
; DMA from PAL_BUFFER to CGRAM
	jsr DMA_Palette ; in init.asm
	
	
; DMA from Tiles to VRAM	
	lda #V_INC_1 ; the value $80
	sta VMAIN  ; $2115 = set the increment mode +1

	DMA_VRAM  (End_BG_Tiles - BG_Tiles), BG_Tiles, $0000
	
	
; DMA from Spr_Tiles to VRAM $4000
	
	DMA_VRAM  (End_Spr_Tiles - Spr_Tiles), Spr_Tiles, $4000
	
	
; DMA from Map1 to VRAM	$6000 
	
	DMA_VRAM  $700, Map1, $6000



	
	

	lda #1 ; mode 1, tilesize 8x8 all
	sta BGMODE ; $2105
	
	stz BG12NBA ; $210b BG 1 and 2 TILES at VRAM address $0000
	
	lda #$60 ; bg1 map at VRAM address $6000
	sta BG1SC ; $2107
	
	lda #$68 ; bg2 map at VRAM address $6800
	sta BG2SC ; $2108
	
	lda #$70 ; bg3 map at VRAM address $7000
	sta BG3SC ; $2109	
	
	lda #2 ;sprite tiles at $4000
	sta OBSEL ;= $2101

;allow everything on the main screen	
	lda #BG1_ON|SPR_ON ; $11
	sta TM ; $212c
	
	
	AXY16	
;copy the music code and samples to the Audio RAM	
	lda #.loword(music_code)
	ldx #^music_code
	jsl SPC_Init

	
;A way to patch in a custom FIR filter...
;do it AFTER SPC_Init
;SPC_Load_Data is expecting stack relative arguments.

;5 = addr in apu, last pha
;7 = size
;9 = src l
;11 = src h
;Patch_FIR:
;interrupts off, song off
;	AXY16
;	jsl Music_Stop
;	lda #SCMD_LOAD
;	sta gss_command
;	stz gss_param
;	jsl SPC_Command_ASM
;
;	tsx
;	stx save_stack
;	lda #^TEST_FIR ;source bank
;	pha
;	lda #.loword(TEST_FIR) ;source address
;	pha
;	lda #8 ;size
;	pha
;	lda #$03aa ;SPC address to patch (= the FIR table)
;	pha
;	jsl SPC_Load_Data
;	ldx save_stack
;	txs
; now set the FIR filter to the 0th one, and it will
; copy your patch to the DSP processor
;	lda #0 ;FIR set 0
;	ldx #$40 ;echo feedback volume (0-7f)
;	jsl Echo_Fb_Fir
	
	
	
	
	AXY16
	lda #$0001
	jsl SPC_Stereo
	
	
	
;nmi's should be off when loading data to the spc
	
	AXY8 ;could be 16, but the arguments are 8 bit, so this is better.
	
;make sure echo and song stopped when changing echo address
	jsl Sound_Stop_All
	
	lda #$0 ;echo off
	ldx #$0 ;no channels on
	jsl Echo_Vol
	
;echo vol MUST be off when changing the echo buffer address	
	lda #$ef ;echo buffer start address at $ef00
	ldx #2 ;size x $800 = $1000 byte buffer
	jsl Echo_Addr
;this also takes a while to do	
;echo buffer will use $ef00-feff of the SPC RAM with these settings
	
;turn on the echo volume
	lda #$40 ;echo volume (0-7f)
	ldx #$3f ;channels 1-6
	jsl Echo_Vol
	
;and set the feedback and FIR filter
	lda #0 ;FIR set 0 = simple echo
	ldx #$40 ;echo feedback volume (0-7f)
	jsl Echo_Fb_Fir
	
	
;copy the song data to the Audio RAM, and start it.	
	AXY16
	;a = address of song
	;x = bank of song
	lda #.loword(song1)
	ldx #^song1
	jsl SPC_Play_Song
	
	
	A8
	;turn on NMI interrupts and auto-controller reads
	lda #NMI_ON|AUTO_JOY_ON
	sta NMITIMEN ;$4200
	
	lda #FULL_BRIGHT ; $0f = turn the screen on, full brighness
	sta INIDISP ; $2100
	sta bright_var



	lda #$68
	sta cube_x
	sta cube_y
	
	
	
Infinite_Loop:	
;game loop a8 xy16
	A8
	XY16
	jsr Wait_NMI ;wait for the beginning of v-blank
	jsr DMA_OAM  ;copy the OAM_BUFFER to the OAM
	
	lda bright_var
	sta INIDISP ; $2100
	
	jsr Pad_Poll ;read controllers
	jsr Clear_OAM

	
	
	A8
	stz cube_x_sp ;speed zero by default
	stz cube_y_sp
	
	
;handle button presses	
	AXY16
	lda pad1
	and #KEY_LEFT
	beq @not_left

	A8
	lda #$ff ;-1
	sta cube_x_sp
	lda #FACE_LEFT
	sta cube_dir	
	A16
	
@not_left:

	lda pad1
	and #KEY_RIGHT
	beq @not_right
	A8
	lda #1
	sta cube_x_sp
	lda #FACE_RIGHT
	sta cube_dir	
	A16
	
@not_right:
	
	
	
	lda pad1
	and #KEY_UP
	beq @not_up
	A8
	lda #$ff ;-1
	sta cube_y_sp
	A16
	
@not_up:

	lda pad1
	and #KEY_DOWN
	beq @not_down
	A8
	lda #1
	sta cube_y_sp	
	A16
	
@not_down:
	
	
;save previous
	A8
	lda cube_x
	sta cube_x_old
	lda cube_y
	sta cube_y_old
	
X_Move:	
;handle x movement first
	lda cube_x
	clc
	adc cube_x_sp
	sta cube_x
;min max	
	lda cube_x
	cmp #241
	bcc @ok
	lda cube_x_old
	sta cube_x
	jmp Y_Move
@ok:	
	
;skip if no x move
	lda cube_x_sp
	beq Y_Move

;make a hitbox a little smaller than the object	
	A8
	jsr Load_Hitbox
	
;check collision, then revert if yes
	AXY8
	lda cube_x_sp ;which way are we going?
	bpl @right
@left:
;check 2 points on the left
	ldx obj_left
	ldy obj_top
	jsr Hit_BG
	cmp #1
	beq @handle_collision
	ldx obj_left
	ldy obj_bottom
	jsr Hit_BG
	cmp #1
	beq @handle_collision
	bra Y_Move
	
@right:
;check 2 points on the right
	ldx obj_right
	ldy obj_top
	jsr Hit_BG
	cmp #1
	beq @handle_collision
	ldx obj_right
	ldy obj_bottom
	jsr Hit_BG
	cmp #1
	bne Y_Move
	
@handle_collision:
;yes collision, revert to old	
	lda cube_x_old
	sta cube_x
	
Y_Move:	
.a8
;handle y movement second
	XY16
	lda cube_y
	clc
	adc cube_y_sp
	sta cube_y
;min max	
	lda cube_y
	cmp #208
	bcc @ok
	lda cube_y_old
	sta cube_y
	jmp Past_Move
@ok:	
		
;skip if no y move
	lda cube_y_sp
	beq Past_Move

;make a hitbox a little smaller than the object	
	A8
	jsr Load_Hitbox
	
;check collision, then revert if yes
	AXY8
	lda cube_y_sp ;which way are we going?
	bpl @down
@up:
;check 2 points on the top
	ldx obj_left
	ldy obj_top
	jsr Hit_BG
	cmp #1
	beq @handle_collision
	ldx obj_right
	ldy obj_top
	jsr Hit_BG
	cmp #1
	beq @handle_collision
	bra Past_Move
	
@down:
;check 2 points on the bottom
	ldx obj_left
	ldy obj_bottom
	jsr Hit_BG
	cmp #1
	beq @handle_collision
	ldx obj_right
	ldy obj_bottom
	jsr Hit_BG
	cmp #1
	bne Past_Move
	
@handle_collision:
;yes collision, revert to old	
	lda cube_y_old
	sta cube_y


Past_Move:


;check that yellow tile
;darken the screen if over
;check one point
	AXY8
	lda #$0f ;default screen brightness
	sta bright_var
	lda cube_x
	clc
	adc #7 ; about the middle of the sprite
	tax
	lda cube_y
	clc
	adc #7
	tay
	jsr Hit_BG
	cmp #2
	bne Past_Yellow
	lda #$07 ;darker
	sta bright_var
	cmp bright_var2 ;compare to last frame
	beq Past_Yellow
	
	
;only trigger this sound effect if on yellow, but not if last frame	
	AXY8
	lda #0 ;ding
	ldx #127
	ldy #6 ;0= the first channel, 6 is the 7th
		  ;for this demo, values 4,5, and 6 work. 
		  ;our sound effect uses 2 channels...
		  ;7 will only play 1 channel of the sfx
	jsl SFX_Play_Center
;axy 8 bit
;in a= sfx #
;	x= volume 0-127
;	y= sfx channel, needs to be > than max song channel
;pan center

;	lda #$00 ;echo volume off
;	ldx #$00 ;channels off
;	jsl Echo_Vol
	
Past_Yellow:
	XY16
	
	lda bright_var ;remember last frame
	sta bright_var2

	jsr Draw_Sprites
	jmp Infinite_Loop
	
	
	
Load_Hitbox:
;makes a hitbox a little smaller than the sprite.
.a8
	lda cube_y
	clc
	adc #1
	sta obj_top
	clc
	adc #14
	sta obj_bottom
	lda cube_x
	clc
	adc #1
	sta obj_left
	clc
	adc #13
	sta obj_right
	rts
	
	
	
Hit_BG:
;in values 
;x = x position in pixels
;y = y position in pixels

;returns A = map value
.a8
.i8
	tya
	and #$f0
	sta temp1
	txa
	lsr a
	lsr a
	lsr a
	lsr a
	ora temp1
	tax
	lda HIT_MAP, x
	rts
	
	

	
Draw_Sprites:
	php
	
	A8
	XY16
	stz sprid
	
	lda cube_x
	sta spr_x
	stz spr_x+1
	lda cube_y
	sta spr_y 
	
	
	lda cube_dir
	bne @right
@left:
	AXY16
	lda #.loword(Meta_01) ;left
	ldx #^Meta_01 
	bra @both
@right:
	AXY16
	lda #.loword(Meta_00) ;right
	ldx #^Meta_00 
@both:
.a16
.i16
	jsr OAM_Meta_Spr

	plp
	rts
	
	
	

	
	
	
Wait_NMI:
.a8
.i16
;should work fine regardless of size of A
	lda in_nmi ;load A register with previous in_nmi
@check_again:	
	WAI ;wait for an interrupt
	cmp in_nmi	;compare A to current in_nmi
				;wait for it to change
				;make sure it was an nmi interrupt
	beq @check_again
	rts

	

	
	
Pad_Poll:
.a8
.i16
; reads both controllers to pad1, pad1_new, pad2, pad2_new
; auto controller reads done, call this once per main loop
; copies the current controller reads to these variables
; pad1, pad1_new, pad2, pad2_new (all 16 bit)
	php
	A8
@wait:
; wait till auto-controller reads are done
	lda $4212
	lsr a
	bcs @wait
	
	A16
	lda pad1
	sta temp1 ; save last frame
	lda $4218 ; controller 1
	sta pad1
	eor temp1
	and pad1
	sta pad1_new
	
	lda pad2
	sta temp1 ; save last frame
	lda $421a ; controller 2
	sta pad2
	eor temp1
	and pad2
	sta pad2_new
	plp
	rts
	

TEST_FIR:
.byte $40, $28, $18, $0c, $06, $03, $02, $01
	
	
.include "Sprites/metasprites.asm"	
;Meta_00 right
;Meta_01 left

HIT_MAP:
.include "Tiled/Blocks.asm"

.include "header.asm"	







.segment "RODATA1"



BG_Tiles:
.incbin "Background/Both.chr"
End_BG_Tiles:


Spr_Tiles:
.incbin "Sprites/Cube.chr"
End_Spr_Tiles:



.segment "RODATA2"

BG_Palette:
.incbin "Background/Background.pal"

Spr_Palette:
.incbin "Sprites/Cube.pal"

Map1:
.incbin "Background/Blocks.map"


.segment "RODATA6"
music_code:
.incbin "MUSIC/spc700.bin", 0, 32768
;put the first 32768 bytes here
music_code_end:


.segment "RODATA7"

.incbin "MUSIC/spc700.bin", 32768
;put every byte, from 32768 on, here
song1:
.incbin "MUSIC/music_1.bin"
song2:
.incbin "MUSIC/music_2.bin"
