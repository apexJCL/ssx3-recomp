# Changelog

What changed for players in each release of the SSX 3 static
recompilation, newest first, in the style of
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Releases are
tagged `vYEAR.MONTH.N`, with `-rc.N` for release candidates, and each
release's section (`## [YEAR.MONTH.N] - date`) is its notes on the
[releases page](https://github.com/apexJCL/ssx3-recomp/releases); the
release workflow stops when a tag has none.
No release contains game data: you build the game from your own disc.

## [Unreleased]

### Changed
- **The cache partition lives in memory** (`storage.ram_cache = true`, the
  toolkit's new default for every game): what the game writes to its
  scratch cache drive while it plays stays in RAM, up to the console's
  750 MB, instead of being rewritten on your disk. The game sees the same
  files. `ram_cache = false` under `[storage]` in `config/config.toml`
  puts them back on the disk.

### Added
- **The real audio DSP, on by default.** The game's own sound programs now
  run on the emulated Xbox audio DSP (reverb, effect sends, the game's own
  mix) instead of a plain stereo fold. `RECOMP_APU_DSP=0` in
  `config/launch.env` brings the old sound back.
- The game boots through the front end into a race on macOS (Metal), with
  a controller. The Windows build (Direct3D 11, also for Linux through
  Proton) builds and packages, and has not been run yet.
- Bundles for Windows, SteamOS and macOS (`./ssx3 package`), with your own
  disc inside; the controller works without any setting.
- The build wizard's settings for this game, ready for the first release.
- Options in `config.toml`: render scale (up to 4x), anisotropic filtering,
  the present filter and fullscreen. The game draws as stock until you set
  one; the build wizard offers render scale and fullscreen.
