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
  call CLEAR_VRAM
  call CLEAR_OAM
  ret 


CLEAR_VRAM:: 
  ld e, $19
  ld hl, _SCRN0
  ld bc, $400
  call CopyFixedData
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

CLEAR_TILES::
