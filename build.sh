#!/bin/sh -e

echo "Cleaning.."
rm -rf bin
mkdir bin

echo "Assembling.."
uxnasm src/main.tal bin/drifblim.rom 

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

rm -rf etc/primes.sym
rm -rf etc/primes.rom

echo "Running.."
uxncli bin/drifblim.rom etc/primes.tal && uxncli etc/primes.rom
