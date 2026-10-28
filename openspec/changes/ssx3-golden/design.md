# Design

## Scenarios
Found by exploration runs on native Windows (bench-logs 20261025-001519,
002155, 002513 for boot; 002400, 002722 for the menu), each dumping a frame
every 5 s (dump N is flip 60·N+1).
- `menu`: boot, Start into the title, wait for Press START, Start through
  the hard disk check into the main menu. 48 s. Pad steps are flip-timed and
  inlined as `RECOMP_PAD_SCRIPT` (a pad file cannot be shipped to a Windows
  host yet).
  - The first route (ms-timed, START every 1.5 s to 19.5 s, then A every
    2.5 s) passed on Windows but not on Proton. The intro movies (0 batches)
    run until a START lands after they turn skippable (~17-20 s of wall
    time), and the title ignores presses until its prompt shows (~295 flips
    in). So which press each screen took depended on the host's pace, and on
    Proton the menus ran one screen ahead with dumps on the transitions
    (runs 20261025-072135, 072347, 072435).
  - The route now presses START every 85 flips to f870 (THX and the logos),
    START at f1300 and a spare at f1360 (the title takes the first that lands
    after the movies and ignores the other), and START at f1850 on the prompt.
    No A: the disk check moves to the menu by itself. Each press lands well
    inside the screen that takes it (Proton exploration 20261025-072927).
    If f1300 is missed, f1360 opens the title ~60 flips later, so the
    scenario dumps 12 flips before and 72 after each target
    (`dump_slack` [12, 72]).
  - Anchors (batch counts): `title` (177, from flip 900), `hdd` (Checking
    hard disk, 131, from flip 1700 so a black flip on the title can't match), `main` (the Main Menu, 421). Each frame is checked at the
    same distance from its own screen as its reference: title +138 (prompt
    from ~+295), press-start +438 (START at ~+545), hdd +95 (of ~158), main
    +239 (settled from ~+55), from the reference run 20261025-073138.
  - dumps 5 and 10: the THX fade-in and logo, unanchored. The movie follows
    wall time, so the glint on the logo moves between runs; dump 10 has a
    region over its path with no tile limit (2% of pixels still gate it).
  - the title, press-start, hdd and main frames allow 3% bad pixels for the
    falling snowflakes (up to 1.3% of pixels, worst tile under 45%, in the Proton and Metal
    passes).
- Boot alone was dropped: past the THX logo, the intro movie and the attract
  demo follow wall time and differ between runs (normalised RMSE
  up to 0.39), and the menu run already covers THX.
- `race` waits: at toolkit 6a4ca369 entering Single Event
  crashes (a jump-table case split off as its own function by disasm's
  gap_prologue path). The route continues with A every 2.5 s to 109.5 s.

## References per host
Native Windows and Proton both run D3D11, but they pace and present
differently (BLiNX 2's tracker item), so each gets its own label:
- `d3d11-windows`
- `d3d11-proton`
- `metal`

The pace check reads a run's own backend's labels (`d3d11-*` for D3D11).

## Save
The scenarios boot on an empty hdd of their own. No hdd seed is needed
unless the race route has to skip profile creation.
