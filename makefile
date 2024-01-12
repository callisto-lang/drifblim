DIR=~/roms
ASM=uxnasm
LIN=uxncli ${DIR}/uxnlin.rom
BAL=uxncli ${DIR}/uxnbal.rom
EMU=uxncli

all: bin/drifloon.rom bin/drifblim.rom

run: run-drifloon run-drifblim
	
run-drifblim: bin/drifblim.rom
	@ printf "@@ Assemble drifblim-bootstrap from itself\n\n"
	@ ${EMU} bin/drifblim.rom src/drifblim.tal bin/drifblim-bootstrap.rom
	@ printf "\n@@ Test drifblim-bootstrap\n\n"
	@ ${EMU} bin/drifblim.rom examples/coverage.tal bin/res.rom
	@ ${EMU} bin/res.rom
run-drifloon: bin/drifloon.rom
	@ printf "@@ Assemble drifloon-bootstrap from itself\n\n"
	@ cat src/drifloon.tal | ${EMU} bin/drifloon.rom > bin/drifloon-bootstrap.rom
	@ printf "\n@@ Test drifloon-bootstrap\n\n"
	@ cat examples/coverage.tal | ${EMU} bin/drifloon-bootstrap.rom > bin/res.rom
	@ ${EMU} bin/res.rom
clean:
	@ rm -fr bin
lint:
	@ ${LIN} src/drifloon.tal
	@ ${LIN} src/drifblim.tal
bal:
	@ ${BAL} src/drifloon.tal
	@ ${BAL} src/drifblim.tal
install: all
	@ cp bin/drifloon.rom ${DIR}
	@ cp bin/drifblim.rom ${DIR}
uninstall:
	@ rm -f ${DIR}/drifloon.rom
	@ rm -f ${DIR}/drifblim.rom

.PHONY: all clean lint run install uninstall run-drifloon run-drifblim

bin/drifloon.rom: src/drifloon.tal
	@ mkdir -p bin
	@ ${ASM} src/drifloon.tal bin/drifloon.rom

bin/drifblim.rom: src/drifblim.tal
	@ mkdir -p bin
	@ ${ASM} src/drifblim.tal bin/drifblim.rom
