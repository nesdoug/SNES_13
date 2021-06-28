; variables declared

FACE_LEFT = 0
FACE_RIGHT = 1



.segment "ZEROPAGE"

in_nmi: .res 2
temp1: .res 2
temp2: .res 2
temp3: .res 2
temp4: .res 2
temp5: .res 2
temp6: .res 2

; for sprite code
sprid: .res 1
spr_x: .res 2 ; 9 bit
spr_y: .res 1 
spr_c: .res 1 ; tile #
spr_a: .res 1 ; attributes
spr_sz:	.res 1 ; sprite size, 0 or 2
spr_h: .res 1 ; high 2 bits
spr_x2:	.res 2 ; for meta sprite code

; for sprite collision code
obj1x: .res 1
obj1w: .res 1
obj1y: .res 1
obj1h: .res 1
obj2x: .res 1
obj2w: .res 1
obj2y: .res 1
obj2h: .res 1
collision: .res 1

pad1: .res 2
pad1_new: .res 2
pad2: .res 2
pad2_new: .res 2


cube_x: .res 1
cube_x_sp: .res 1 ;speed
cube_y: .res 1
cube_y_sp: .res 1

cube_x_old: .res 1
cube_y_old: .res 1

cube_dir: .res 1 ;face left 0 or right 1

;for BG collision code
obj_top: .res 1
obj_bottom: .res 1
obj_left: .res 1
obj_right: .res 1

bright_var:	.res 1
bright_var2: .res 1 ;last frame


.segment "BSS"

PAL_BUFFER: .res 512 ;palette

OAM_BUFFER: .res 512 ;low table
OAM_BUFFER2: .res 32 ;high table

