INCLUDE "gbhw.inc"

; de: source
; hl: destination
; bc: index


Section "Start", ROM0[$100]
  nop
  jp Begin
  ROM_HEADER  ROM_NOMBC, ROM_SIZE_32KBYTE, RAM_SIZE_0KBYTE


Begin::
  nop
  di 
  ld sp, $FFFE
  ld a, %11100100
  ld [rBGP], a
  call wait_vblank
  call turn_off_lcd
  call load_data
  call turn_on_lcd
infinite_loop::
  nop
  jr infinite_loop


wait_vblank::
  ld a, [rLY]
  cp 144
  jr nz, wait_vblank
  ret


turn_off_lcd::
  ld a, [rLCDC]
  rlca
  ld [rLCDC], a
  ret

turn_on_lcd::
  ld a,  LCDCF_ON|LCDCF_BG8000|LCDCF_BG9800|LCDCF_BGON|LCDCF_OBJ8|LCDCF_OBJON 
  ld [rLCDC], a
  ret


load_data::
  call CLEAR_BG_MAP
  call CLEAR_OAM
  call LOAD_BG_TILE_DATA
  call LOAD_BG_TILE_MAP
  ret 


CLEAR_BG_MAP:: 
  ld e, $00
  ld hl, _SCRN0
  ld bc, $400
  call CopyFixedData
  ret


CopyData::
  xor a
  ld a, [de]
  ld [hli], a 
  inc de
  dec bc
  ld a, b
  or c
  jr nz, CopyData
  ret


CopyFixedData::
  ld a, e
  ld [hli], a
  dec bc
  ld a,b
  or c
  jr nz, CopyFixedData
  ret


CLEAR_OAM::
  ld e, $00
  ld hl, _OAMRAM
  ld bc, $9F
  call CopyFixedData
  ret


LOAD_BG_TILE_DATA::
  ld bc, $12
  ld de, BG_TILE_DATA
  ld hl, _VRAM
  call CopyData
  ret


LOAD_BG_TILE_MAP::
  ld bc, $14
  ld hl, _SCRN0
  ld de, BG_TILE_MAP
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 1)
  ld de, BG_TILE_MAP + ($14 * 1)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 2)
  ld de, BG_TILE_MAP + ($14 * 2)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 3)
  ld de, BG_TILE_MAP + ($14 * 3)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 4)
  ld de, BG_TILE_MAP + ($14 * 4)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 5)
  ld de, BG_TILE_MAP + ($14 * 5)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 6)
  ld de, BG_TILE_MAP + ($14 * 6)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 7)
  ld de, BG_TILE_MAP + ($14 * 7)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 8)
  ld de, BG_TILE_MAP + ($14 * 8)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 9)
  ld de, BG_TILE_MAP + ($14 * 9)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 10)
  ld de, BG_TILE_MAP + ($14 * 10)
  call CopyData
  ld bc, $14
  ld hl, _SCRN0 + ($20 * 11)
  ld de, BG_TILE_MAP + ($14 * 11)
  call CopyData
    ld bc, $14
  ld hl, _SCRN0 + ($20 * 12)
  ld de, BG_TILE_MAP + ($14 * 12)
  call CopyData
    ld bc, $14
  ld hl, _SCRN0 + ($20 * 13)
  ld de, BG_TILE_MAP + ($14 * 13)
  call CopyData
    ld bc, $14
  ld hl, _SCRN0 + ($20 * 14)
  ld de, BG_TILE_MAP + ($14 * 14)
  call CopyData
    ld bc, $14
  ld hl, _SCRN0 + ($20 * 15)
  ld de, BG_TILE_MAP + ($14 * 15)
  call CopyData
    ld bc, $14
  ld hl, _SCRN0 + ($20 * 16)
  ld de, BG_TILE_MAP + ($14 * 16)
  call CopyData
    ld bc, $14
  ld hl, _SCRN0 + ($20 * 17)
  ld de, BG_TILE_MAP + ($14 * 17)
  call CopyData
    ld bc, $14
  ld hl, _SCRN0 + ($20 * 18)
  ld de, BG_TILE_MAP + ($14 * 18)
  call CopyData
  ret

BG_TILE_MAP:: 
  DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
  DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01


BG_TILE_DATA:: 
	DB $42,$42,$c3,$c3,$00,$00,$00,$00
	DB $00,$00,$00,$00,$c3,$c3,$42,$42
