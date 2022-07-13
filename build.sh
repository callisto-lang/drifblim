#!/bin/sh -e

echo "Cleaning.."
rm -rf bin
mkdir bin

rm -rf etc/*.sym
rm -rf etc/*.rom

if [ -e "$HOME/roms/uxnlin.rom" ]
then
	echo "Linting.."
	uxncli $HOME/roms/uxnlin.rom src/drifblim.tal
	uxncli $HOME/roms/uxnlin.rom src/bicycle.tal
	uxncli $HOME/roms/uxnlin.rom src/unicycle.tal
fi

echo "Assembling.."
uxnasm src/unicycle.tal bin/unicycle.rom
uxnasm src/bicycle.tal bin/bicycle.rom
uxnasm src/drifblim.tal bin/drifblim-bootstrap.rom 
uxncli bin/drifblim-bootstrap.rom src/drifblim.tal 
mv src/drifblim.rom bin/drifblim.rom

echo "Installing.."
if [ -d "$HOME/roms" ] && [ -e ./bin/drifblim.rom ]
then
	cp bin/drifblim.rom $HOME/roms
	cp bin/unicycle.rom $HOME/roms
	cp bin/bicycle.rom $HOME/roms
    echo "Installed in $HOME/roms" 
fi

echo "Assembling Examples, from Drifblim.."
uxncli bin/drifblim.rom etc/hello.tal
# uxncli bin/drifblim.rom etc/error.tal

# echo "Dumping hex.."
uxncli bin/drifblim.rom etc/format-hex.tal
uxncli etc/format-hex.rom bin/drifblim.rom

# echo "Running rom.."
# uxncli etc/hello.rom
uxn11 bin/bicycle.rom

# uxncli bin/drifblim.rom src/bicycle.tal && mv src/bicycle.rom bin/ && uxn11 bin/bicycle.rom

# uxncli ~/roms/uxnlin.rom src/prepro.tal && uxnasm src/prepro.tal bin/prepro.rom && uxncli bin/prepro.rom etc/macros.tal

