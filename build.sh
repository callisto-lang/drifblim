#!/bin/sh -e

echo "Cleaning.."
rm -rf bin
mkdir bin

rm -rf etc/*.sym
rm -rf etc/*.rom

echo "Assembling.."
uxnasm src/drifblim.tal bin/drifblim-bootstrap.rom 
uxncli bin/drifblim-bootstrap.rom src/drifblim.tal 
mv src/drifblim.rom bin/drifblim.rom

echo "Installing.."
if [ -d "$HOME/roms" ] && [ -e ./bin/drifblim.rom ]
then
	cp ./bin/drifblim.rom $HOME/roms
    echo "Installed in $HOME/roms" 
fi

echo "Assembling Examples, from Drifblim.."
uxncli bin/drifblim.rom etc/hello.tal
# uxncli bin/drifblim.rom etc/error.tal

# echo "Dumping hex.."
uxncli bin/drifblim.rom etc/format-hex.tal
uxncli etc/format-hex.rom bin/drifblim.rom

# echo "Running rom.."
uxncli etc/hello.rom

# uxncli bin/drifblim.rom src/bicycle.tal && mv src/bicycle.rom bin/ && uxn11 bin/bicycle.rom

# uxnasm src/unicycle.tal bin/unicycle.rom && uxncli bin/unicycle.rom
