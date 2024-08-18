#!/bin/sh

roms_dir=${UXN_ROMS_DIR-"$HOME/roms"}
asm="uxncli bin/drifblim.rom"

# Usage(missing src)
echo "usage: drifblim.rom in.tal out.rom"
$asm

echo ""
echo "======================="

echo ""
echo "File missing: missing.tal"
$asm "missing.tal" "bin/res.rom"

echo ""
echo "Output empty: bin/res.rom"
$asm "tests/err-empty.tal" "bin/res.rom"

echo ""
echo "File missing: project.tal"
$asm "tests/err-file.tal" "bin/res.rom"

echo ""
echo "Label duplicate: &sub"
$asm "tests/err-dup1.tal" "bin/res.rom"

echo ""
echo "Label duplicate: @TEST"
$asm "tests/err-dup2.tal" "bin/res.rom"

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
echo "Reference invalid: missing"
$asm "tests/err-ref.tal" "bin/res.rom"

echo ""
echo "Reference too far: next"
$asm "tests/err-farfwd.tal" "bin/res.rom"

echo ""
echo "Reference too far: back"
$asm "tests/err-farbwd.tal" "bin/res.rom"

echo ""
echo "Token size exceeded: @aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
$asm "tests/err-token.tal" "bin/res.rom"

echo ""
echo "Program size exceeded: ab"
$asm "tests/err-length.tal" "bin/res.rom"

echo ""
echo "Macro invalid: %ADD"
$asm "tests/err-macro.tal" "bin/res.rom"

echo ""
echo "Label duplicate: %TEST"
$asm "tests/err-macrodup1.tal" "bin/res.rom"

echo ""
echo "Label duplicate: %TEST"
$asm "tests/err-macrodup2.tal" "bin/res.rom"



