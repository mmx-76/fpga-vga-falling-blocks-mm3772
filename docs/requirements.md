# Requirements (Initial)

Project: FPGA VGA Falling-Block Game  
Student ID: **MM3772**

## 1. Purpose
Develop a synthesizable SystemVerilog design that runs a falling-block game on the university FPGA board, outputs graphics via VGA, and provides sufficient project evidence for EE22005 assessment.

## 2. Functional Requirements
1. The design shall accept a 50 MHz board clock (`CLOCK_50`) as its primary timing source.
2. The design shall use push buttons and/or switches for gameplay control (e.g., move/rotate/drop/reset).
3. The design shall generate valid VGA synchronization and color output for monitor display.
4. The design shall manage falling-block state, collision checks, and game-over conditions.
5. The design shall support deterministic reset behavior.

## 3. Non-Functional Requirements
1. HDL implementation shall be written in **SystemVerilog only**.
2. The design shall be compatible with **Questa** simulation.
3. The design shall be synthesizable in **Quartus Prime** for the university board.
4. Code and artifacts shall include traceability markers for student ID **MM3772**.

## 4. Planned Module Decomposition
- `top_mm3772`
- `clock_reset`
- `input_controller`
- `game_state_engine`
- `vga_timing`
- `video_renderer`
- `score_display` (optional)

## 5. Evidence-Oriented Requirements
1. Simulation evidence must include testbench outputs and/or waveforms for core modules.
2. Synthesis evidence must include Quartus reports (resource usage and timing).
3. Hardware evidence must include VGA demonstration media tied to MM3772.
4. Change-management evidence must include issue links, branch names, commits, and PR records.
