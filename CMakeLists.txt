cmake_minimum_required(VERSION 3.27)
project(macos_z80_starter_template C)

set(CMAKE_C_STANDARD 11)

add_executable(macos_z80_starter_template main.c)

target_include_directories(
        macos_z80_starter_template
        PRIVATE
        apps/z88dk/include
        apps/z88dk/include/_DEVELOPMENT/sdcc
)

target_link_libraries(
        macos_z80_starter_template
        PRIVATE
        apps/z88dk/lib
)