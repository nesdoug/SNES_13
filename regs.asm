;SNES Registers
;Anomie 2007

INIDISP = $2100 ;Screen Display
OBSEL = $2101 ;Object Size and Chr Address
OAMADDL = $2102 ;OAM Address low byte
OAMADDH = $2103 ;OAM Address high bit and Obj Priority
OAMDATA = $2104 ;Data for OAM write
BGMODE = $2105 ;BG Mode and Character Size
MOSAIC = $2106 ;Screen Pixelation
BG1SC = $2107 ;BG1 Tilemap Address and Size
BG2SC = $2108 ;BG2 Tilemap Address and Size
BG3SC = $2109 ;BG3 Tilemap Address and Size
BG4SC = $210a ;BG4 Tilemap Address and Size
BG12NBA = $210b ;BG1 and 2 Chr Address
BG34NBA = $210c ;BG3 and 4 Chr Address
BG1HOFS = $210d ;BG1 Horizontal Scroll
M7HOFS = $210d ;Mode 7 BG Horizontal Scroll
BG1VOFS = $210e ;BG1 Vertical Scroll
M7VOFS = $210e ;Mode 7 BG Vertical Scroll
BG2HOFS = $210f ;BG2 Horizontal Scroll
BG2VOFS = $2110 ;BG2 Vertical Scroll
BG3HOFS = $2111 ;BG3 Horizontal Scroll
BG3VOFS = $2112 ;BG3 Vertical Scroll
BG4HOFS = $2113 ;BG4 Horizontal Scroll
BG4VOFS = $2114 ;BG4 Vertical Scroll
VMAIN = $2115 ;Video Port Control
VMADDL = $2116 ;VRAM Address low byte
VMADDH = $2117 ;VRAM Address high byte
VMDATAL = $2118 ;VRAM Data Write low byte
VMDATAH = $2119 ;VRAM Data Write high byte
M7SEL = $211a ;Mode 7 Settings
M7A = $211b ;Mode 7 Matrix A
M7B = $211c ;Mode 7 Matrix B
M7C = $211d ;Mode 7 Matrix C
M7D = $211e ;Mode 7 Matrix D
M7X = $211f ;Mode 7 Center X
M7Y = $2120 ;Mode 7 Center Y
CGADD = $2121 ;CGRAM Address
CGDATA = $2122 ;CGRAM Data write
W12SEL = $2123 ;Window Mask Settings for BG1 and BG2
W34SEL = $2124 ;Window Mask Settings for BG3 and BG4
WOBJSEL = $2125 ;Window Mask Settings for OBJ and Color Window
WH0 = $2126 ;Window 1 Left Position
WH1 = $2127 ;Window 1 Right Position
WH2 = $2128 ;Window 2 Left Position
WH3 = $2129 ;Window 2 Right Position
WBGLOG = $212a ;Window mask logic for BGs
WOBJLOG = $212b ;Window mask logic for OBJs and Color Window
TM = $212c ;Main Screen Designation
TS = $212d ;Subscreen Designation
TMW = $212e ;Window Mask Designation for the Main Screen
TSW = $212f ;Window Mask Designation for the Subscreen
CGWSEL = $2130 ;Color Addition Select
CGADSUB = $2131 ;Color math designation
COLDATA = $2132 ;Fixed Color Data
SETINI = $2133 ;Screen Mode/Video Select
MPYL = $2134 ;Multiplication Result low byte
MPYM = $2135 ;Multiplication Result middle byte
MPYH = $2136 ;Multiplication Result high byte
SLHV = $2137 ;Software Latch for H/V Counter
OAMDATAREAD = $2138 ;Data for OAM read
VMDATALREAD = $2139 ;VRAM Data Read low byte
VMDATAHREAD = $213a ;VRAM Data Read high byte
CGDATAREAD = $213b ;CGRAM Data read
OPHCT = $213c ;Horizontal Scanline Location
OPVCT = $213d ;Vertical Scanline Location
STAT77 = $213e ;PPU Status Flag and Version
STAT78 = $213f ;PPU Status Flag and Version
APUIO0 = $2140 ;APU I/O register 0
APUIO1 = $2141 ;APU I/O register 1
APUIO2 = $2142 ;APU I/O register 2
APUIO3 = $2143 ;APU I/O register 3
WMDATA = $2180 ;WRAM Data read/write
WMADDL = $2181 ;WRAM Address low byte
WMADDM = $2182 ;WRAM Address middle byte
WMADDH = $2183 ;WRAM Address high byte

JOYSER0 = $4016 ;NES-style Joypad Access Port 1
JOYSER1 = $4017 ;NES-style Joypad Access Port 2

NMITIMEN = $4200 ;Interrupt Enable Flags
WRIO = $4201 ;Programmable I/O port (out-port)
WRMPYA = $4202 ;Multiplicand A
WRMPYB = $4203 ;Multiplicand B
WRDIVL = $4204 ;Dividend C low byte
WRDIVH = $4205 ;Dividend C high byte
WRDIVB = $4206 ;Divisor B
HTIMEL = $4207 ;H Timer low byte
HTIMEH = $4208 ;H Timer high byte
VTIMEL = $4209 ;V Timer low byte
VTIMEH = $420a ;V Timer high byte
MDMAEN = $420b ;DMA Enable 76543210
HDMAEN = $420c ;HDMA Enable 76543210
MEMSEL = $420d ;ROM Access Speed
RDNMI = $4210 ;NMI Flag and 5A22 Version
TIMEUP = $4211 ;IRQ Flag
HVBJOY = $4212 ;PPU Status
RDIO = $4213 ;Programmable I/O port (in-port)
RDDIVL = $4214 ;Quotient of Divide Result low byte
RDDIVH = $4215 ;Quotient of Divide Result high byte
RDMPYL = $4216 ;Multiplication Product or Divide Remainder low byte
RDMPYH = $4217 ;Multiplication Product or Divide Remainder high byte
JOY1L = $4218 ;Controller Port 1 Data1 Register low byte
JOY1H = $4219 ;Controller Port 1 Data1 Register high byte
JOY2L = $421a ;Controller Port 2 Data1 Register low byte
JOY2H = $421b ;Controller Port 2 Data1 Register high byte
JOY3L = $421c ;Controller Port 1 Data2 Register low byte
JOY3H = $421d ;Controller Port 1 Data2 Register high byte
JOY4L = $421e ;Controller Port 2 Data2 Register low byte
JOY4H = $421f ;Controller Port 2 Data2 Register high byte

DMAPx = $4300 ;DMA Control 
BBADx  = $4301 ;DMA Destination Register 
A1TxL = $4302 ;DMA Source Address low byte
A1TxH = $4303 ;DMA Source Address high byte
A1Bx = $4304 ;DMA Source Address bank byte
DASxL = $4305 ;DMA Size/HDMA Indirect Address low byte
DASxH = $4306 ;DMA Size/HDMA Indirect Address high byte
DASBx = $4307 ;HDMA Indirect Address bank byte 
A2AxL = $4308 ;HDMA Table Address low byte 
A2AxH = $4309 ;HDMA Table Address high byte
NLTRx = $430a ;HDMA Line Counter

;add to HDMA REGISTER...
CH0 = $00
CH1 = $10
CH2 = $20
CH3 = $30
CH4 = $40
CH5 = $50
CH6 = $60
CH7 = $70








;Doug Fraker 2020

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
;increment after 2119 write
V_INC_1 = $80 ;vram address +1
V_INC_32 = $81 ;vram address +32


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



