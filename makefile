ID=drifloon
DIR=~/roms
ASM=uxnasm
LIN=uxncli ${DIR}/uxnlin.rom
BAL=uxncli ${DIR}/uxnbal.rom
EMU=uxncli
ROM=bin/${ID}.rom
SRC=src/${ID}.tal

all: ${ROM}

clean:
	@ rm -f ${ROM} ${ROM}.sym
lint:
	@ ${LIN} ${SRC}
bal:
	@ ${BAL} ${SRC}
run: all
	@ cat ${SRC} | ${EMU} ${ROM} > bin/drifloon-bootstrap.rom
	@ cat examples/coverage.tal | ${EMU} bin/drifloon-bootstrap.rom > bin/res.rom
	@ ${EMU} bin/res.rom
install: all
	@ cp ${ROM} ${DIR}
uninstall:
	@ rm -f ${DIR}/${ID}.rom

.PHONY: all clean lint run install uninstall

${ROM}: ${SRC}
	@ mkdir -p bin
	@ ${ASM} ${SRC} ${ROM}
