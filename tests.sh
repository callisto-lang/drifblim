#!/bin/sh

roms_dir=${UXN_ROMS_DIR-"$HOME/roms"}
asm="uxncli bin/drifblim.rom"

# Usage(missing src)
$asm

# Usage(missing dst)
# $asm examples/hello.tal

echo ""
echo "== Assembling"

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
echo "Padding invalid: |what"
$asm "tests/err-pad.tal" "bin/res.rom"

echo ""
echo "Writing zero-page: #12"
$asm "tests/err-zep.tal" "bin/res.rom"

echo ""
echo "Writing rewind: #1234 |0100"
$asm "tests/err-rew.tal" "bin/res.rom"

echo ""
echo "== Resolving"

echo ""
echo "Label unknown: ADD2q"
$asm "tests/err-opc.tal" "bin/res.rom"

echo ""
echo "Label unknown: .missing"
$asm "tests/err-ref.tal" "bin/res.rom"

echo ""
echo "Relative reference too far: on-reset/back"
$asm "tests/err-far.tal" "bin/res.rom"

echo ""
echo "== STRICT"

echo ""
echo "          Nested ( in RESET."
$asm "tests/err-com.tal" "bin/res.rom"

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

