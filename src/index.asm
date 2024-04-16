    DEVICE ZXSPECTRUM128
    ; in this device the default slot is SLOT 3 with PAGE 0 paged in.

    ORG $8000

ENTRY_POINT     equ 32768           ; start of the empty spacve in memory RAM

ROM_PRINT       equ $15ef
ROM_CHAN_OPEN   equ $1601

Start:
                ld a, 2                     ; screen channel?
                call ROM_CHAN_OPEN          ; opends channel which was specified in a


loopforever:
                ld de, STR_LEN
                ld bc, 11
                call ROM_PRINT              ; call print
                jp loopforever              ; jump back to loopforever label

HELLO_STR       db "Hello World!"
STR_LEN         db 11


    DEVICE NONE
    ;do something, if you don't want to corrupt virtual
    ;memory with other code, for example, loader of code.
    ;...code...

    ;return to our virtual device:
    DEVICE ZXSPECTRUM128

    SAVESNA "alien_planet.sna", Start
    ;SAVENEX OPEN "project1.nex", Main, $ff40