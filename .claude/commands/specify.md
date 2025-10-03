---
description: Analyze PinkieIt commit range and create initial phase specification for replay
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

Expected format: "Phase {N}: {start_commit}..{end_commit} - {description}"
Example: "Phase 2: 13b40d1..a1b2c3d - Quality Infrastructure Day"

## Workflow for Commit-Based Replay

Given the phase description and commit range, do this:

### 1. Parse Input

Extract from arguments:
- Phase number (e.g., "2")
- Start commit hash (e.g., "13b40d1")
- End commit hash (e.g., "a1b2c3d")
- Phase name/description (e.g., "Quality Infrastructure Day")

### 2. Analyze PinkieIt Commit Range

Navigate to PinkieIt submodule and analyze commits:

```bash
cd pinkieit
git log --oneline --reverse {start_commit}..{end_commit}
```

For **each commit** in the range:
- Run `git show {hash} --stat` to see files changed
- Run `git show {hash}` to see actual changes
- Extract:
  - Commit hash (full and short)
  - Commit date
  - Commit message
  - Files changed (count and list)
  - Purpose/intent of the commit
  - YokaKit naming adaptations needed (pinkieit → yokakit, PinkieIt → YokaKit)

### 3. Identify Constitutional Issues

For each commit, check if it requires constitutional handling:
- **Rename commits**: YokaKit → PinkieIt name changes → **SKIP**
- **Branding commits**: Logo, copyright changes → **ADAPT** with YokaKit branding
- **Identity commits**: Database name changes → **PRESERVE** YokaKit identity

Document all constitutional skips and adaptations.

### 4. Create Phase Directory Structure

Run the setup script:
```bash
.specify/scripts/bash/create-new-feature.sh --json "Phase {N}: {phase-name}"
```

Parse JSON output for:
- BRANCH_NAME (e.g., "003-phase-2-quality-infrastructure")
- SPEC_FILE (absolute path to spec.md)
- SPECS_DIR (absolute path to specs directory)

### 5. Generate Initial spec.md

**IMPORTANT**: Follow `.specify/templates/spec-template.md` structure with Phase-specific adaptations.

Write to SPEC_FILE using this structure:

```markdown
# Feature Specification: Phase {N} {Phase Name}

**Feature Branch**: `{branch_name}`
**Created**: {YYYY-MM-DD}
**Status**: Draft
**Input**: User description: "Phase {N}: {start_commit}..{end_commit} - {description}"

## Execution Flow (main)
```text
1. Parse PinkieIt commit range from Input
   → Range: {start_commit}..{end_commit} ({count} commits)
2. Analyze each commit for technical changes
   → Identify: files changed, purpose, YokaKit adaptations
3. Identify constitutional issues:
   → Rename commits: SKIP
   → Branding commits: ADAPT with YokaKit naming
4. Extract user scenarios from commit deliverables
   → Developer workflow improvements
5. Generate functional requirements from commits
   → Each requirement maps to commit deliverable
6. Identify key entities (infrastructure/code components)
7. Run constitutional compliance check
   → Verify: Identity preservation, historical fidelity
