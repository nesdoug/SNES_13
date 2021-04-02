;constants for SNES


;KEY_B      = $80 ;Controller1 + 1
;KEY_Y      = $40
;KEY_SELECT = $20
;KEY_START  = $10
;KEY_UP     = $08
;KEY_DOWN   = $04
;KEY_LEFT   = $02
;KEY_RIGHT  = $01
;
;KEY_A      = $80 ;Controller1
;KEY_X      = $40
;KEY_L      = $20
;KEY_R      = $10

KEY_B      = $8000
KEY_Y      = $4000
KEY_SELECT = $2000
KEY_START  = $1000
KEY_UP     = $0800
KEY_DOWN   = $0400
KEY_LEFT   = $0200
KEY_RIGHT  = $0100
KEY_A      = $0080
KEY_X      = $0040
KEY_L      = $0020
KEY_R      = $0010







;for tiles on a map, upper byte, in 8 bit
TILE_V_FLIP = $80
TILE_H_FLIP = $40
TILE_PRIORITY = $20
TILE_PAL_0 = $00
TILE_PAL_1 = $04
TILE_PAL_2 = $08
TILE_PAL_3 = $0c
TILE_PAL_4 = $10
TILE_PAL_5 = $14
TILE_PAL_6 = $18
TILE_PAL_7 = $1c
;bits 0 and 1 are for high 2 bits of tile #
;note, low byte is the low 8 bits of tile #


;each sprite has 4 1/4 bytes
;x
;y
;tile #
;attributes
;2 bits for x (negative, if set) and sprite size

;for sprites, attribute byte, in 8 bit
SPR_CHRSET_0 = 0
SPR_CHRSET_1 = 1
SPR_PAL_0 = $00
SPR_PAL_1 = $02
SPR_PAL_2 = $04
SPR_PAL_3 = $06
SPR_PAL_4 = $08
SPR_PAL_5 = $0a
SPR_PAL_6 = $0c
SPR_PAL_7 = $0e
SPR_PRIOR_0 = $00
SPR_PRIOR_1 = $10
SPR_PRIOR_2 = $20
SPR_PRIOR_3 = $30
SPR_V_FLIP = $80
SPR_H_FLIP = $40


;for sprites, high table
SPR_POS_X = 0
SPR_NEG_X = 1
;if the upper most bit of x is set, it's as if the sprite is
;off the screen to the left
;you can scroll a sprite off the left by setting this
SPR_SIZE_SM = 0
SPR_SIZE_LG = 2
;actual dimensions of the size set by 2101, oam_size



;for bg3 priority $2105, add this to mode # 0-7
BG3_BOTTOM = 0	
BG3_TOP = 8
;for bg tilesize $2105
BG_ALL_8x8 = 0
BG1_16x16 = $10
BG2_16x16 = $20
BG3_16x16 = $40
BG4_16x16 = $80
BG_ALL_16x16 = $F0


;for bg map_size, $2107, $2108, $2109, $210a
MAP_32_32 = 0
MAP_64_32 = 1
MAP_32_64 = 2
MAP_64_64 = 3


;for oam size $2101
OAM_8_16 = 0
OAM_8_32 = $20
OAM_8_64 = $40
OAM_16_32 = $60
OAM_16_64 = $80
OAM_32_64 = $a0


;vram increment after the vram write
;register $2115
V_INC_1 = $80
V_INC_32 = $81


;for main screen or sub screen
;$212c and $212d
SCREEN_OFF = 0
BG1_ON = 1
BG2_ON = 2
BG3_ON = 4
BG4_ON = 8
BG_ALL_ON = $0f
SPR_OFF = 0
SPR_ON = $10
ALL_ON_SCREEN = $1f


;for screen bright $2100
FULL_BRIGHT = $0f
HALF_BRIGHT = $08
NO_BRIGHT = $00
FORCE_BLANK = $80


;for interrupts controller $4200
;you will also need to cli if you want IRQs
NO_INTERRUPTS = 0
NMI_ON = $80
V_IRQ_ON = $20
H_IRQ_ON = $10
AUTO_JOY_ON = 1
;auto read joypads




;register list, non-standard names
;see wiki.superfamicom.org/registers for standard names

