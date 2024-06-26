ZESARUX=/Applications/zesarux.app/Contents/MacOS/zesarux
NEX_FILE=/Users/joegasewicz/CLionProjects/alien_planet/alien_planet.sna
INDEX=/Users/joegasewicz/CLionProjects/alien_planet/src/index.asm
BAS_ROOT=/Users/joegasewicz/CLionProjects/alien_planet/basic/index.bas
TAP_OUT=/Users/joegasewicz/CLionProjects/alien_planet/tap_files/build.tap
ZMAKEBAS=zmakebas-1.5.2/zmakebas

build:
	zcc +zx -vn main.c -o main.bin -lndos
	$(ZESARUX)

help:
	$(ZESARUX) --help

expert_help:
	$(ZESARUX) --experthelp

perms:
	chmod o+rw $(NEX_FILE)

emulator:
	$(ZESARUX)

run_snapshot:
	$(ZESARUX) --nowelcomemessage --disableborder --disablefooter --machine TBBlue --snap $(NEX_FILE) --verbose 1

clean:
	$(RM) *.sna
	$(RM) *.bin

assemble:
	sjasmplus $(INDEX) --zxnext=cspect

run_assembly:
	make clean
	make assemble
	make run_snapshot

zmake_help:
	$(ZMAKEBAS) -h


clean_tap:
	$(RM) $(TAP_OUT)

bas_to_tap:
	$(ZMAKEBAS) \
	-n joe1 \
	-o $(TAP_OUT) \
	$(BAS_ROOT)

run_tap:
	$(ZESARUX) --machine TBBlue --tape $(TAP_OUT) --verbose 1

run_basic:
	make clean_tap
	make bas_to_tap
	make run_tap
