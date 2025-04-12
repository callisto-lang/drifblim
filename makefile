DIR=~/roms
EMU=uxncli
LIN=${EMU} ${DIR}/uxnlin.rom
ASM=${EMU} bin/drifblim.rom

all: bin/drifblim.rom

run: bin/drifblim.rom bin/drifloon.rom
	@ ${ASM} examples/acid.tal bin/acidblim.rom
	@ ${EMU} bin/acidblim.rom
	@ cat examples/acid.tal | ${EMU} bin/drifloon.rom > bin/acidloon.rom
	@ ${EMU} bin/acidblim.rom

test: bin/drifblim.rom
	@ ./tests.sh

bootstrap: bin/drifblim.rom bin/hx.rom bin/xh.rom bin/eq.rom
	@ cat bin/drifblim.rom | ${EMU} bin/hx.rom > bin/a.rom.txt
	@ cat bin/a.rom.txt | ${EMU} bin/xh.rom > bin/a.rom
	@ ${EMU} bin/a.rom src/drifblim.tal bin/b.rom
	@ cat bin/b.rom | ${EMU} bin/hx.rom > bin/b.rom.txt
	@ ${EMU} bin/eq.rom bin/a.rom.txt bin/b.rom.txt
	@ cp bin/b.rom.txt etc/drifblim.rom.txt

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

.PHONY: all run clean lint test bootstrap archive install uninstall drifloon drifblim

bin/drifblim.rom: src/drifblim.tal src/core.tal
	@ printf "Assemble drifblim.rom\n"
	@ mkdir -p bin
	@ xxd -r -p etc/drifblim.rom.txt bin/drifblim.rom

bin/drifloon.rom: src/drifloon.tal src/core.tal bin/drifblim.rom
	@ mkdir -p bin
	@ cat src/drifloon.tal src/core.tal > bin/drifloon.tal
	@ ${ASM} bin/drifloon.tal bin/drifloon.rom

bin/hx.rom: etc/hx.tal
	@ mkdir -p bin
	@ ${ASM} etc/hx.tal bin/hx.rom

bin/xh.rom: etc/xh.tal
	@ mkdir -p bin
	@ ${ASM} etc/xh.tal bin/xh.rom

bin/eq.rom: etc/eq.tal
	@ mkdir -p bin
	@ ${ASM} etc/eq.tal bin/eq.rom

bin/drif.rom: src/drif.tal src/drif.util.tal src/core.tal
	@ printf "Assemble drif.rom\n"
	@ mkdir -p bin
	@ ${ASM} src/drif.tal bin/drif.rom

