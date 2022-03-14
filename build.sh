#!/bin/sh -e

echo "Cleaning.."
rm -rf bin
mkdir bin

echo "Assembling.."
uxnasm src/drifblim.tal bin/drifblim.rom 

echo "Installing.."
if [ -d "$HOME/roms" ] && [ -e ./bin/drifblim.rom ]
then
	cp ./bin/drifblim.rom $HOME/roms
    echo "Installed in $HOME/roms" 
fi

if [ "${1}" = '--push' ]; 
then
	echo "Pushing.."
	~/Applications/butler push bin/drifblim.rom hundredrabbits/drifblim:uxn
fi

rm -rf etc/*.sym
rm -rf etc/*.rom

echo "Assembling Drifblim.."
uxncli bin/drifblim.rom src/drifblim.tal 
echo "Assembling Examples, from Drifblim.."
uxncli bin/drifblim.rom etc/hello.tal
uxncli bin/drifblim.rom etc/primes.tal
uxncli bin/drifblim.rom etc/fizzbuzz.tal
uxncli bin/drifblim.rom etc/drifblim-tga.tal 
uxncli bin/drifblim.rom etc/move.tal

echo "Drawing output.tga"
uxncli etc/drifblim-tga.rom src/drifblim.rom 
echo "Running Hello.."
uxnemu etc/move.rom
# uxncli etc/hello.rom