# Drifblim

[Drifblim](https://wiki.xxiivv.com/drifblim) is a uxntal assembler, written in [Uxntal](https://wiki.xxiivv.com/site/uxntal.html). It's meant to be as simple an assembler as I could possibly make it. The goal would be for it to be in the 1kb range. It will not support macros and includes.

## Build

You must have the [Uxn](https://git.sr.ht/~rabbits/uxn/) assembler and emulator.

```
uxncli bin/drifblim.rom src/drifblim.tal 
uxncli bin/drifblim.rom etc/move.tal
uxnemu etc/move.rom
```

If do not wish to assemble it yourself, you can download [drifblim.rom](https://rabbits.srht.site/drifblim/drifblim.rom).

