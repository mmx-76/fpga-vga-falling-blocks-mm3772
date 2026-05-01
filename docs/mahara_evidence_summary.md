# Mahara Evidence Summary (MM3772)

## HDL Synthesis Explanation (20-50 words)
This project demonstrates synthesizable SystemVerilog for VGA timing, pixel rendering, input conditioning, and falling-block control, compiled in Quartus and deployed to FPGA hardware to prove implementable HDL design and board-level behavior for MM3772.

## Digital Systems Used
The design uses synchronous digital logic clocked from `CLOCK_50`, including counters/state machines for VGA timing, combinational pixel generation, debounced/edge-detected button inputs, and grid-based game-state control integrated at top level.

## Required Video/Screenshot Evidence
- Quartus full compile success and timing summary.
- FPGA programming success in Quartus Programmer.
- VGA output image/video showing playfield and active block.
- Input demonstration showing button presses causing visible movement/reset.
- Evidence artifacts with MM3772 in filenames or visible frame labels.

## I/O Note
The VGA display is the main output interface, and the FPGA push buttons are the physical user input controls used to drive behavior in hardware.
