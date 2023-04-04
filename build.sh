#!/bin/sh -e

ASM="uxnasm"
EMU="uxncli"
LIN="uxncli $HOME/roms/uxnlin.rom"

SRC="src/drifblim.tal"
DST="bin/drifblim.rom"
CPY="$HOME/roms"
ARG="${SRC} ${DST}"

mkdir -p bin

if [[ "$*" == *"--lint"* ]]
then
	$LIN $SRC
fi

$ASM $SRC $DST

if [[ "$*" == *"--save"* ]]
then
	cp $DST $CPY
fi

printf "\nAssembling ${DST}(seed) with ${ASM}.\n\n"
$EMU $DST $ARG

printf "\nAssembling ${DST} with ${DST}.\n\n"
$EMU $DST examples/hello.tal bin/hello.rom

echo ""
$EMU bin/hello.rom

