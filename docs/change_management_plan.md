# Change Management Plan

Project: FPGA VGA Falling-Block Game  
Student ID: **MM3772**

## 1. Objective
Use GitHub as formal change-management evidence for EE22005, showing disciplined planning, execution, and review throughout HDL development.

## 2. Workflow
1. **Issue creation**
   - Define task objective, acceptance criteria, and evidence impact.
2. **Branch creation**
   - Create branch from `main`.
   - Naming examples:
     - `docs/<topic>` for documentation
     - `feature/<module>` for RTL features
     - `fix/<bug>` for corrective changes
3. **Implementation commits**
   - Keep commits focused and descriptive.
   - Reference issue numbers in commit messages when applicable.
4. **Pull request to `main`**
   - Summarize what changed, why it changed, and evidence impact.
   - Link issue(s) and list validation performed.
5. **Review and merge**
   - Address comments.
   - Merge once acceptance criteria and evidence requirements are met.
6. **Post-merge logging**
   - Update `CHANGELOG.md` and `EVIDENCE_LOG.md`.

## 3. PR Template Expectations
Each PR should include:
- Scope summary
- Rationale
- Files changed
- Verification/evidence performed
- Skills mapping (4.1 and/or 1.10)

## 4. Traceability Policy
- Ensure `MM3772` appears in key source headers and evidence labels.
- Keep one logical topic per PR where practical.
- Preserve full Git history as assessment evidence.

## 5. Planned Initial Sequence
1. Documentation baseline PR (this change).
2. RTL top-level and interface skeleton PR.
3. VGA timing module PR with simulation evidence.
4. Game-state engine PR with simulation evidence.
5. Integrated synthesis and board demonstration PR.
