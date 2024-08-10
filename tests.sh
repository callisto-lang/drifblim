#!/bin/sh

roms_dir=${UXN_ROMS_DIR-"$HOME/roms"}
asm="uxncli bin/drifblim.rom"

# Usage(missing src)
$asm

# Usage(missing dst)
# $asm examples/hello.tal

echo ""
echo "======================="

echo ""
echo "Source missing: missing.tal"
$asm "missing.tal" "bin/res.rom"

echo ""
echo "Output empty: bin/res.rom"
$asm "tests/err-empty.tal" "bin/res.rom"

echo ""
echo "Source missing: project.tal"
$asm "tests/err-file.tal" "bin/res.rom"

echo ""
echo "Label duplicate: &sub"
$asm "tests/err-dup.tal" "bin/res.rom"

echo ""
echo "Label invalid: @1234"
$asm "tests/err-hex.tal" "bin/res.rom"

echo ""
echo "Hexadecimal invalid: #122325"
$asm "tests/err-lithex.tal" "bin/res.rom"

echo ""
echo "Hexadecimal invalid: 122325"
$asm "tests/err-rawhex.tal" "bin/res.rom"

echo ""
echo "Writing zero-page: #12"
$asm "tests/err-zep.tal" "bin/res.rom"

echo ""
echo "Writing rewind: #1234 |0100"
$asm "tests/err-rew.tal" "bin/res.rom"

echo ""
echo "Opcode invalid: ADD2q"
$asm "tests/err-opc.tal" "bin/res.rom"

echo ""
echo "Label unknown: .missing"
$asm "tests/err-ref.tal" "bin/res.rom"

echo ""
echo "Reference too far: next"
$asm "tests/err-farfwd.tal" "bin/res.rom"

echo ""
echo "Reference too far: prev"
$asm "tests/err-farbwd.tal" "bin/res.rom"

echo ""
echo "          Length ab in RESET"
$asm "tests/err-length.tal" "bin/res.rom"

echo ""
echo "          Token @token-length-30-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa in reset"
$asm "tests/err-toklen.tal" "bin/res.rom"

echo ""
echo "          Sublabel &some-long-sublabel in token-length-20-aaaaaaaaaaaaaaaa"
$asm "tests/err-lablen.tal" "bin/res.rom"
echo ""


echo ""
echo "Assembled bin/res.rom in 148 bytes"
$asm "tests/err-farall.tal" "bin/res.rom"
