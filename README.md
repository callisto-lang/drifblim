# Drifblim

[Drifblim](https://wiki.xxiivv.com/drifblim) is a uxntal assembler, written in [Uxntal](https://wiki.xxiivv.com/site/uxntal.html). 

It is meant to be as small as it could possibly be made. The goal would be for it to be in the 1kb range. It will not support macros and includes. Instead, a pre-processor rom might be considered.

The Drifblim project also includes:

- `drifblim-tga.rom`: Creates a grayscale tga image of a binary file.
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
