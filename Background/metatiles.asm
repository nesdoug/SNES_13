.segment "CODE"

; typed by hand
; 8 bytes per metatile = 4 tiles
; 2 bytes per tile, tile # then attributes (palette)
Metatiles:
;tile 0
.byte $02, TILE_PAL_0
.byte $03, TILE_PAL_0
.byte $12, TILE_PAL_0
.byte $13, TILE_PAL_0
;tile 1
.byte $04, TILE_PAL_1
.byte $05, TILE_PAL_1
.byte $14, TILE_PAL_1
.byte $15, TILE_PAL_1
;tile 2
.byte $02, TILE_PAL_5
.byte $03, TILE_PAL_5
.byte $12, TILE_PAL_5
.byte $13, TILE_PAL_5

