# Drifblim

[Drifblim](https://wiki.xxiivv.com/drifblim) is a [Uxntal](https://wiki.xxiivv.com/site/uxntal.html) assembler, written in that same language.

The assembler is written in about 400 lines, it's designed to help bootstrap the Uxn ecosystem and to demonstrate the concept of a personal one-page computer concept. The goal is for Driflim's source code to be released as a print-friendly document, along with its assembled hexadecimal data and the _napkin definition_ of the Uxn virtual machine.

The Drifblim project also includes a REPL program, called [varvara's bicycle](https://wiki.xxiivv.com/bicycle).

## Manual

- `LIST` Displays a list of all available routines.
- `PRINT/PRINT2` Prints the value at the top of the stack.
- `MOD/MOD2` Pushes the modulo of X and Y, onto the stack.
- `ABS/ABS2` Pushes the absolute value of X, onto the stack.
- `RAND/RAND2` Pushes a random value between 0 and X, onto the stack.
- `FRE` Prints the number of bytes left in memory.
- `NEW` Erases the current routines in memory.
- `QUIT` Turns off the system.

## Build

This assembler is written in the language it is assembling, creating a chicken-and-egg problem. You have two choices, download a pre-assembled [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom)(1300 bytes), or use [uxnasm.c](https://git.sr.ht/~rabbits/uxn/tree/main/item/src/uxnasm.c).

```sh
# from uxnasm
uxnasm src/drifblim.tal bin/drifblim.rom
# from drifblim.rom
uxncli bin/drifblim.rom src/drifblim.tal
```

If do not wish to assemble it yourself, you can download [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom).

_Drifblim is strong enough to lift Pokémon or people but has no control over its flight. This causes it to drift with the wind and end up anywhere._
