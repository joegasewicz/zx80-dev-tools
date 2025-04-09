ZESARUX=/Applications/zesarux.app/Contents/MacOS/zesarux
FUSE=/Applications/Fuse.app/Contents/MacOS/Fuse
NEX_FILE=$(abspath .)/build.sna
TAP_FILE=$(abspath .)/build.tap
INDEX=$(abspath .)/src/index.asm
BAS_ROOT=$(abspath .)/basic/index.bas
TAP_OUT=$(abspath .)/tap_files/build.tap
ZMAKEBAS=zmakebas-1.5.2/zmakebas
ZCC=$(abspath .)/apps/z88dk/bin/zcc

python_script:
	cd scripts \
	&& virtualenv venv \
	&& source venv/bin/activate \
	&& pip install -r requirements.txt \
	&& python zx_tools.py \
	&& cd ../apps/z88dk \
   	&& chmod -R 755 bin/*

# TODO currently not working - sjasm/lua_sjasm.cpp:35:10: fatal error: 'LuaBridge/LuaBridge.h' file not found
install_sjasmplus:
	cd apps \
	&& git clone https://github.com/z00m128/sjasmplus.git &&\
	cd sjasmplus \
	&& git submodule update --init --force --remote\
	&& make clean \
	&& make \
	&& sudo -S make install

install:
	rm -rf apps
	mkdir apps
	make install_sjasmplus
	make python_script

build:
	$(RM) *.tap
	PATH=${PATH}:/Users/joegasewicz/CLionProjects/zx80-dev-tools/apps/z88dk/bin \
	&& ZCCCFG=/Users/joegasewicz/CLionProjects/zx80-dev-tools/apps/z88dk/lib/config \
	&& $(ZCC) +zx -vn -clib=sdcc_iy -startup=31 main.c -o main.bin -create-app
	$(FUSE) $(abspath .)/main.tap

build-fuse:
	PATH=${PATH}:/Users/joegasewicz/CLionProjects/zx80-dev-tools/apps/z88dk/bin \
	&& ZCCCFG=/Users/joegasewicz/CLionProjects/zx80-dev-tools/apps/z88dk/lib/config \
	&& $(ZCC) +zx -vn main.c -o main.bin -lndos
	$(FUSE) $(abspath .)/main.tap

help:
	$(ZESARUX) --help

help-fuse:
	$(FUSE) --help

sjasmplus-help:
	sjasmplus --help

expert_help:
	$(ZESARUX) --experthelp

perms:
	chmod o+rw $(NEX_FILE)

emulator:
	$(ZESARUX)

run_snapshot:
	$(ZESARUX) --nowelcomemessage --disableborder --disablefooter --machine TBBlue --snap $(NEX_FILE) --verbose 1

run_snapshot_fuse:
	chmod -R 755 $(NEX_FILE) \
	&& $(FUSE) $(NEX_FILE)

run_tap_fuse:
	chmod -R 755 $(TAP_FILE) \
	&& $(FUSE) $(TAP_FILE)

clean:
	$(RM) *.sna
	$(RM) *.bin
	$(RM) *.tap

assemble:
	sjasmplus $(INDEX)
	#sjasmplus $(INDEX) --zxnext=cspect

assemble-fuse:
	sjasmplus $(INDEX)

run_assembly:
	make clean
	make assemble
	make run_snapshot

run_assembly-fuse:
	make clean
	make assemble-fuse
	make run_tap_fuse

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
