# SSX 3 golden scenarios

## Why
SSX 3 has no golden frames, so a toolkit change that breaks it shows up only
when someone plays it. BLiNX 2 and JSRF catch such breaks with `bench golden`
and `golden run`. The user asked (2026-10-24) for SSX 3 goldens
recorded first on native Windows, then under Proton on the Linux PC, then on Metal.

## What changes
- `config/golden/golden.json`: SSX 3's scenarios, frames, anchors and
  compare limits; `game.toml` gains `[golden]` and `[input]`.
- References are gitignored under `analysis/golden/`. They are game output,
  so they are never published. The pad routes are input timing, inlined in
  `golden.json`.
- Each frame holds one reference per host: `d3d11-windows`, `d3d11-proton`
  and `metal`.
- The CLI pin moves to f76a9a4 (anchors, flip-timed pad scripts), a commit
  with no release tag yet. Before SSX 3's public push, a CLI release that
  contains it is pushed and pinned (tag plus commit), and the toolkit pin
  moves to the public commit that carries the flip-timed pad scripts
  (private toolkit d5f17ed2 or later): at blinx2-v0.5.0 the runtime parses
  no `f<flip>:` steps, so the menu route would run 0 steps.

## Out of scope
- Audio goldens.
- CPU backend references (not in the routine gates).
