# SSX 3 with the enhancements layer

## Why
The first native Windows run showed that SSX 3 reads no `config.toml`: the
game is built without the toolkit's enhancements layer, so `render.scale`
and the other options do nothing, and the bundle ships no
`config.default.toml` for the installer to seed. BLiNX 2 and Burnout 3
already build with the layer on, every key at its stock value.

## What changes
- The layer is built: `-DXBOXRECOMP_ENHANCE=ON` in `game.toml`'s
  `build.stock_cmake` and as the CMake cache default, as Burnout 3 does.
  `main.c` already calls `xbox_enhance_init` when the layer is there.
- `packaging/config.default.toml` lists the toolkit's keys at their
  defaults: stock drawing (`render.scale = 1`, `display.aspect = "4:3"`,
  ...), plus `present.pacing = "sleep"` and `present.surface = "auto"` as
  BLiNX 2 ships them. Every package stages it, and a developer build copies
  it beside the executable.
- The macOS launcher names the player's file with `RECOMP_CONFIG` and copies
  the wizard's seed to `config/config.toml` when there is none, as BLiNX 2's
  does. The Windows installer and the SteamOS `install.sh` already do that.
- The build wizard offers render scale and fullscreen, like BLiNX 2.
- Docs that said "no enhancements layer" now say how to set options.

## Not in scope
- Wide aspect (Hor+). `display.aspect` stays as the toolkit has it today
  (only 4:3; any other value is reported and ignored). Native 16:9 per game
  is a separate change.
- Any toolkit change.

## Pass bar
- Stock drawing is unchanged: with no `config.toml` the layer reports every
  drawing key at its stock value and the scripted Metal race draws 640x480.
  The race's lineup and music vary run to run, so frames are not compared
  for equality.
- `render.scale = 2` renders the race at twice the detail on Metal and at
  1280x960 on D3D11 under Proton; `display.aspect = "16:9"` is reported and runs at 4:3.
- The stock run under Proton (D3D11) reaches the race.
