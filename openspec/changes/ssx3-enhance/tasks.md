# Tasks

## 1. Build
- [x] 1.1 `build.stock_cmake = ["-DXBOXRECOMP_ENHANCE=ON"]` in `game.toml`.
- [x] 1.2 `XBOXRECOMP_ENHANCE` cache default ON in `CMakeLists.txt`, before
      the toolkit's `add_subdirectory`.

## 2. Options
- [x] 2.1 `packaging/config.default.toml` with every key at its default
      (stock drawing; pacing `sleep`, surface `auto`).
- [x] 2.2 macOS launcher: `RECOMP_CONFIG` and the seed copy.
- [x] 2.3 Wizard options: render scale and fullscreen.
- [x] 2.4 Docs: README options section, the launcher and `game.toml`
      comments, CHANGELOG.

## 3. Gates
- [x] 3.1 Mac build; `uv run pytest scripts`, ruff.
- [x] 3.2 Metal stock A/B against the layer-free build on the scripted race.
      Frame equality is not reachable: two layer-free runs of the same pad
      script draw a different opponent lineup and EA Radio track, and the
      riders split up on the course. The evidence is the stock run's
      `[ENHANCE]` log (640x480, every drawing key at stock) and the code
      reading: with those values the layer leaves the draw path as it was.
      For context only, pixels differing at flips 1500, 3000, 4600, 5800 and
      7000: base vs base2 93-99%, base vs stock 54-99%, base2 vs stock
      93-99%. The race varies that much run to run.
- [x] 3.3 Metal smoke: `render.scale = 2` (the race at twice the detail:
      `fb_dump` frames stay 640x480 by design, Metal box-filters the
      write-back, so the check is the window shot against stock's) and
      `display.aspect = "16:9"` (reported, 4:3).
- [x] 3.4 Proton (D3D11, GE-Proton11-7, the package's Mac-built exe):
      stock reaches the race at 640x480 with every key at stock;
      `render.scale = 2` draws the race at 1280x960 (`d3d11_dump`). A bench
      run sets `RECOMP_PB_BACKEND=d3d11` itself: it skips the launcher's
      `launch.env.default`, and the exe alone draws on the CPU.
- [x] 3.5 Packages: `config.default.toml` in the windows, steamos and macos
      bundles.

## 4. Follow-ups
- [ ] 4.1 SteamOS Game Mode on the Deck: `present.surface = "auto"` resolves
      to `internal` under gamescope, so the bundle hands gamescope the
      frame-sized surface where the layer-free build used a window. Not run
      yet.
