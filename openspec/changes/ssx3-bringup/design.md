# Design notes

- **USB:** `main.c` calls `xbox_OhciInit()` and defaults `RECOMP_USB` on. The
  XPP USB class-driver method tables sit in the XPP code section, which disasm
  does not scan, so six of their methods are seeds (the USA matches of the
  reference's PAL seeds; XPP is 0x53E0 lower on USA). The game reads
  controller slot 0, which is root port 3 (`usb_ndp=4,usb_port=2`).
  `main.c` defaults both as it does `RECOMP_USB` (a70e0ac): they are
  debug-tier keys, which a packaged bundle never sets, so without the
  default a player's game sees no pad. The environment still wins. They
  stay game-side; the toolkit's default layout is unchanged.
- **Fence wait:** XDK 5558's `sub_0022F470` spins on
  `(fence ^ PGRAPH[0x400B10]) & 0x1F`. The toolkit writes the fence to bits
  2..6, as later XDKs read it, so the frontend's first BlockOnTime never
  returned. `recomp_manual.c` replaced the function to compare bits 2..6
  until the toolkit learned the layout per XDK. Toolkit 18607bd9 (
  blinx2-v0.7.0) reads it from D3D's fence pair and writes bits 0..4 for
  SSX 3, so that override then hung the first load. It was
  removed, and the lifted function runs as it is.
- **CRT math:** `exp` and `fmod` replaced natively; the lifted x87 dispatcher
  returns with ebx clobbered (found by the reference on PAL).
- **Intros:** the movie mask at 0x002F9098 (bit 0 eabig, 1 thx, 2 intro_dj)
  is poked to 0 in test runs.
- **Saves:** a guest Single Event never writes a profile. Saving goes through
  Options > Save/Load or the lodge in Conquer The Mountain, so the fixture is
  made in an interactive session. The game writes it to the hard disk's user
  data (`UDATA/` in the toolkit's save folder, or under `RECOMP_SAVE_DIR`),
  and a copy of that folder is the fixture. Saves are never committed.
