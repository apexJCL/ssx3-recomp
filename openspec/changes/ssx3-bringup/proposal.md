# SSX 3 bring-up on xbr

## Why
SSX 3 is the second XDK-5558-era title on my CLI and toolkit after BLiNX 2
and Burnout 3. It exercises paths those two do not: XAPI driving the OHCI USB
controllers itself, and an older D3D whose fence wait reads PGRAPH 0x400B10
in a different bit layout. koenhendriks/SSX3-recomp (the PAL release, GPL-2.0)
shows the game can run; I build mine from a clean `xbr new` of the USA disc
and use theirs as the testing reference, mapping addresses by code pattern.

## What changes
- A game project made with `xbr new` (xbr v0.7.6, toolkit blinx2-v0.4.0).
- Game-side fixes only, in `src/main.c`, `src/recomp_manual.c` and
  `config/seed_functions.json`. The toolkit gaps (the fence's bit layout,
  which should be per XDK, and the NV2A software method 5, BlockOnTime) are
  kept as game-side workarounds until the toolkit has the upstream v0.14.0
  sync they build on.
- Scripted Metal runs that reach a race, and a save fixture made by the user.

## Pass bar
The four #208 cases under `RECOMP_GUEST_LOCK=1`, then a proof-of-concept
PR.
