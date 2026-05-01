# Evidence Log

Project: FPGA VGA Falling-Block Game  
Student ID: **MM3772**

## Evidence Objectives
- Demonstrate **4.1 Hardware Description Language** through synthesizable SystemVerilog architecture, implementation, and verification.
- Demonstrate **1.10 Change Management** through controlled issue/branch/PR lifecycle with auditable records.

## Planned Evidence Register

| ID | Date | Skill | Artifact Type | Description | Status |
|---|---|---|---|---|---|
| EV-001 | 2026-05-01 | 1.10 | Pull Request | Initial documentation PR defining requirements, workflow, and test strategy. | Complete |
| EV-002 | 2026-05-01 | 4.1, 1.10 | Source + Testbench + Commit History | GitHub Issue #1 implemented on `feature/vga-timing`: added `rtl/video/vga_timing.sv` and `sim/tb_vga_timing.sv` with MM3772 headers and VGA 640x480 timing logic from `CLOCK_50`. | Complete |
| EV-003 | 2026-05-01 | 4.1, 1.10 | Source + Testbench + Commit History | GitHub Issue #2 implemented on `feature/static-vga-renderer`: added `rtl/video/pixel_renderer.sv`, `rtl/top/FallingBlocksTop.sv`, and `sim/tb_pixel_renderer.sv` to render static border/grid/MM3772 marker using `vga_timing`. | Complete |
| EV-004 | 2026-05-01 | 4.1, 1.10 | Source + Testbench + Commit History | GitHub Issue #3 implemented on `feature/button-debounce-edge-detect`: added debounced/edge-detected player input modules and `sim/tb_button_inputs.sv` proving one-cycle pulses for left/right/down/reset from raw button activity. | Complete |
| EV-005 | 2026-05-01 | 4.1, 1.10 | Source + Testbench + Commit History | GitHub Issue #4 implemented on `feature/falling-block-core`: added `rtl/game/falling_block_controller.sv` and `sim/tb_falling_block_controller.sv`, and integrated active block rendering/wiring in top-level and pixel renderer for stage-1 gravity and input-driven movement. | Complete |
| EV-010 | 2026-05-01 | 4.1, 1.10 | Source + Integration Notes + Testbench + Commit History | GitHub Issue #7 on `integration/quartus-hardware-demo`: updated `FallingBlocksTop` as Quartus-ready FPGA top-level (CLOCK_50/KEY/SW/VGA), added `quartus/quartus_integration_notes.md`, and added `sim/tb_top_integration.sv` for interface-level integration checks. | Complete |
| EV-009 | 2026-05-01 | 4.1, 1.10 | Source + Testbench + Commit History | GitHub Issue #5 implemented on `feature/board-memory-collision`: added board memory + collision modules, integrated locking/respawn flow in controller/top-level, and updated renderer/testbenches to include locked-cell drawing and collision-lock validation. | Complete |
| EV-006 | TBC | 4.1 | Quartus Compilation | Synthesis/Fitter/Timing report excerpts demonstrating implementable design. | Planned |
| EV-007 | TBC | 4.1, 1.10 | Hardware Video | VGA output demonstration on FPGA board with MM3772 visible in evidence title/frame. | Planned |
| EV-008 | TBC | 1.10 | GitHub Artifacts | Linked issue, branch, commits, review notes, and merge trail for each milestone. | Planned |
| EV-009 | 2026-05-01 | 4.1, 1.10 | Source + Testbench + Commit History | GitHub Issue #6 implemented on `feature/line-clear-score-state`: added line-clear module and game-state/score-enabled gameplay pipeline (`line_clearer`, updated controller, top, and renderer) with Questa-compatible verification for full-row detect, clear+shift, score increment, and spawn-blocked game-over behaviour. | Complete |

| EV-010 | 2026-05-01 | 4.1, 1.10 | Documentation + Commit History | GitHub Issue #8 implemented on `docs/final-evidence-package`: produced final hardware validation checklist, demo script, Mahara evidence summary, and change-management evidence summary; updated changelog/evidence log for MM3772 final packaging. | Complete |

## Evidence Handling Notes
- Each milestone should update this table and cross-reference commit hash and pull request number.
- File/report naming should include `MM3772` where practical.
- Evidence should be captured in chronological order to support assessment traceability.

- Issue #6 milestone evidence currently includes source-level and Questa testbench-level verification in-repo; full tool execution logs are dependent on local Questa/Quartus availability.

- 2026-05-01: Quartus Prime Analysis & Synthesis currently fails on this branch baseline due to duplicate declarations/instances and top-level syntax errors in `rtl/video/pixel_renderer.sv` and `rtl/top/FallingBlocksTop.sv`; fixes are now committed on `fix/quartus-analysis-synthesis-errors`, and Quartus Analysis & Synthesis must be re-run after merge to capture updated EV-006 evidence for MM3772.
- 2026-05-01: Quartus Prime Analysis & Synthesis re-run on the post-top-level-fix baseline progressed to `rtl/video/pixel_renderer.sv` but failed with combinational-coding error (latch inference on `cell_x`/`cell_y` in `always_comb`, reported at line 38). Follow-up fix prepared on `fix/pixel-renderer-combinational-logic`; rerun required to capture clean EV-006 synthesis evidence for MM3772.

- 2026-05-01: Quartus compile/programming succeeded with CLOCK_50/KEY/SW/VGA color+sync pin mapping present, but VGA output remained blank until DE1-SoC control outputs (`VGA_CLK`, `VGA_BLANK_N`, `VGA_SYNC_N`) were exposed and driven in `rtl/top/FallingBlocksTop.sv` on branch `fix/de1-soc-vga-control-ports`.
