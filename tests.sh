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

# Usage(missing src)
$emu $dst

# Usage(missing dst)
$emu $dst examples/hello.tal

echo "          File missing.tal in RESET"
$emu $dst missing.tal "bin/res.rom"

echo "          File project.tal in RESET"
$emu $dst "tests/err-file.tal" "bin/res.rom"

echo "          Duplicate &sub in label."
$emu $dst "tests/err-dup.tal" "bin/res.rom"

echo "          Reference .missing in RESET."
$emu $dst "tests/err-ref.tal" "bin/res.rom"

echo "          Number #122325 in RESET."
$emu $dst "tests/err-lithex.tal" "bin/res.rom"

echo "          Number 122325 in RESET."
$emu $dst "tests/err-rawhex.tal" "bin/res.rom"

echo "          Distance ,label in RESET."
$emu $dst "tests/err-dis.tal" "bin/res.rom"

echo "          Zero-page #12 in RESET."
$emu $dst "tests/err-zep.tal" "bin/res.rom"

echo "          Rewind |0100 in RESET."
$emu $dst "tests/err-rew.tal" "bin/res.rom"

echo "          Symbol @1234 in 1234."
$emu $dst "tests/err-hex.tal" "bin/res.rom"

echo "          Opcode ADD2q in RESET."
$emu $dst "tests/err-opc.tal" "bin/res.rom"

echo "          Number 1234567 in RESET."
$emu $dst "tests/err-raw.tal" "bin/res.rom"

echo "          Nested ( in RESET."
$emu $dst "tests/err-com.tal" "bin/res.rom"

echo "          Length ab in RESET"
$emu $dst "tests/err-length.tal" "bin/res.rom"

echo "          Token @token-length-30-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa in reset"
$emu $dst "tests/err-toklen.tal" "bin/res.rom"

echo "          Sublabel &some-long-sublabel in token-length-20-aaaaaaaaaaaaaaaa"
$emu $dst "tests/err-lablen.tal" "bin/res.rom"


