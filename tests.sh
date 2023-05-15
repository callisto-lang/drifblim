#!/bin/sh

name="drifblim"
roms_dir=${UXN_ROMS_DIR-"$HOME/roms"}
asm="uxnasm"
emu="uxncli"
lin="uxncli $roms_dir/uxnlin.rom"
src="src/${name}.tal"
dst="bin/${name}.rom"

mkdir -p bin

$asm $src $dst

echo "          Duplicate &sub in label."
$emu $dst "tests/err-dup.tal" "bin/res.rom"

echo "          Reference .missing in INIT."
$emu $dst "tests/err-ref.tal" "bin/res.rom"

echo "          Number #122325 in INIT."
$emu $dst "tests/err-num.tal" "bin/res.rom"

echo "          Distance ,label in INIT."
$emu $dst "tests/err-dis.tal" "bin/res.rom"

echo "          Zero-page #12 in INIT."
$emu $dst "tests/err-zep.tal" "bin/res.rom"

echo "          Rewind |0100 in INIT."
$emu $dst "tests/err-rew.tal" "bin/res.rom"

echo "          Invalid label @1234 in 1234."
$emu $dst "tests/err-hex.tal" "bin/res.rom"

echo "          Opcode ADD2q in INIT."
$emu $dst "tests/err-opc.tal" "bin/res.rom"

echo "          Number 1234567 in INIT."
$emu $dst "tests/err-raw.tal" "bin/res.rom"

echo "          Nested comment ( in INIT."
$emu $dst "tests/err-com.tal" "bin/res.rom"

echo "          Nested comment ( in INIT."
$emu $dst "tests/err-tok.tal" "bin/res.rom"

