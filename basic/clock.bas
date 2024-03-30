10 REM First we select the appropriate pause
20 LET wait=52: REM 50hz/50=1 sec.
30 REM First we draw the clock face
40 FOR n=1 TO 12
50 PRINT AT 10-10* COS (n/6* PI ),16+10* SIN (n/6* PI );n
60 NEXT n
70 REM Now we start the clock
80 FOR t=0 TO 200000: REM t is the time in seconds
90 LET a=t/30* PI : REM a is the angle of the second hand in rad.
100 LET sx=80* SIN a: LET sy=80* COS a
200 PLOT 128,88: DRAW OVER 1;sx,sy: REM draw the second hand
210 PAUSE wait
220 PLOT 128,88: DRAW OVER 1;sx,sy: REM erase 2nd hand
400 next t
