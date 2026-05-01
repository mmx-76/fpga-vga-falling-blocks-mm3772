# Changelog

All notable project and evidence-plan changes are documented in this file.

## [Unreleased]
### Added
- 2026-05-01 (Issue #7): Added `quartus/quartus_integration_notes.md` documenting Quartus top-level expectations, required RTL file list, board assumptions, manual setup steps, and required evidence capture items for MM3772.
- 2026-05-01 (Issue #7): Added lightweight integration testbench `sim/tb_top_integration.sv` to instantiate `FallingBlocksTop` with FPGA-style ports and check for basic output activity without unknown values.

### Changed
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