fb_bright = $2100
spr_addr_size = $2101
oam_addr_L = $2102
oam_addr_H = $2103
oam_data = $2104
bg_size_mode = $2105
mosaic = $2106
tilemap1 = $2107
tilemap2 = $2108
tilemap3 = $2109
tilemap4 = $210a
bg12_tiles = $210b
bg34_tiles = $210c

bg1_scroll_x = $210d ;write twice
bg1_scroll_y = $210e ;write twice
;210d 210e are also mode 7 scroll registers

bg2_scroll_x = $210f ;write twice
bg2_scroll_y = $2110 ;write twice
bg3_scroll_x = $2111 ;write twice
bg3_scroll_y = $2112 ;write twice
bg4_scroll_x = $2113 ;write twice
bg4_scroll_y = $2114 ;write twice


vram_inc = $2115
vram_addr = $2116
vram_addr_L = $2116
vram_addr_H = $2117
vram_data = $2118
vram_put = $2118
;register needs to be in 16 bit mode to write just to 2118
vram_data_L = $2118
vram_data_H = $2119
;register in 8 bit to write to each 2118 and 2119 separately

mode7_select = $211a
mode7_a = $211b
mode7_b = $211c
mode7_c = $211d
mode7_d = $211e
mode7_x = $211f
mode7_y = $2120

; When BGMODE is 0-6 (or during vblank in mode 7), a fast 16x8
; signed multiply is available, finishing by the next CPU cycle.
M7MCAND = $211B    ; write low then high
M7MUL = $211C      ; 8-bit factor
M7PRODL = $2134 ;result
M7PRODM = $2135
M7PRODH = $2136

pal_addr = $2121
pal_data = $2122 ;write twice

bg12_window = $2123
bg34_window = $2124
obj_window = $2125
window1_L = $2126
window1_R = $2127
window2_L = $2128
window2_R = $2129
window_logic_bg = $212a
window_logic_obj = $212b

main_screen = $212c	
sub_screen = $212d
;---o 4321, o is sprites

main_window = $212e
sub_window = $212f

color_add_sel = $2130
color_add_des = $2131
color_fixed = $2132

video_mode = $2133

;$2134-36 see above


counter_latch = $2137

oam_read = $2138
vram_read_L = $2139 ; the first read is junk and you
vram_read_H = $213a ; need to toss that and then start reads
pal_read_L = $213b
read_scan_H = $213c
read_scan_V = $213d
ppu_status = $213e
ppu_status2 = $213f

apu_r0 = $2140
apu_r1 = $2141
apu_r2 = $2142
apu_r3 = $2143

wram_data = $2180 ;write/dma only
wram_addr_L = $2181
wram_addr_M = $2182
wram_addr_H = $2183

joy0 = $4016
joy1 = $4017

interrupt_enable = $4200
io_port_out = $4201

mult_a = $4202
mult_b = $4203
div_c_L = $4204
div_c_H = $4205
divisor = $4206

h_timer_L = $4207
h_timer_H = $4208
v_timer_L = $4209
v_timer_H = $420a

dma_enable = $420b
hdma_enable = $420c
rom_speed = $420d
nmi_flag = $4210 ;read once during nmi
irq_flag = $4211 ;read once during irq
joy_ppu_status = $4212
io_port_in = $4213


div_result_L = $4214
div_result_H = $4215
div_remain_L = $4216
div_remain_H = $4217
;multiply results for 4202-3
mult_result_L = $4216
mult_result_H = $4217


joy1_L = $4218
joy1_H = $4219
joy2_L = $421a
joy2_H = $421b
joy3_L = $421c
joy3_H = $421d
joy4_L = $421e
joy4_H = $421f


;10's digit can be 0-7 for 8 different channels
dma_control = $4300
dma_dst_reg = $4301
dma_src_L = $4302
dma_src_M = $4303
dma_src_H = $4304
dma_size_L = $4305 ;also hdma...
dma_size_H = $4306
;420b for dma start
hdma_ind_L = $4305
hdma_ind_M = $4306
hdma_ind_H = $4307
hdma_table_L = $4308
hdma_table_H = $4309
hdma_line_cnt = $430a
;420c for hdma start




