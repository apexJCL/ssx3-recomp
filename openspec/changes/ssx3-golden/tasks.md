# Tasks

## 1. Exploration
- [x] 1.1 Build at the latest toolkit and CLI (toolkit posix-host/portability 6a4ca369, CLI f76a9a4)
- [x] 1.2 Native Windows exploration runs of boot and race; pick the frames (menu only; race waits)

## 2. Native Windows
- [x] 2.1 Record the `d3d11-windows` references
- [x] 2.2 Two more `bench golden` runs pass on Windows (20261025-003048, 003148; exe b36836a3)
- [ ] 2.3 At the next Windows boot (never switch it): on the exe rebuilt at toolkit d5f17ed2, re-confirm the THX refs and record `d3d11-windows` refs for the four anchored frames of the redesigned route (menu-title, menu-press-start, menu-hdd, menu-main), then two passes

## 3. Proton (the Linux PC; the user switches the boot)
- [x] 3.1 Record the `d3d11-proton` references (THX from 20261025-072135, the anchored four from 073138; exe 51a9d242, toolkit d5f17ed2)
- [x] 3.2 Two more runs pass (20261025-073313, 073411)

## 4. Metal (last, quiet)
- [x] 4.1 Record the `metal` references with `golden run` (20261025-073701-metal-menu; macOS exe 7fc72863, toolkit d5f17ed2; it already passed vs d3d11-proton before recording)
- [x] 4.2 Two more runs pass (073800-metal-menu, 073841-metal-menu)

## 5. Race (after the tracker item)
- [ ] 5.1 Deferred to a follow-up item (filed at the menu merge): add the race scenario and record its references on all three hosts. The menu golden lands first

## 6. Land
- [x] 6.1 Move the CLI pin (commit f76a9a4); pytest and ruff gates; review and its fixes
- [ ] 6.2 Squash-merge (the coordinator)
- [x] 6.3 Before SSX 3's public push: a CLI release that contains f76a9a4 is pushed and pinned (tag plus commit), and `[toolkit]` moves to the public commit with the flip-timed pad scripts (private d5f17ed2 or later); at blinx2-v0.5.0 the menu route runs 0 pad steps (push round 14: CLI v0.13.0 at 33390f6, toolkit blinx2-v0.7.0 at 178657a, which carries d5f17ed2's flip-timed pad scripts)
