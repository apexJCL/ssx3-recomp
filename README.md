# SSX 3 static recompilation

A port of the original Xbox game *SSX 3* to native code with the
[xboxrecomp](https://github.com/apexJCL/xboxrecomp) toolkit, driven by
[xboxrecomp-cli](https://github.com/apexJCL/xboxrecomp-cli). The game's
code is translated ahead of time into C and built for Windows, Linux
(through Proton) and macOS. There is no CPU emulator at run time; the
sound chip (APU) and the GPU (NV2A) are emulated by the toolkit.

**No game data here, and none ever will be.** You need your own copy of the
USA disc. Put its files (`default.xbe` and the rest) in `game_files/`; git
ignores the folder.

## Progress

An early port. On all three platforms the game boots through the front end
into a race with a controller.

| Platform | Renderer | State |
|---|---|---|
| Linux, Steam Deck (Proton) | Direct3D 11 through DXVK | tested: title screen into a race |
| macOS (Apple silicon) | Metal | tested: title screen into a race |
| Windows | Direct3D 11 | played: races at 60 Hz |

Known gaps: the sound stutters a little, and a full play-through has not
been tried. Only the USA release is supported.

## Playing

There are no releases yet. Once there are, each release on this repository's
GitHub page carries a build wizard for Windows, macOS and Linux: it fetches
this source at the release, builds it on your machine and packages it with
your own disc, so no game code or data is ever downloaded. Until then, build
from source as below; `./ssx3 package` makes the same bundle.

## Options

The game reads its options from `config.toml`: in a bundle, `config/config.toml`
in the game's data folder; in a developer checkout, `config/config.toml` in
the project root. `config.default.toml` (beside the executable,
`packaging/config.default.toml` here) lists every key at its default;
copy a line into your `config.toml` to change it, for example
`scale = 2` under `[render]` to draw at 1280x960. With no `config.toml` the
game draws as stock. Two defaults are not the layer-free build's:
`present.pacing = "sleep"` (no effect yet, since SSX 3 is not generated
with spin waits; `"spin"` is the console-original timing) and
`present.surface = "auto"`, which in SteamOS Game Mode hands gamescope the
frame-sized surface to scale instead of a window (`"window"` restores that).

## Building from source

```sh
./ssx3 setup      # once: .venv, llvm-mingw, the toolkit (each download sha256-pinned)
./ssx3 all        # analyze (parse, disasm, funcid, abi), recomp, build
./ssx3 doctor     # what this machine has, and what is next
```

Windows: `ssx3` (the `ssx3.cmd` wrapper) or `py -3 ssx3.py`, from a
short checkout path such as `C:\g\ssx3`, with
`git config --global core.longpaths true`.

The build is `build-win/ssx3_recomp.exe`, cross-compiled with llvm-mingw on
any host, or `build/ssx3_recomp` with Apple clang on a Mac (Metal).
`src/recomp_manual.c` takes hand-written overrides, `config/seed_functions.json`
the function starts the disassembler missed, and `./ssx3 analyze` then
`./ssx3 recomp` regenerate `src/recomp/gen/` (never edit it by hand).
The CLI's `docs/porting.md` has the loop; `game.toml` has every setting,
documented in the CLI's `docs/manifest.md`. Design notes are in
`openspec/`.

The checks, as CI runs them:

```sh
uv run pytest scripts
uv run ruff check . && uv run ruff format --check .
```

## Licence and credits

MIT, see [LICENSE](LICENSE). Parts of `src/main.c`, `src/recomp_manual.c` and
`CMakeLists.txt` started from xboxrecomp's MIT-licensed new-game templates;
the licence file carries that notice too.

The toolkit that the build links in statically carries LGPL-2.1 APU code
extracted from xemu. If you distribute a built binary, read [NOTICE](NOTICE)
first.

Built on [xboxrecomp](https://github.com/sp00nznet/xboxrecomp) by sp00nznet,
through my fork, and on xboxrecomp-cli. *SSX 3* is a trademark of Electronic
Arts; this project is not affiliated with or endorsed by them.
