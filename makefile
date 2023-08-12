ID=drifblim
DIR=~/roms
ASM=uxnasm
LIN=uxncli ${DIR}/uxnlin.rom
EMU=uxncli
ROM=bin/${ID}.rom

all: ${ROM}

clean:
	@ rm -f ${ROM} ${ROM}.sym
lint:
	@ ${LIN} src/${ID}.tal
run: ${ROM}
	@ ${EMU} ${ROM} src/${ID}.tal ${ROM}
	@ ${EMU} ${ROM} examples/hello.tal bin/hello.rom
	@ ${EMU} bin/hello.rom
install: ${ROM}
	@ cp ${ROM} ${DIR}
uninstall:
	@ rm -f ${DIR}/${ID}.rom

.PHONY: all clean lint run install uninstall

${ROM}: src/${ID}.tal
	@ mkdir -p bin && ${ASM} src/${ID}.tal ${ROM}
