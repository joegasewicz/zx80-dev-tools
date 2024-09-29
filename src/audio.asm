; ---------------- Audio --------------------
; -------------------------------------------
;   Notes:
;   ------
;       - C             261.63
;       - C#            277.18      
;       - D             293.66
;       - D#            311.13
;       - E             329.63
;       - F             349.23
;       - F#            369.99
;       - G             392.00
;       - G#            415.30
;       - A             440.00
;       - A#            466.16
;       - B             493.88
; -------------------------------------------
; de: duration = freq * seconds
; hl: pitch = 0x6acfc / freq - 30.125
; h,l - 437500 / (415.3 - 30.125) = 1,023.3
; -------------------------------------------

NOTE_C          equ 1642
NOTE_C_SHARP    equ 1548
NOTE_D          equ 1460
NOTE_G_SHARP    equ 1023

; -------------------------------------------
; ROUTINE:  note_g_sharp
; DESCR:    plays a G# note for .5s 
; INPUTS:   bc - the note to be played
; -------------------------------------------
play_note:
    ld h, b
    ld l, c
    ld de, 208              ; d,e - 415.3 * 0.5
    call 0x03b5             ; beeper subroutine
    ret 
