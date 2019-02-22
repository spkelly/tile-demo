INCLUDE "gbhw.inc"

; de: source
; hl: destination
; bc: index

SLEEP_DELAY EQU $FF00

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
  call LOAD_TITLE
  call turn_on_lcd
infinite_loop::
  call sleep
  call sleep
  call wait_vblank
  ld a,%01010011
  ld [rBGP],a
  call sleep
  call sleep
  call wait_vblank
  ld a,%11100100
  ld [rBGP],a
  ; call turn_off_lcd
  ; call update_data
  ; call turn_on_lcd
  ; nop
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

sleep::
  ld bc, SLEEP_DELAY
.sleep_loop
  dec bc 
  ld a, b
  or c
  jr nz, .sleep_loop
  ret

load_data::
  call CLEAR_BG_MAP
  call CLEAR_OAM
  call LOAD_BG_TILE_DATA
  call LOAD_FONT_TILE_DATA
  call LOAD_TITLE_TILE_DATA
  call LOAD_BG_TILE_MAP

  ret 

LOAD_TITLE::
  ld de, TITLE_TEXT
  ld hl, $9800 + ($20 * 4) + 5
  ld bc, END_TITLE_TEXT - TITLE_TEXT
  call CopyData
  ret

CLEAR_BG_MAP:: 
  ld e, $00
  ld hl, _SCRN0
  ld bc, $400
  call CopyFixedData
  ret


;de= source, hl=destination bc=size
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
  ld bc, BG_TILE_DATA_END - BG_TILE_DATA
  ld de, BG_TILE_DATA
  ld hl, _VRAM + $10
  call CopyData
  ret

LOAD_TITLE_TILE_DATA::
  ld bc, TITLE_TILE_DATA - END_TITLE_TILE_DATA
  ld de, TITLE_TILE_DATA


; CHECK_FOR_USER_TILE::
;   ld bc, USER_TILE_DATA - END_USER_TILE_DATA
;   jp nz, LOAD_USER_TILE_DATA
;   ret
; LOAD_USER_TILE_DATA::
;   ret


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

LOAD_FONT_TILE_DATA::
  ld hl, $8200
  ld de, FONT_TILES

  ld bc, END_FONT_TILES - FONT_TILES

  call CopyData
  ret   



TITLE_TEXT::
  db "Tile Demo!"
END_TITLE_TEXT

INCLUDE "assets/bg_tile_data.inc"
INCLUDE "assets/bg_tile_map.inc"
INCLUDE "assets/fontTile.inc"
