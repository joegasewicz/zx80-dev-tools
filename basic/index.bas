10 REM Sprite: test
20 SPRITE CLEAR
30 RESTORE
40 BANK NEW a
50 FOR f=0 TO 255
60 READ n: BANK a POKE f,n
70 NEXT f
80 SAVE "hero1.spr" BANK a,0,256
90 SPRITE BANK a
100 SPRITE PRINT 1
130 SPRITE 0,50,50,0,1
150 PAUSE 0
210 REM Sprite Pattern
290 PRINT AT 70,70;"68"
291 PAUSE 0
300 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
310 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
320 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
330 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
340 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
350 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
360 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
370 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
380 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
390 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
400 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
410 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
420 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
430 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
440 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
450 DATA 68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68
460 REM ------------------------------------------------
470 REM ------------------------------------------------
500 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
510 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
520 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
530 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
540 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
550 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
560 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
570 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
580 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
590 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
600 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
610 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
620 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
630 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
640 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
650 DATA 80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80

