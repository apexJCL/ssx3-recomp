# Design notes

- **Where the layer turns on:** both in `build.stock_cmake`, which every
  packaging configure passes so a stale cache cannot keep it off, and as the
  `XBOXRECOMP_ENHANCE` cache default in `CMakeLists.txt`, so `ssx3 build`
  and a plain developer configure match the package. It is not FORCE:
  `-DXBOXRECOMP_ENHANCE=OFF` still builds the layer-free binary for A/B.
- **Stock by default:** every key in `config.default.toml` draws as stock
  (pacing and surface below), so with no player file the game draws as before. The A/B
  runs the scripted race (the bring-up's pad script and dump points) on
  both builds. The race is not deterministic run to run (lineup, music,
  rider positions), so the dumps are judged against a second layer-free
  run rather than for equality.
- **Pacing:** `present.pacing = "sleep"`, the toolkit's default, worded as
  BLiNX 2's file words it (`spin` is the console-original timing). SSX 3 is
  generated without `[pipeline] spin_waits`, so the key has no effect until
  it is. Because the file sets `sleep`, `xbr package` adds its frame pacing
  paragraph to the bundle README, as for BLiNX 2.
- **Present surface:** `surface = "auto"`, listed with BLiNX 2's comment.
  Under gamescope (the SteamOS launcher's Game Mode sets
  `RECOMP_HOST_GAMESCOPE=1`) auto resolves to `internal`: the frame-sized
  surface goes to gamescope to scale, where the layer-free build used a
  window. The frames do not depend on it, but it is the one stock
  difference a player can see, so the docs say "draws as stock" and name
  it. It is not yet run on the Deck in Game Mode (a follow-up in tasks).
- **Developer root:** `main.c` passes `.` as the user root, so a developer
  run from the project root reads a gitignored `config/config.toml`. A
  bundle's launcher sets `RECOMP_CONFIG` and the root is never used.
- **macOS seed:** SSX 3 never shipped `config/enhance.toml`, so the launcher
  copies `Resources/config.seed.toml` to `config/config.toml` whenever that
  file is missing, with no older-file branch.
- **Wizard options:** render scale (1 to 4, the toolkit's maximum) and
  fullscreen. Everything else is in `config.default.toml`, which the Options
  page points to.
- **Aspect:** the toolkit at the pinned commit accepts only `4:3`; anything
  else logs `display.aspect=... not implemented yet` and runs at 4:3. The
  default file lists the key with that note, and the 16:9 smoke run checks
  the message and a 4:3 frame.
