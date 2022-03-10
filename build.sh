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

rm -rf etc/move.sym
rm -rf etc/move.rom

echo "Running.."
uxncli bin/drifblim.rom etc/move.tal && uxnemu etc/move.rom
