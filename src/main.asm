    DEVICE ZXSPECTRUM48

    ORG $8000
    ;ld a, 2                        ; upper channel (main window) - small bar at bottom is channel 1
    ;call 5633                      ; ROM routine which opens channel a
    call 0xdaf                      ; better way, clears screen AND opens channel
    ld hl, udg                      ; hl - pointer to udg1
    ld (23675), hl                  ; 5C7B: UDG - Address of first user defined graphic

    ; screen color
    ld a, ATTR_BLUE_INK_YELLOW_PAPER
    ld (23693), a                   ; poke value into screen colour attr memory address
    call 0xdaf                      ; cls clear screen

    call get_random_num             ; put random number in a
    and %00011111
    ld (xpos), a

    ; ld b, 17                        ; seconds delayed into b
    ; call wait_loop

    ld bc, NOTE_G_SHARP             ; put g# into bc
    call play_note                  ; play note g#
    ld bc, NOTE_C                   ; play c into bc
    call play_note                  ; play note c

    ld bc, NOTE_C                   ; play c into bc
    call play_note                  ; play note cv


Main:                               ; main entry
    halt                            ; locks to 50fps / halt waits for the interupt

    ld de, (xpos)                   ; de = xpos,ypos
    call set_position
    call delete_sprite

    ld bc, 64510                    ; QWERT port
    in a, (c)                       ; reads (hardware) port in c

    rra                             ; rotate right, bit 0 into carry
    push af
    call nc, move_left              ; roll bits to the right, bit0 moves into the carry but of f (f=carry flag)
    pop af

    rra
    push af
    call nc, move_right
    pop af

    ld bc, 0xdffe                   ; POIUYH port
    in a, (c)                       ; reads port to c

    rra
    push af
    call nc, move_up
    pop af

    ld bc, 0xbffe
    in a, (c)                       ; ENTER,L,K,J,H

    rra                             ; 'ENTER'
    rra                             ; 'L'
    push af
    call nc, move_down
    pop af

    ld a, (b_alien_spawn_int)
    cp 0
    call z, spawn_aliens

    ld de, (xpos)
    call set_position
    call display_sprite

    ld de, (score_xpos)             ; bc = score value
    call set_position
    ld bc, (score)
    call 0x1a1b                     ; built in routine prints integer <= 9999

    jp Main


spawn_aliens:
    ld a, (ix)
    cp 255
    jp z, end_spawn

end_spawn:
    ld a, 1
    ld (b_alien_spawn_int), a
    ret


display_sprite:
    ld a, (player_sprite)
    rst 16                          ; print a
    ret


delete_sprite:
    ld a, ASCII_SPACE               ; load a with a space
    rst 16
    ret

; ------------------------------------------------
; ROUTINE: set_position
; DESCR:    Uses the accumulator to set rst 16 from
;           d,e with ascii AT.
; INPUTS:   de
; ------------------------------------------------
set_position:
    ld a, ASCII_AT
    rst 16
    ld a, d
    rst 16
    ld a, e
    rst 16
    ret

move_right:
    ld a, (xpos)
    cp MAX_X
    ret nc                              ; pops out the carry flag
    ld a, (xpos)                        ; you can't increment data but a knows how to increment
    inc a                               ; increment a
    ld (xpos), a
    ret

move_left:
    ld a, (xpos)
    cp 0
    ret z                               ; pops out the carry flag
    ld a, (xpos)                        ; you can't increment data but a knows how to increment
    dec a                               ; increment a
    ld (xpos), a
    ret


move_up:
    ld a, (ypos)
    cp 0
    ret z
    ld a, (ypos)
    dec a
    ld (ypos), a
    ret

move_down:
    ld a, (ypos)
    cp MAX_Y
    ret z
    ld a, (ypos)
    inc a
    ld (ypos), a
    ret

; ------------------------------------------------
; ROUTINE:  wait_loop
; DESCR:    Waits (n) amount of time
; INPUTS:   b - 50 is equal to 1s (50 frames)
; ------------------------------------------------
wait_loop:
    halt
    halt
    halt
    djnz wait_loop
    ret

; ------------------------------------------------
; ROUTINE:  get_random_num
; DESCR:    Returns random number between 0-255
; INPUTS:   a
; ------------------------------------------------
get_random_num:
    ld hl, (seed)
    ld a, h
    and %00011111                       ; only change the first 5 bits & ignore the 3 high bits
    ld h, a
    ld a, (hl)
    inc hl
    ld (seed), hl
    ret

;;;;;;;;;;;;;;;;;;;;; DATA ;;;;;;;;;;;;;;;;;;;;;;;;
seed dw 0
score dw 0000
score_xpos db 0
score_ypos db 0

xpos db 0
ypos db 10

player_sprite db 0x91
alien_sprite db 0x92

; 0: 0 is Not alive, 1 is alive
; 1: xpos
; 2: ypos
alien_data:
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 1,0,0
    db 255

b_alien_spawn_int db 0

    INCLUDE "sprites.asm"
    INCLUDE "constants.asm"
    INCLUDE "audio.asm"

    DEVICE NONE
    ;do something, if you don't want to corrupt virtual
    ;memory with other code, for example, loader of code.
    ;...code...

    ;return to our virtual device:
    DEVICE ZXSPECTRUM48

    SAVESNA "build.sna", Main
    SAVETAP "build.tap", Main

    ;SAVENEX OPEN "project1.nex", Main, $ff40
