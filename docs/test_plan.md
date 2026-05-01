# Test and Evidence Plan

Project: FPGA VGA Falling-Block Game  
Student ID: **MM3772**

## 1. Purpose
Define how verification and synthesis evidence will be produced using Questa, Quartus Prime, and FPGA hardware demonstration.

## 2. Verification Stages

### Stage A: Module Simulation (Questa)
- Create focused testbenches for:
  - `vga_timing`
  - `input_controller`
  - `game_state_engine`
- Capture:
  - Simulation transcript/log output
  - Waveform screenshots for key timing/state transitions

### Stage B: Integration Simulation (Questa)
- Simulate top-level integration behavior under representative control inputs.
- Confirm synchronization among timing, input handling, and rendering interfaces.

### Stage C: Synthesis and Implementation (Quartus Prime)
- Run Analysis & Synthesis, Fitter, and Timing Analyzer.
- Capture:
  - Resource utilization reports
  - Timing summary and slack indicators
  - Pin assignment evidence for board interfaces

### Stage D: Hardware Validation (FPGA + VGA)
- Program FPGA with compiled bitstream.
- Capture video/photo evidence of VGA game output and user-input response.
- Include MM3772 in artifact naming and/or on-screen evidence notes.

## 3. Entry/Exit Criteria
- **Entry for RTL phase:** Documentation and requirements approved via PR.
- **Exit for milestone PRs:** Corresponding simulation/synthesis/hardware evidence attached and logged.

## 4. Evidence Mapping to Skills
- **4.1 Hardware Description Language**
  - SystemVerilog source evolution, simulation behavior, and successful synthesis outputs.
- **1.10 Change Management**
  - Issue definitions, branch strategy, commit records, PR discussions, and changelog/evidence updates.

## 5. Evidence Storage Conventions
- Use consistent names including date and `MM3772`.
- Keep references to artifact locations in `EVIDENCE_LOG.md` for assessor traceability.
