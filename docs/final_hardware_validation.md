# Final Hardware Validation Checklist (MM3772)

This checklist defines the final on-board validation flow for the EE22005 synthesis claim and should be followed in order.

## 1) Quartus Compile Checklist
- [ ] Open Quartus Prime project for this repository and confirm top-level entity is `FallingBlocksTop`.
- [ ] Confirm target FPGA device and pin assignments match the university board constraints.
- [ ] Run full compile: Analysis & Synthesis, Fitter, Assembler, and Timing Analyzer.
- [ ] Confirm compile completes with no fatal errors.
- [ ] Capture key report evidence: resource usage summary, timing summary, and generated programming file.
- [ ] Save report screenshots/PDF exports with `MM3772` in filename (for example: `MM3772_quartus_timing_summary.png`).

## 2) FPGA Programming Checklist
- [ ] Connect FPGA board via USB-Blaster and power on board.
- [ ] Open Programmer and select correct hardware setup.
- [ ] Add generated `.sof` file from latest successful compile.
- [ ] Program device and verify progress completes successfully.
- [ ] Record evidence screenshot of successful programming status (include `MM3772` label in capture filename).

## 3) VGA Monitor Setup Checklist
- [ ] Connect VGA cable from board VGA output to monitor input.
- [ ] Set monitor/source to VGA and verify signal lock.
- [ ] Confirm visible game playfield border/grid appears.
- [ ] Confirm on-screen `MM3772` marker text is visible.
- [ ] Capture a clear monitor photo/screenshot with board + screen in frame where possible.

## 4) Button Input Test Checklist
- [ ] Press left button and verify active block moves left by one grid step.
- [ ] Press right button and verify active block moves right by one grid step.
- [ ] Press down button and verify accelerated downward movement.
- [ ] Press reset button and verify game state resets cleanly.
- [ ] Repeat each button test multiple times to check stable debounced behavior.

## 5) Required Screenshots to Capture
- [ ] Quartus compile success overview (flow status).
- [ ] Timing summary page showing timing result.
- [ ] FPGA Programmer success/program complete view.
- [ ] VGA display showing playfield and `MM3772` marker.
- [ ] Action shot/frame showing button interaction effect (before/after movement).
- [ ] Repository evidence updates (`CHANGELOG.md` and `EVIDENCE_LOG.md`) ready for submission package.

## 6) If Quartus Compile Fails
1. Record exact failing stage and error text in notes (Analysis, Fitter, Assembler, or Timing).
2. Check top-level assignment, device selection, and pin constraints first.
3. Re-run compile after fixing configuration issues.
4. If HDL errors exist, apply only minimal corrective edits needed for consistency/synthesis.
5. Re-run compile and confirm error resolution.
6. Update `EVIDENCE_LOG.md` with failure/recovery trace so the process remains auditable for MM3772.
