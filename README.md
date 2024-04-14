# Z80 MacOS Starter Template
ZX80 NEXT development tools for MacOS

![Alt Text](images/example2.gif)

### Requirements
1. Download [Z88DK](https://github.com/z88dk/z88dk/releases)
2. Download [Zesarux](https://github.com/chernandezba/zesarux/releases/tag/ZEsarUX-X)
3. Download [sjasmplus](https://github.com/z00m128/sjasmplus/blob/master/INSTALL.md#default-method-for-gnulinux--unix--macos--bsd)

### Using C Language
Place code in the `main.c` file & use the following command to compile
```
make build
```

### Using Z80 Assembly
Place your Assembly code in the `src` directory.
You can run each individual step to assemble with:
```
make clean
make assemble
make run_snapshot
```
Or use a single command to run all the above:
```
make run_assembly
```
This will assemble your code & open the Zesarux emulator &
run the compiled snapshot.

### Using NEXT Basic
Place your NEXT Basic code in the `basic` directory.
You can run each individual step to create a `.tap` file with:
```
make clean_tap
make bas_to_tap
make run_tap:
```
Or use a single command to run all the above:
```
make run_basic:
```
This will create a `.tap` file from your NEXT Basic code & open the Zesarux emulator.
Currently, it only loads the output `.tap` file, You will have to load the file manually
within the Zesarux emulator.

### CSpect
To get CSpect running on MacOS with an M1, M2 chip you will need to follow
these steps:
1. Download [ITerm2](https://iterm2.com/downloads.html)
2. Goto Applications, 
   - Right click on Iterm2 & click `Duplicate`.
   - Rename to `Iterm2 x86_64`
   - Now open the Iterm2 x86_64 terminal
3. Install Rosetta - `softwareupdate --install-rosetta`
4. Install brew (this will install a new version of brew to `/usr/local`)
5. Install Mono - `arch -x86_64 brew install mono`
6. Download [CSpect](https://mdf200.itch.io/cspect)
7. You will also need a ZX Spectrum NEXT image [here](https://zxspectrumnext.online/cspect/)
    - Select an image from **CURRENT DISTRO IMAGES** section.
    - Place this image in your CSpect root folder.
8. Run CSpect `mono cspect.exe -zxnext -nextrom -mmc=cspect-next-2gb.img`

### Run CSpect
Once you have the followed the above steps, you can now use the following commands

#### Run CSpect
```
sh cspect.sh
```