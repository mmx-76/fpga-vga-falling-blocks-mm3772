# Quartus Integration Notes (MM3772)

## 1) Expected top-level module name
- Use `FallingBlocksTop` as the Quartus Prime top-level entity.
- Source file: `rtl/top/FallingBlocksTop.sv`.

## 2) Required RTL source files
Add the following SystemVerilog files to the Quartus project:
- `rtl/top/FallingBlocksTop.sv`
- `rtl/video/vga_timing.sv`
- `rtl/video/pixel_renderer.sv`
- `rtl/input/player_button_inputs.sv`
- `rtl/input/button_debounce.sv`
- `rtl/input/edge_detect.sv`
- `rtl/game/falling_block_controller.sv`
- `rtl/game/board_memory.sv`
- `rtl/game/collision_checker.sv`

## 3) Expected board assumptions
- 50 MHz board clock available as `CLOCK_50`.
- Four active-low push buttons available as `KEY[3:0]`.
  - `KEY[0]`: async reset (`reset_n`)
  - `KEY[1]`: move left
  - `KEY[2]`: move right
  - `KEY[3]`: move down
- 10 slide switches available as `SW[9:0]` (currently reserved/unused in logic).
- VGA outputs connected for:
  - `VGA_R[3:0]`, `VGA_G[3:0]`, `VGA_B[3:0]`
  - `VGA_HS`, `VGA_VS`

## 4) Manual Quartus configuration still required
- Create a Quartus project targeting the correct university FPGA board/device.
- Set top-level entity to `FallingBlocksTop`.
- Add all required RTL files listed above.
- Assign pins in Pin Planner for `CLOCK_50`, `KEY`, `SW`, and VGA ports to board-specific pins.
- Confirm I/O standards (e.g., 3.3-V LVTTL where applicable) based on board manual.
- Run Analysis & Synthesis, Fitter, and Timing Analyzer.
- (Optional) Generate `.sof` and program device with Quartus Programmer.

## 5) Quartus evidence to capture for EE22005
Capture and archive the following artifacts for MM3772 evidence:
- Analysis & Synthesis summary (entity/module and resource summary).
- Fitter report summary (pin assignments accepted, routing success).
- Timing report summary (Fmax / slack for `CLOCK_50` domain).
- Compilation report screenshot(s) showing successful full compile.
- Pin assignment export (`.qsf` excerpt or screenshot).
- Hardware demonstration photo/video showing VGA output with on-screen `MM3772` marker.
