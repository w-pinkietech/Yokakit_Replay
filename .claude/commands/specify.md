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

Write to SPEC_FILE using this structure:

```markdown
# Phase {N}: {Phase Name}

## Overview

{Brief description of what this phase achieves based on commit analysis}

**PinkieIt Commit Range**: `{start_commit}..{end_commit}`
**Total Commits**: {count}
**Estimated Duration**: {based on commit dates}

## PinkieIt Reference Commits

### Chronological Commit Sequence

{For each commit:}

#### Commit {N}: {short_hash} ({date})
**Full Hash**: `{full_hash}`
**Message**: {commit_message}
**Files Changed**: {count} files

**Key Changes**:
- {file1}: {purpose}
- {file2}: {purpose}
...

**YokaKit Adaptations**:
- {naming_change_1}
- {naming_change_2}
...

---

## Constitutional Handling

### Commits to Skip

{List commits that must be skipped:}

- **{commit_hash}**: {reason} (e.g., "Rename YokaKit to PinkieIt - Identity Preservation")

### Commits Requiring Adaptation

{List commits needing YokaKit-specific changes:}

- **{commit_hash}**: {adaptation} (e.g., "Replace pinkieit with yokakit in all configs")

## Initial Scope Analysis

**Features Identified** (from actual commits):
- {feature_1} (commit {hash})
- {feature_2} (commit {hash})
...

**Files Affected** (total unique files across all commits):
- {category_1}: {count} files
- {category_2}: {count} files
...

**Dependencies** (from previous phases):
- Phase {N-1}: {dependency}
...

## Success Criteria

Based on PinkieIt commit deliverables:

- [ ] All {count} commits replayed (excluding constitutional skips)
- [ ] YokaKit naming preserved throughout
- [ ] Constitutional requirements met
- [ ] All files from commits implemented
- [ ] No out-of-scope features added

## Next Steps

1. Run `/clarify` to verify commit range and constitutional handling
2. Run `/plan` to generate commit-based implementation plan
3. Run `/tasks` to create commit-by-commit task breakdown

---

**Created**: {date}
**PinkieIt Commits**: {start_commit}..{end_commit}
**Constitution Version**: {version from memory/constitution.md}
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