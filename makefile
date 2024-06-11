DIR=~/roms
ASM=uxnasm
LIN=uxncli ${DIR}/uxnlin.rom
BAL=uxncli ${DIR}/uxnbal.rom
EMU=uxncli

all: bin/drifloon.rom bin/drifblim.rom

run: run-drifblim 
	
run-drifblim: bin/drifblim.rom
	@ printf "++ Assemble drifblim-bootstrap from itself\n"
	@ ${EMU} bin/drifblim.rom src/drifblim.tal bin/drifblim-bootstrap.rom
	@ printf "\n++ Test drifblim-bootstrap\n"
	@ ${EMU} bin/drifblim.rom examples/coverage.tal bin/res.rom
	@ ${EMU} bin/res.rom
run-drifloon: bin/drifloon.rom
	@ printf "++ Assemble drifloon-bootstrap from itself\n"
	@ cat src/drifloon.tal | ${EMU} bin/drifloon.rom > bin/drifloon-bootstrap.rom
	@ printf "\n++ Test drifloon-bootstrap\n"
	@ cat examples/coverage.tal | ${EMU} bin/drifloon-bootstrap.rom > bin/res.rom
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

.PHONY: all clean lint run archive install uninstall run-drifloon run-drifblim

bin/drifloon.rom: src/drifloon.tal
	@ mkdir -p bin
	@ ${ASM} src/drifloon.tal bin/drifloon.rom

bin/drifblim.rom: src/drifblim.tal
	@ mkdir -p bin
	@ ${ASM} src/drifblim.tal bin/drifblim.rom

bin/hx.rom: src/hx.tal
	@ mkdir -p bin
	@ ${ASM} src/hx.tal bin/hx.rom

