# Repository Working Instructions

## Purpose
This repository is used to generate synthesis evidence for EE22005 using a SystemVerilog FPGA VGA falling-block game project for student **MM3772**.

## Scope and Constraints
- Use **SystemVerilog only** for HDL implementation work.
- Primary tools are **Questa** (simulation) and **Quartus Prime** (synthesis/fit/timing).
- Hardware target is the university FPGA board using `CLOCK_50`, push buttons, switches, and VGA output.

## Change Management Expectations
- Use GitHub Issues to define work items.
- Use one branch per scoped change.
- Open pull requests into `main` with clear rationale and evidence impact.
- Keep `CHANGELOG.md` and `EVIDENCE_LOG.md` current as evidence artifacts.

## Evidence and Traceability
- Include **MM3772** in documentation, source-file headers, and evidence artifacts.
- Preserve auditable commit history; avoid squashing unrelated tasks into one commit.

## Current Phase
Initial documentation planning phase. Do not add RTL in this phase unless explicitly requested in a future task.
