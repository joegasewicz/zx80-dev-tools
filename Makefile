ZESARUX=/Applications/zesarux.app/Contents/MacOS/zesarux
NEX_FILE=/Users/joegoose/CLionProjects/macos-z80-starter-template/snapshotname.sna
INDEX=/Users/joegoose/CLionProjects/macos-z80-starter-template/src/index.asm
BAS_ROOT=/Users/joegoose/CLionProjects/macos-z80-starter-template/basic/index.bas
TAP_OUT=/Users/joegoose/CLionProjects/macos-z80-starter-template/tap_files/build.tap
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
	$(ZESARUX) --machine TBBlue --snap $(NEX_FILE) --verbose 1

clean:
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
