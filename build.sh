#!/bin/sh -e

echo "Cleaning.."
rm -rf bin
mkdir bin

if [ -e "$HOME/roms/uxnlin.rom" ]
then
	echo "Linting.."
	uxncli $HOME/roms/uxnlin.rom src/drifblim.tal
	uxncli $HOME/roms/uxnlin.rom src/drifloon.tal
fi

uxnasm src/drifblim.tal bin/drifblim-seed.rom
uxnasm src/drifloon.tal bin/drifloon.rom

if [ -d "$HOME/roms" ] && [ -e bin/drifblim-seed.rom ]
then
	cp bin/drifblim-seed.rom $HOME/roms/drifblim.rom
	cp bin/drifloon.rom $HOME/roms/
	echo "Installed in $HOME/roms"
fi

# Running

uxncli bin/drifblim-seed.rom src/drifblim.tal bin/drifblim.rom
uxncli bin/drifblim.rom examples/hello.tal bin/hello.rom
uxncli bin/hello.rom

# Pack

