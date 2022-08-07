#!/bin/sh -e

echo "Cleaning.."
rm -rf bin
mkdir bin

rm -rf etc/*.sym
rm -rf etc/*.rom

if [ -e "$HOME/roms/uxnlin.rom" ]
then
	echo "Linting.."
	# uxncli $HOME/roms/uxnlin.rom src/procblim.tal
	uxncli $HOME/roms/uxnlin.rom src/drifblim.tal
fi

uxnasm src/drifblim.tal bin/drifblim.rom
# uxncli bin/drifblim-bootstrap.rom src/procblim.tal
# uxncli bin/drifblim-bootstrap.rom src/drifblim.tal
# mv src/procblim.rom bin/procblim.rom
# mv src/drifblim.rom bin/drifblim.rom

if [ -d "$HOME/roms" ] && [ -e ./bin/drifblim.rom ]
then
	# cp bin/procblim.rom $HOME/roms
	# cp bin/drifblim.rom $HOME/roms
    echo "Installed in $HOME/roms" 
fi

# Pre-processing hello.tal
# uxncli bin/procblim.rom etc/hello.tal

# Assembling hello.tal
# uxncli bin/drifblim.rom etc/hello.pro.tal
# mv etc/hello.pro.rom bin/hello.rom

# echo "Dumping hex.."
# uxncli bin/drifblim.rom etc/format-hex.tal
# uxncli etc/format-hex.rom bin/drifblim.rom

# Running hello.tal
uxncli bin/drifblim.rom etc/hello.tal
