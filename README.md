# Drifblim

[Drifblim](https://wiki.xxiivv.com/drifblim) is a uxntal assembler, written in [Uxntal](https://wiki.xxiivv.com/site/uxntal.html). 

The assembler is written in Uxntal itself, it's designed to be distributed as a rom to help bootstrap the uxn ecosystem. The goal is for Driflim to be as small it could possibly be made, and to release it as a print-friendly document, along with its source code and the mathematical definition of the Uxn virtual machine.

The Drifblim project also includes:

- `drifblim-hex.rom`: Creates a hex dump text file of a binary file.

**Warning**: This assembler does not currently checks for out-of-bounds relative literals.

## Build

This assembler is written in the language it is assembling, creating a chicken-and-egg problem. You have two choices, download a pre-assembled [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom)(1.2kb), or use [uxnasm.c](https://git.sr.ht/~rabbits/uxn/tree/main/item/src/uxnasm.c). 

```
uxncli bin/drifblim.rom src/drifblim.tal 
uxncli bin/drifblim.rom etc/move.tal
uxnemu etc/move.rom
```

If do not wish to assemble it yourself, you can download [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom).

_Drifblim is strong enough to lift Pokémon or people but has no control over its flight. This causes it to drift with the wind and end up anywhere._
