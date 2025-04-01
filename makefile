DIR=~/roms
ASM=uxnasm
EMU=uxncli
LIN=${EMU} ${DIR}/uxnlin.rom

all: bin/drifloon.rom bin/drifblim.rom

run: drifblim drifloon

drif: bin/drif.rom
	@ uxn11 bin/drif.rom etc/hello.tal bin/hello.rom
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
bootstrap: bin/drifblim.rom bin/hx.rom bin/xh.rom bin/eq.rom
	@ cat bin/drifblim.rom | ${EMU} bin/hx.rom > bin/a.rom.txt
	@ cat bin/a.rom.txt | ${EMU} bin/xh.rom > bin/a.rom
	@ ${EMU} bin/a.rom src/drifblim.tal bin/b.rom
	@ cat bin/b.rom | ${EMU} bin/hx.rom > bin/b.rom.txt
	@ ${EMU} bin/eq.rom bin/a.rom.txt bin/b.rom.txt
clean:
	@ rm -fr bin
lint: all
	@ ${LIN} src/drifloon.tal
	@ ${LIN} src/drifblim.tal
	@ ${LIN} src/drif.tal
	@ ${LIN} etc/hx.tal
	@ ${LIN} etc/xh.tal
	@ ${LIN} etc/eq.tal
archive: all bin/hx.rom
	@ cat src/drifblim.tal src/core.tal | sed 's/~[^[:space:]]\+//' > bin/drifblim.tal
	@ cat src/drifloon.tal src/core.tal > bin/drifloon.tal
	@ cp bin/drifblim.tal ../oscean/etc/drifblim.tal.txt
	@ cp bin/drifloon.tal ../oscean/etc/drifloon.tal.txt
	@ cat bin/drifblim.rom | ${EMU} bin/hx.rom > ../oscean/etc/drifblim.rom.txt
	@ cat bin/drifloon.rom | ${EMU} bin/hx.rom > ../oscean/etc/drifloon.rom.txt
	@ cp etc/hx.tal ../oscean/etc/hx.tal.txt
	@ cp etc/xh.tal ../oscean/etc/xh.tal.txt
	@ cp etc/eq.tal ../oscean/etc/eq.tal.txt
install: bin/drifloon.rom bin/drifblim.rom
	@ cp bin/drifloon.rom ${DIR}
	@ cp bin/drifblim.rom ${DIR}
uninstall:
	@ rm -f ${DIR}/drifloon.rom
	@ rm -f ${DIR}/drifblim.rom

.PHONY: all clean lint test run bootstrap archive install uninstall drifloon drifblim

bin/drifloon.rom: src/drifloon.tal src/core.tal
	@ mkdir -p bin
	@ cat src/drifloon.tal src/core.tal > bin/drifloon.tal
	@ ${ASM} bin/drifloon.tal bin/drifloon.rom

bin/drifblim.rom: src/drifblim.tal src/core.tal
	@ printf "Assemble drifblim.rom\n"
	@ mkdir -p bin
	@ ${ASM} src/drifblim.tal bin/drifblim.rom

bin/drif.rom: src/drif.tal src/drif.util.tal src/core.tal
	@ printf "Assemble drif.rom\n"
	@ mkdir -p bin
	@ ${ASM} src/drif.tal bin/drif.rom

bin/hx.rom: etc/hx.tal
	@ mkdir -p bin
	@ ${ASM} etc/hx.tal bin/hx.rom

bin/xh.rom: etc/xh.tal
	@ mkdir -p bin
	@ ${ASM} etc/xh.tal bin/xh.rom

bin/eq.rom: etc/eq.tal
	@ mkdir -p bin
	@ ${ASM} etc/eq.tal bin/eq.rom

