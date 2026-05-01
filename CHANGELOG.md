# Changelog

All notable project and evidence-plan changes are documented in this file.

## [Unreleased]
### Added
- Added final evidence package documentation for Issue #8 on `docs/final-evidence-package`, including `docs/final_hardware_validation.md`, `docs/video_demo_script.md`, `docs/mahara_evidence_summary.md`, and `docs/change_management_evidence_summary.md` for MM3772 final submission readiness.
- 2026-05-01 (Issue #7): Added `quartus/quartus_integration_notes.md` documenting Quartus top-level expectations, required RTL file list, board assumptions, manual setup steps, and required evidence capture items for MM3772.
- 2026-05-01 (Issue #7): Added lightweight integration testbench `sim/tb_top_integration.sv` to instantiate `FallingBlocksTop` with FPGA-style ports and check for basic output activity without unknown values.
- Issue #6 (`feature/line-clear-score-state`): added `rtl/game/line_clearer.sv` for synthesizable full-row detection, clear, and row-compaction logic.
- Issue #6: expanded `rtl/game/falling_block_controller.sv` with settled-board tracking, collision against settled cells, line clearing on lock, score increment on clears, and basic game states (start/running/game over) with spawn-blocked game-over detection.
- Issue #6: updated `rtl/video/pixel_renderer.sv` and `rtl/top/FallingBlocksTop.sv` to render settled board cells plus simple score/game-over indicators on VGA.
- Issue #6: added Questa-compatible `sim/tb_line_clearer.sv` and `sim/tb_game_state.sv`, and updated `sim/tb_pixel_renderer.sv` for score/state rendering checks.
### Added
- Added stage-1 falling block controller in `rtl/game/falling_block_controller.sv` with grid-based active block state, gravity tick descent, button-pulse movement, playfield boundary clamping, and bottom respawn behaviour.
- Added Questa-compatible gameplay testbench in `sim/tb_falling_block_controller.sv` covering reset, gravity motion, left/right/down moves, boundary clamping, and bottom respawn checks.
- Updated `rtl/video/pixel_renderer.sv` to draw the active falling block cell from controller grid coordinates while preserving existing border/grid/background/marker rendering.
- Updated `rtl/top/FallingBlocksTop.sv` to integrate button pulses with `falling_block_controller` and route active block position into the pixel renderer.
- Added player button input-conditioning modules in `rtl/input/button_debounce.sv`, `rtl/input/edge_detect.sv`, and `rtl/input/player_button_inputs.sv` for active-low FPGA push buttons with debounce and one-cycle pulse generation.
- Added Questa-compatible testbench in `sim/tb_button_inputs.sv` to verify bounced raw inputs are converted into single-cycle clean pulses for left/right/down/reset.
- Implemented VGA timing generator module in `rtl/video/vga_timing.sv` for 640x480 timing generation from `CLOCK_50` with a 25 MHz pixel enable.
- Added Questa-compatible testbench in `sim/tb_vga_timing.sv` to verify counter progression, visible-area signaling, and HSYNC/VSYNC pulse windows.
- Implemented static VGA pixel renderer in `rtl/video/pixel_renderer.sv` with a visible playfield border, grid-style background pattern, and a hard-coded on-screen `MM3772` marker.
- Added top-level static integration module in `rtl/top/FallingBlocksTop.sv` wiring `CLOCK_50` and `reset_n` to `vga_timing` and routing timing coordinates to `pixel_renderer` for VGA color output.
- Added Questa-compatible testbench in `sim/tb_pixel_renderer.sv` to check border, grid, playfield fill, marker, and blanking color cases.

- Added board memory module `rtl/game/board_memory.sv` and collision checker module `rtl/game/collision_checker.sv` to support locked-cell storage and downward collision checks for stage-2 gameplay.
- Updated `rtl/game/falling_block_controller.sv` to lock active blocks when downward movement is blocked and respawn a new block at top-centre.
- Updated `rtl/video/pixel_renderer.sv` and `rtl/top/FallingBlocksTop.sv` to route board-cell memory and render locked blocks alongside the active falling block.
- Added Questa-compatible testbenches `sim/tb_board_memory.sv` and `sim/tb_collision_checker.sv`; updated `sim/tb_falling_block_controller.sv` and `sim/tb_pixel_renderer.sv` for board-memory/collision behaviour coverage.

### Changed
- 2026-05-01 (fix/quartus-analysis-synthesis-errors): Resolved Quartus Analysis & Synthesis compile blockers by removing duplicate declarations in `rtl/video/pixel_renderer.sv` and consolidating `rtl/top/FallingBlocksTop.sv` to one valid integration path with single instances of `falling_block_controller`, `vga_timing`, and `pixel_renderer`.
- Updated `CHANGELOG.md` and `EVIDENCE_LOG.md` with final hardware validation/evidence packaging traceability for Issue #8 (MM3772).
- Updated evidence artifacts to include Issue #5 board memory and collision-locking implementation traceability for MM3772.
- Updated evidence artifacts to include Issue #4 stage-1 falling block core implementation traceability for MM3772.
- Updated evidence artifacts to include Issue #1 implementation traceability for MM3772.
- Updated evidence artifacts to include Issue #2 static VGA renderer implementation traceability for MM3772.
- Updated evidence artifacts to include Issue #3 button debounce and edge-detection implementation traceability for MM3772.
- 2026-05-01 (Issue #7): Updated `rtl/top/FallingBlocksTop.sv` to be the clear Quartus-facing FPGA top-level interface using `CLOCK_50`, `KEY[3:0]`, `SW[9:0]`, and VGA sync/color outputs while preserving existing game/video/input integration modules.
- 2026-05-01 (Issue #7): Updated evidence artifacts for Quartus integration and FPGA hardware demo preparation milestone traceability.

## [0.1.0] - 2026-05-01
### Added
- Initial project documentation baseline for EE22005 synthesis evidence.
- Project purpose, scope, and planned SystemVerilog module architecture in `README.md`.
- Repository agent guidance in `AGENTS.md`.
- Structured requirements definition in `docs/requirements.md`.
- Change-management approach in `docs/change_management_plan.md`.
- Verification and evidence test strategy in `docs/test_plan.md`.
- Evidence tracking scaffold in `EVIDENCE_LOG.md`.

### Evidence Relevance
- Establishes planned evidence for **Skill 4.1 (HDL)** via module-level design intent.
- Establishes planned evidence for **Skill 1.10 (Change Management)** via GitHub workflow and traceability policy.