8. Return: SUCCESS (spec ready for planning)
```

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT optimizations/features achieve and WHY
- ❌ Avoid specific implementation (defer to /plan and /tasks)
- 👥 Written for technical stakeholders understanding replay methodology

### PinkieIt Commit Range
**Start**: `{full_start_hash}` ({start_date})
**End**: `{full_end_hash}` ({end_date})
**Total Commits**: {count}
**Estimated Duration**: {duration based on timestamps}

---

## User Scenarios & Testing *(mandatory)*

### Primary User Story
As a YokaKit developer, I need {phase_goal} so that {benefit}, following proven patterns from PinkieIt's {phase_name} phase.

### Acceptance Scenarios
1. **Given** {precondition from Phase N-1}, **When** {Phase N changes applied}, **Then** {observable outcome from commits}
2. **Given** {development workflow}, **When** {feature from commits used}, **Then** {improved capability}
{Add more scenarios based on actual commit deliverables}

### Edge Cases
- What happens when {edge_case_from_commits}?
- How does system handle {failure_scenario}?

## Requirements *(mandatory)*

### Functional Requirements

**From Commit {hash1} ({description})**:
- **FR-001**: System MUST {specific capability from commit}
- **FR-002**: System MUST {another capability from commit}

**From Commit {hash2} ({description})**:
- **FR-003**: System MUST {capability}

{Continue for all commits}

**Constitutional Requirements**:
- **FR-{N}**: System MUST replace all "PinkieIt" references with "YokaKit"
- **FR-{N+1}**: System MUST use "yokakit" prefix for all naming
- **FR-{N+2}**: System MUST preserve YokaKit identity

### Key Entities *(include if feature involves data)*

- **{Entity1 from commits}**: {Description of component/infrastructure}
- **{Entity2 from commits}**: {Description with YokaKit-specific details}

---

## PinkieIt Commit References *(for implementation context)*

{For each commit:}
### Commit {N}: {short_hash}
**Message**: {message}
**Files**: {file list or count}
**Constitutional**: {SKIP/ADAPT/Direct replay} - {reason if applicable}

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [ ] No implementation details beyond commit-level descriptions
- [ ] Focused on {phase_type} value and improvements
- [ ] Written for technical stakeholders
- [ ] All mandatory sections completed

### Requirement Completeness
- [ ] No [NEEDS CLARIFICATION] markers (all commits verified)
- [ ] Requirements testable against commit deliverables
- [ ] Success criteria measurable
- [ ] Scope clearly bounded ({count} commits, {duration})
- [ ] Dependencies identified (Phase {N-1})

### Constitutional Compliance
- [ ] Identity Preservation: YokaKit naming documented
- [ ] Historical Fidelity: All commits from PinkieIt verified
- [ ] Audit Trail: Full commit hashes referenced
- [ ] Constitutional skips/adaptations documented

---

## Execution Status
*Updated by main() during processing*

- [ ] PinkieIt commit range parsed
- [ ] {count} commits analyzed with git show
- [ ] Constitutional adaptations identified
- [ ] User scenarios defined from developer workflow
- [ ] Requirements generated from commit deliverables
- [ ] Entities identified
- [ ] Review checklist passed

---

## Next Steps

1. Run `/clarify` to verify commit range accuracy and constitutional compliance
2. Run `/plan` to generate commit-based implementation plan
3. Run `/tasks` to create commit-by-commit task breakdown

---

**Constitution Version**: {version from .specify/memory/constitution.md}
**PinkieIt Commit Range**: {start_commit}..{end_commit}
**Phase Dependencies**: Phase {N-1}
```

### 6. Validation Checks

Before completing:
- [ ] All commits in range analyzed (verified with `git log`)
- [ ] Constitutional skips identified and documented
- [ ] YokaKit adaptations listed for each applicable commit
- [ ] No assumptions made (all info from actual git commits)
- [ ] Commit hashes verified (full 40-character hashes)

### 7. Report Completion

Output to user:
```
✅ Phase {N} specification initialized

Branch: {BRANCH_NAME}
Spec File: {SPEC_FILE}
Commits Analyzed: {count}
Constitutional Skips: {count}
YokaKit Adaptations: {count}

Next: Run /clarify to verify commit range accuracy and constitutional compliance
```

## Critical Requirements

**DO NOT**:
- Assume features that aren't in actual commits
- Include tasks/features from other phases
- Skip commit verification steps
- Guess at commit purposes without checking actual diffs

**ALWAYS**:
- Checkout PinkieIt at each commit to verify changes
- Use `git show {hash}` to see actual file changes
- Document constitutional skips with specific reasons
- Reference full 40-character commit hashes
- Base all information on actual git history

## Example Usage

```
User: "/specify Phase 2: 13b40d1..a1b2c3d - Quality Infrastructure Day"