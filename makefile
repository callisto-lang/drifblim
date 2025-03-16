DIR=~/roms
ASM=uxnasm
EMU=uxncli
LIN=${EMU} ${DIR}/uxnlin.rom

all: bin/drifloon.rom bin/drifblim.rom

run: drifblim drifloon

drif: bin/drif.rom
	@ uxn11 bin/drif.rom
drifblim: bin/drifblim.rom
	@ printf "\nDrifblim Bootstrap\n"
	@ ${EMU} bin/drifblim.rom src/drifblim.tal bin/drifblim-bootstrap.rom
	@ printf "\nDrifblim Bootstrap(acid)\n"
	@ ${EMU} bin/drifblim-bootstrap.rom examples/acid.tal bin/blimacid.rom
	@ ${EMU} bin/blimacid.rom
drifloon: bin/drifloon.rom
	@ printf "\nDrifloon Bootstrap\n"
	@ cat bin/drifloon.tal | ${EMU} bin/drifloon.rom > bin/drifloon-bootstrap.rom
	@ printf "\nDrifloon Bootstrap(acid)\n"
	@ cat examples/acid.tal | ${EMU} bin/drifloon-bootstrap.rom > bin/loonacid.rom
	@ ${EMU} bin/loonacid.rom
test: bin/drifblim.rom
	@ ./tests.sh
clean:
	@ rm -fr bin
lint: all
	@ ${LIN} src/drifloon.tal
	@ ${LIN} src/drifblim.tal
	@ ${LIN} etc/hx.tal
archive: all bin/hx.rom
	@ cat src/drifblim.tal src/core.tal | sed 's/~[^[:space:]]\+//' > bin/drifblim.tal
	@ cat src/drifloon.tal src/core.tal > bin/drifloon.tal
	@ cp bin/drifblim.tal ../oscean/etc/drifblim.tal.txt
	@ cp bin/drifloon.tal ../oscean/etc/drifloon.tal.txt
	@ ${EMU} bin/hx.rom bin/drifblim.rom > ../oscean/etc/drifblim.rom.txt
	@ ${EMU} bin/hx.rom bin/drifloon.rom > ../oscean/etc/drifloon.rom.txt
install: bin/drifloon.rom bin/drifblim.rom
	@ cp bin/drifloon.rom ${DIR}
	@ cp bin/drifblim.rom ${DIR}
uninstall:
	@ rm -f ${DIR}/drifloon.rom
	@ rm -f ${DIR}/drifblim.rom

.PHONY: all clean lint test run archive install uninstall drifloon drifblim

bin/drifloon.rom: src/drifloon.tal src/core.tal
	@ mkdir -p bin
	@ cat src/drifloon.tal src/core.tal > bin/drifloon.tal
	@ ${ASM} bin/drifloon.tal bin/drifloon.rom

bin/drifblim.rom: src/drifblim.tal src/core.tal
	@ printf "Assemble drifblim.rom\n"
	@ mkdir -p bin
	@ ${ASM} src/drifblim.tal bin/drifblim.rom

bin/drif.rom: src/drif.tal src/core.tal
	@ printf "Assemble drif.rom\n"
	@ mkdir -p bin
	@ ${ASM} src/drif.tal bin/drif.rom

bin/hx.rom: etc/hx.tal
	@ mkdir -p bin
	@ ${ASM} etc/hx.tal bin/hx.rom

