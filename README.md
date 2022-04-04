# Drifblim

[Drifblim](https://wiki.xxiivv.com/drifblim) is a uxntal assembler, written in [Uxntal](https://wiki.xxiivv.com/site/uxntal.html). 

The assembler is written in less than 400 lines of Uxntal, it's designed to help bootstrap the Uxn ecosystem and to demonstrate the concept of a personal one-page computer concept. The goal is for Driflim's source code to be released as a print-friendly document, along with its assembled hexadecimal data and the napkin definition of the Uxn virtual machine.

The Drifblim project also includes:

- `drifblim-hex.rom`: Creates a hex dump text file of a binary file.

## Build

This assembler is written in the language it is assembling, creating a chicken-and-egg problem. You have two choices, download a pre-assembled [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom)(1.2kb), or use [uxnasm.c](https://git.sr.ht/~rabbits/uxn/tree/main/item/src/uxnasm.c). 

```
uxncli bin/drifblim.rom src/drifblim.tal 
uxncli bin/drifblim.rom etc/move.tal
uxnemu etc/move.rom
```

If do not wish to assemble it yourself, you can download [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom).

_Drifblim is strong enough to lift Pokémon or people but has no control over its flight. This causes it to drift with the wind and end up anywhere._
