DIR=~/roms
ASM=uxnasm
LIN=uxncli ${DIR}/uxnlin.rom
BAL=uxncli ${DIR}/uxnbal.rom
EMU=uxncli

all: bin/drifloon.rom bin/drifblim.rom

run: drifblim drifloon

drifblim: bin/drifblim.rom
	@ printf "Assemble drifblim-bootstrap.rom with drifblim.rom\n"
	@ ${EMU} bin/drifblim.rom src/drifblim.tal bin/drifblim-bootstrap.rom
	@ printf "Test drifblim-bootstrap.rom\n"
	@ ${EMU} bin/drifblim.rom examples/acid-macros.tal bin/res.rom
	@ ${EMU} bin/res.rom
drifloon: bin/drifloon.rom
	@ cat examples/acid.tal | ${EMU} bin/drifloon.rom > bin/res.rom

#	@ printf ".. Assemble drifloon-bootstrap from itself\n"
#	@ cat src/drifloon.tal | ${EMU} bin/drifloon.rom > bin/drifloon-bootstrap.rom
#	@ printf "\n.. Test drifloon-bootstrap\n"
#	@ cat examples/acid.tal | ${EMU} bin/drifloon-bootstrap.rom > bin/res.rom
#	@ ${EMU} bin/res.rom
test: bin/drifblim.rom
	@ ./tests.sh
acid: bin/drifblim.rom
	@ ${EMU} bin/drifblim.rom examples/acid.tal bin/res.rom
	@ ${EMU} bin/res.rom
clean:
	@ rm -fr bin
lint: all
	@ ${LIN} src/drifloon.tal
	@ ${LIN} src/drifblim.tal
	@ ${LIN} src/hx.tal
bal: all
	@ ${BAL} src/drifloon.tal
	@ ${BAL} src/drifblim.tal
archive: all bin/hx.rom
	@ cp src/drifloon.tal ../oscean/etc/drifloon.tal.txt
	@ cp src/drifblim.tal ../oscean/etc/drifblim.tal.txt
	@ cat bin/drifloon.rom | ${EMU} bin/hx.rom > ../oscean/etc/drifloon.rom.txt
	@ cat bin/drifblim.rom | ${EMU} bin/hx.rom > ../oscean/etc/drifblim.rom.txt
install: all bin/hx.rom
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
	@ printf "Assemble drifblim.com\n"
	@ mkdir -p bin
	@ ${ASM} src/drifblim.tal bin/drifblim.rom

bin/hx.rom: src/hx.tal
	@ mkdir -p bin
	@ ${ASM} src/hx.tal bin/hx.rom

