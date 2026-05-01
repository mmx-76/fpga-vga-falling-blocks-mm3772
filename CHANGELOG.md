# Changelog

All notable project and evidence-plan changes are documented in this file.

## [Unreleased]
### Added
- Implemented VGA timing generator module in `rtl/video/vga_timing.sv` for 640x480 timing generation from `CLOCK_50` with a 25 MHz pixel enable.
- Added Questa-compatible testbench in `sim/tb_vga_timing.sv` to verify counter progression, visible-area signaling, and HSYNC/VSYNC pulse windows.
- Implemented static VGA pixel renderer in `rtl/video/pixel_renderer.sv` with a visible playfield border, grid-style background pattern, and a hard-coded on-screen `MM3772` marker.
- Added top-level static integration module in `rtl/top/FallingBlocksTop.sv` wiring `CLOCK_50` and `reset_n` to `vga_timing` and routing timing coordinates to `pixel_renderer` for VGA color output.
- Added Questa-compatible testbench in `sim/tb_pixel_renderer.sv` to check border, grid, playfield fill, marker, and blanking color cases.

### Changed
- Updated evidence artifacts to include Issue #1 implementation traceability for MM3772.
- Updated evidence artifacts to include Issue #2 static VGA renderer implementation traceability for MM3772.

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
