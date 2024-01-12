ID=drifloon
DIR=~/roms
ASM=uxnasm
LIN=uxncli ${DIR}/uxnlin.rom
BAL=uxncli ${DIR}/uxnbal.rom
EMU=uxncli
ROM=bin/${ID}.rom

all: ${ROM}

clean:
	@ rm -f ${ROM} ${ROM}.sym
lint:
	@ ${LIN} src/${ID}.tal
bal:
	@ ${BAL} src/${ID}.tal
run: all
#	@ ${EMU} ${ROM} src/${ID}.tal ${ROM}
#	@ ${EMU} ${ROM} examples/hello.tal bin/hello.rom
#	@ ${EMU} bin/hello.rom
	@ uxnasm examples/hello.tal bin/a.rom
	@ uxncli ~/roms/hx.rom bin/a.rom
	@ uxncli bin/a.rom
	@ cat examples/hello.tal | ${EMU} ${ROM} > bin/b.rom
	@ uxncli ~/roms/hx.rom bin/b.rom
	@ uxncli bin/b.rom
install: all
	@ cp ${ROM} ${DIR}
uninstall:
	@ rm -f ${DIR}/${ID}.rom

.PHONY: all clean lint run install uninstall

${ROM}: src/${ID}.tal
	@ mkdir -p bin && ${ASM} src/${ID}.tal ${ROM}
