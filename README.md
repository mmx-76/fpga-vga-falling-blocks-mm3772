# FPGA VGA Falling-Block Game (EE22005 Synthesis Evidence)

Student ID: **MM3772**

## Project Purpose
This repository contains the implementation and evidence trail for an EE22005 digital design project: a falling-block style game implemented on a university FPGA board with VGA output.

The project is being developed to demonstrate:
- **Skill 4.1 Hardware Description Language** through structured SystemVerilog design for synthesis.
- **Skill 1.10 Change Management** through disciplined GitHub issue, branch, commit, and pull request workflow.

## Technical Scope
- **HDL language:** SystemVerilog only
- **Simulation tool:** Questa
- **Synthesis and implementation tool:** Quartus Prime
- **Target hardware:** University FPGA board using:
  - `CLOCK_50`
  - push buttons
  - switches
  - VGA output

No RTL implementation is included in this documentation-only initialization commit.

## Planned HDL Module Structure
The RTL is planned as modular SystemVerilog blocks:

1. `top_mm3772`  
   Top-level integration with board I/O (`CLOCK_50`, keys, switches, VGA pins).
2. `clock_reset`  
   Reset conditioning and optional clock-enable generation for game timing.
3. `input_controller`  
   Debounce/synchronize user controls from push buttons and switches.
4. `game_state_engine`  
   Falling-block state machine, collision logic, scoring, and game-over handling.
5. `vga_timing`  
   VGA horizontal/vertical counters and sync signal generation.
6. `video_renderer`  
   Pixel-color generation based on game state and current pixel position.
7. `score_display` (optional phase)  
   Visual score representation via VGA overlay and/or board outputs.

Module names may evolve through approved pull requests.

## Evidence Strategy
Evidence will be captured across three streams:
- **Questa evidence:** simulation testbenches, waveforms, transcript logs.
- **Quartus evidence:** compile reports, resource/timing summaries, pin assignments.
- **FPGA run evidence:** photos/videos showing the game on VGA monitor with MM3772 identification.

## MM3772 Identification Plan
To maintain authorship traceability, `MM3772` will be included in:
- top-level module/file naming and header comments,
- commit and pull request narrative where appropriate,
- evidence artifacts (screenshots/video titles, report notes, and log entries).

## Change-Management Workflow Summary
Development will follow GitHub-based control:
1. Create or refine a GitHub Issue for a scoped engineering task.
2. Create a dedicated branch from `main` (for example `feature/<scope>` or `docs/<scope>`).
3. Implement and commit with focused messages.
4. Open a pull request to `main` linking the issue and evidence intent.
5. Review, update, and merge after checks/evidence are adequate.
6. Record milestone outcomes in `CHANGELOG.md` and `EVIDENCE_LOG.md`.

See detailed plans in:
- `docs/requirements.md`
- `docs/change_management_plan.md`
- `docs/test_plan.md`
