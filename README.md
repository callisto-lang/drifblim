# Drifblim

[Drifblim](https://wiki.xxiivv.com/drifblim) is a [Uxntal](https://wiki.xxiivv.com/site/uxntal.html) assembler, written in that same language.

The assembler is written in about 400 lines, it's designed to help bootstrap the Uxn ecosystem and to demonstrate the concept of a personal one-page computer concept. The goal is for Driflim's source code to be released as a print-friendly document, along with its assembled hexadecimal data and the _napkin definition_ of the Uxn virtual machine.

## Build

This assembler is written in the language it is assembling, creating a chicken-and-egg problem. You have two choices, download a pre-assembled [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom)(1300 bytes), or use [uxnasm.c](https://git.sr.ht/~rabbits/uxn/tree/main/item/src/uxnasm.c).

```sh
# start with uxnasm
uxnasm src/drifblim.tal bin/drifblim-seed.rom
# from drifblim.rom
uxncli bin/drifblim-seed.rom src/drifblim.tal bin/drifblim.rom
# Assembling hello.tal
uxncli bin/drifblim.rom etc/hello.tal bin/hello.rom
uxncli bin/hello.rom
```

If do not wish to assemble it yourself, you can download [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom).

_Drifblim is strong enough to lift Pokémon or people but has no control over its flight. This causes it to drift with the wind and end up anywhere._

## Project Mode

Drifblim allows for live-reloading when used as a `launcher.rom`(f4). To use this feature, you need to create a `.drifblim` file of 61 bytes to be loaded in the zero-page:

- `00-2f`, source path.
- `30-5f`, destination path.
- `60`, non-zero values will also run the run on assembly.

## Support

- Linted with [uxnlin.rom](https://git.sr.ht/~rabbits/uxnlin)
