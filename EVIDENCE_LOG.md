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
| EV-004 | TBC | 4.1 | Questa Simulation | Waveform captures and simulation transcript for timing generator and static renderer verification suite. | Planned |
| EV-005 | TBC | 4.1 | Quartus Compilation | Synthesis/Fitter/Timing report excerpts demonstrating implementable design. | Planned |
| EV-006 | TBC | 4.1, 1.10 | Hardware Video | VGA output demonstration on FPGA board with MM3772 visible in evidence title/frame. | Planned |
| EV-007 | TBC | 1.10 | GitHub Artifacts | Linked issue, branch, commits, review notes, and merge trail for each milestone. | Planned |

## Evidence Handling Notes
- Each milestone should update this table and cross-reference commit hash and pull request number.
- File/report naming should include `MM3772` where practical.
- Evidence should be captured in chronological order to support assessment traceability.
