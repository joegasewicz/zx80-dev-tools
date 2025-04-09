    DEVICE ZXSPECTRUM48
    ; in this device the default slot is SLOT 3 with PAGE 0 paged in.

    ORG $8000

ENTRY_POINT     equ 32768       ; start of the empty spacve in memory RAM
ROM_CHAN_OPEN   equ $1601

Start:
    ld a, 2                     ; ld the screen channel value of 2 into the accumulator
    call ROM_CHAN_OPEN          ; open channel 2

loop:
    ld de, HelloStr             ; loads the address of the HelloStr into the DE register pair.
    call PrintString            ; jump to PrintString subroutine
    jp loop                     ; unconditionally jump to the loop

PrintString:
    ld a, (de)                  ; load char address at DE into A
    cp 0                        ; Id it 0? (null terminator)
    ret z                       ; If yes, return (stop printing)
    rst 16                      ; Else, print the character in A
    inc de                      ; Move to the next char
    jr  PrintString             ; repeat

HelloStr:
    db "GetReady!", 13, 0       ; define bytes for string, move to a new line, null terminator


    DEVICE NONE
    ;do something, if you don't want to corrupt virtual
    ;memory with other code, for example, loader of code.
    ;...code...

    ;return to our virtual device:
    DEVICE ZXSPECTRUM48

    SAVESNA "build.sna", ENTRY_POINT
    SAVETAP "build.tap", ENTRY_POINT

    ;SAVENEX OPEN "project1.nex", Main, $ff40
