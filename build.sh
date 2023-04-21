#!/bin/sh -e

set -o nounset # Fails when accessing an unset variable.
set -o errexit # Exits if a command exits with a non-zero status.

roms_dir=${UXN_ROMS_DIR-"$HOME/roms"}
asm="uxnasm"
emu="uxncli"
lin="uxncli $roms_dir/uxnlin.rom"
name="drifblim"
src="src/${name}.tal"
dst="bin/${name}.rom"
arg="${src} ${dst}"

mkdir -p bin
case "$*" in *--lint*) $lin $src ;; esac
$asm $src $dst
case "$*" in *--save*) cp $dst $roms_dir ;; esac
$asm src/drifloon.tal bin/drifloon.rom
$emu $dst $arg

# Test with hello.rom
$emu $dst examples/hello.tal bin/hello.rom
$emu bin/hello.rom

# Test interactive mode
$emu $dst ^bin/hello.rom

