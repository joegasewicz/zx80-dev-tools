ENTRY_POINT equ 32768


    org ENTRY_POINT

    ;ld a, 2            ; upper channel (main window) - small bar at bottom is channel 1
    ;call 5633          ; ROM routine which opens channel a
    call 0xdaf          ; better way, clears screen AND opens channel
    ld hl, udg1         ; hl - pointer to udg1
    ld (23675), hl       ; 5C7B: UDG - Address of first user defined graphic

Main:
    halt                ; locks to 50fps / halt waits for the interupt
    ld d, (ypos)        ; ????
    ld e, (xpos)        ; ????
    call set_position
    call delete_sprite
    call move_right
    call set_position
    call display_sprite

    ld bc, (score)      ; bc = score value
    call 0x1a1b         ; built in routine prints integer <= 9999

    jp Main


display_sprite:
    ld a, (player_sprite)
    rst 16              ; print a
    ret


delete_sprite:
    ld a, ASCII_SPACE   ; load a with a space
    rst 16
    ret


; set_position:
;     ld a, ASCII_AT
;     rst 16
;     ld a, (ypos)
;     rst 16
;     ld a, (xpos)
;     rst 16
;     ret


; INPUTS:
; de = x,y
set_position:
    ld a, ASCII_AT
    rst 16
    ld a, e
    rst 16
    ld a, d
    rst 16
    ret


move_right:
    ld a, (xpos)
    cp MAX_X
    ret nc                  ; pops out the carry flag
    ld a, (xpos)            ; you can't increment data but a knows how to increment
    inc a                   ; increment a
    ld (xpos), a
    ret


;;;;;;;;;;;;; DATA ;;;;;;;;;;;;;;;;;;;;;;;;

score db 0

xpos db 0
ypos db 0

player_sprite db 0x91

; ---- Constants (they don't change) -----
ASCII_SPACE equ 0x20
ASCII_AT equ 0x16
MAX_X equ 31


udg1
    db %11111111
    db %11111111
    db %11000011
    db %11000011
    db %11111111
    db %11000011
    db %11000011
    db %11000011
;
    db %11111111
    db %00000000
    db %01000010
    db %01000010
    db %00000000
    db %01000010
    db %01111110
    db %00000000


    ;end ENTRY_POINT

    DEVICE NONE
    ;do something, if you don't want to corrupt virtual
    ;memory with other code, for example, loader of code.
    ;...code...

    ;return to our virtual device:
    DEVICE ZXSPECTRUM128

    SAVESNA "build.sna", Main
    SAVETAP "build.tap", Main

    ;SAVENEX OPEN "project1.nex", Main, $ff40