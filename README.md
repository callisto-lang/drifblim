# Drifblim

[Drifblim](https://wiki.xxiivv.com/drifblim) is a [Uxntal](https://wiki.xxiivv.com/site/uxntal.html) assembler, written in that same language.

The assembler is written in about 400 lines, it's designed to help bootstrap the Uxn ecosystem and to demonstrate the concept of a personal one-page computer concept. The goal is for Driflim's source code to be released as a print-friendly document, along with its assembled hexadecimal data and the _napkin definition_ of the Uxn virtual machine.

### Project

- `procblim.tal` Pre-processor.
- `drifblim.tal` Assembler.

#### Extras

- `unicycle.tal` Console REPL.
- `bicycle.tal` [Graphical REPL](https://wiki.xxiivv.com/bicycle).

## Build

This assembler is written in the language it is assembling, creating a chicken-and-egg problem. You have two choices, download a pre-assembled [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom)(1300 bytes), or use [uxnasm.c](https://git.sr.ht/~rabbits/uxn/tree/main/item/src/uxnasm.c).

```sh
# start with uxnasm
uxnasm src/drifblim.tal bin/drifblim.rom
# from drifblim.rom
uxncli bin/drifblim.rom src/drifblim.tal
# Pre-processor for macros
uxncli bin/procblim.rom etc/hello.tal
# Assembling hello.tal
uxncli bin/drifblim.rom etc/hello.pro.tal
mv etc/hello.pro.rom bin/hello.rom
uxncli bin/hello.rom
```

If do not wish to assemble it yourself, you can download [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom).

_Drifblim is strong enough to lift Pokémon or people but has no control over its flight. This causes it to drift with the wind and end up anywhere._
