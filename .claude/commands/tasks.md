---
description: Generate commit-by-commit task breakdown from implementation plan
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Transform the implementation plan into a detailed, commit-by-commit task breakdown that:
1. Creates actionable tasks for each PinkieIt commit replay
2. Maintains chronological order (commit sequence)
3. Ensures constitutional compliance validation at each step
4. Generates GitHub Issue creation guidance

**This step transforms `/plan` output into executable task list.**

## Execution Workflow

### 1. Load Prerequisites

Run the setup script to get paths:
```bash
.specify/scripts/bash/check-prerequisites.sh --json --paths-only
```

Parse JSON for:
- `FEATURE_DIR`: Specs directory for this phase
- `FEATURE_SPEC`: Path to spec.md
- `IMPL_PLAN`: Path to plan.md

**Verification**:
- [ ] plan.md exists and contains commit replay strategy
- [ ] research.md contains commit analysis
- [ ] spec.md contains constitutional clarifications

**If missing**: Instruct user to run `/plan` first.

### 2. Load Implementation Plan

Read `{FEATURE_DIR}/plan.md` and extract:
- Phase number and name
- Commit replay list (CR1, CR2, ..., CRN)
- Each CR's:
  - PinkieIt commit hash (full 40-char)
  - Description
  - Files affected
  - Constitutional handling
  - Validation criteria

### 3. Load Research Data

Read `{FEATURE_DIR}/research.md` and extract for each commit:
- Technical context (files, technologies)
- Implementation patterns
- Dependencies
- Risks

### 4. Generate Commit Replay Task Structure

For each commit replay (CR1, CR2, ..., CRN):

#### Task Naming Convention
- `T{XXX}`: Task number (zero-padded, e.g., T001, T010, T100)
- Each CR gets 3-9 tasks depending on complexity:
  - Preparation task (1)
  - Implementation tasks (1-5)
  - Validation task (1)
  - Commit task (1)
  - GitHub Issue tasks (0-2, if new stories needed)

#### Task Template for Each CR

```markdown
## COMMIT REPLAY {N}: {commit_hash} - {description}

**PinkieIt Commit**: `{full_40_char_hash}`
**Date**: {commit_date}
**Files**: {count} files
**Constitutional**: {skip | identity-preservation | adaptation}

### Story/Issue Reference
- **YokaKit Issue**: #{issue_number} (if exists)
- **Epic**: #{epic_number}

---

### T{XXX}: Analyze {commit_description}

**Type**: Preparation
**Estimated**: 15-30 min

**Objective**: Verify PinkieIt commit state and plan constitutional adaptations

**Steps**:
1. Checkout PinkieIt at commit {hash}:
   ```bash
   cd pinkieit
   git checkout {commit_hash}
   git show {commit_hash} --stat
   ```

2. Review actual changes:
   ```bash
   git show {commit_hash}
   ```

3. Identify constitutional adaptations needed:
   - [ ] pinkieit → yokakit naming changes
   - [ ] Database identity preservation
   - [ ] Service name adaptations
   - [ ] Other branding changes

4. Document findings in Phase {N} research.md

**Validation**:
- [ ] All files in commit identified
- [ ] Constitutional adaptations documented
- [ ] No assumptions (all from actual git show)

---

### T{XXX}: Implement {specific_feature_from_commit}

**Type**: Implementation
**Estimated**: {X} hours
**Dependencies**: T{previous}

**Objective**: Replay {file_or_feature} from PinkieIt commit {hash}

**Files to Create/Modify**:
- `{file_path_1}` (based on PinkieIt commit)
- `{file_path_2}` (based on PinkieIt commit)

**Implementation Steps**:
1. Review PinkieIt file at commit {hash}:
   ```bash
   cd pinkieit
   git show {commit_hash}:{file_path}
   ```

2. Create/modify YokaKit file with constitutional adaptations:
   - Replace `pinkieit` → `yokakit`
   - Replace `PinkieIt` → `YokaKit`
   - Preserve YokaKit database identity (if applicable)
   - {other_specific_adaptations}

3. Apply changes to YokaKit repository:
   ```bash
   cd ../YokaKit
   # Create/edit {file_path} with adaptations
   ```

**Constitutional Compliance**:
- [ ] All pinkieit references changed to yokakit
- [ ] YokaKit identity preserved in configs
- [ ] No PinkieIt branding in code/comments

**Validation**:
- [ ] File structure matches PinkieIt (with naming adaptations)
- [ ] {specific_validation_for_this_file}
- [ ] No constitutional violations (run grep -r "pinkieit")

---

{Repeat Implementation tasks for each significant file/feature in the commit...}

---

### T{XXX}: Validate {commit_description} Implementation

**Type**: Validation
**Estimated**: 15-30 min
**Dependencies**: T{previous_implementation_tasks}

**Objective**: Verify CR{N} implementation matches PinkieIt commit with YokaKit identity

**Validation Steps**:

1. **File Existence Check**:
   ```bash
   # Verify all expected files exist
   ls -la {file_paths_from_commit}
   ```

2. **Constitutional Compliance Check**:
   ```bash
   # No pinkieit references (case-insensitive)
   grep -ri "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules
   # Expected: No results
   ```

3. **Functional Validation**:
   - [ ] {specific_test_1_from_commit}
   - [ ] {specific_test_2_from_commit}
   - [ ] {e.g., Docker services start, tests pass, etc.}

4. **Structural Validation**:
   ```bash
   # Compare file structure with PinkieIt
   # (accounting for constitutional adaptations)
   diff -r YokaKit/{path} pinkieit/{path} | grep -v "pinkieit\|yokakit"
   ```

**Success Criteria**:
- [ ] All files from PinkieIt commit present (with adaptations)
- [ ] Zero constitutional violations
- [ ] All functional tests pass
- [ ] Structure matches PinkieIt pattern

---

### T{XXX}: Commit CR{N} with Audit Trail

**Type**: Git Commit
**Estimated**: 5-10 min
**Dependencies**: T{validation_task}

**Objective**: Commit CR{N} changes with PinkieIt reference for audit trail

**Steps**:

1. Stage all changes:
   ```bash
   cd YokaKit
   git add .
   ```

2. Commit with PinkieIt reference:
   ```bash
   git commit -m "{commit_type}: {description} (PinkieIt: {short_hash})

   Replay of PinkieIt commit {full_hash}
   Constitutional adaptations: {summary}

   Files changed: {count}
   - {key_file_1}
   - {key_file_2}

   Phase {N} CR{N}
   YokaKit identity preserved ✓"
   ```

3. Verify commit:
   ```bash
   git log -1 --stat
   ```

**Validation**:
- [ ] Commit message references PinkieIt hash
- [ ] Constitutional compliance noted
- [ ] Phase and CR number included

---

{Optional: GitHub Issue Tasks if new stories needed}

### T{XXX}: Create GitHub Story for CR{N}

**Type**: GitHub Issue
**Estimated**: 10-15 min
**Dependencies**: T{commit_task}

**Objective**: Create tracking issue in YokaKit repository for CR{N}

**Steps**:

1. Create Story issue:
   ```bash
   gh issue create --repo {org}/YokaKit \
     --title "[Story] CR{N}: {description}" \
     --label "story:phase-{N},constitutional:identity-preservation" \
     --milestone "Phase {N}" \
     --body "$(cat <<'EOF'
   ## PinkieIt Reference

   **Commit**: `{full_hash}`
   **Date**: {date}
   **Files**: {count} files

   ## Implementation

   Tasks:
   - [x] T{XXX}: Analyze commit
   - [x] T{XXX}: Implement {feature}
   - [x] T{XXX}: Validate implementation
   - [x] T{XXX}: Commit with audit trail

   ## Constitutional Compliance

   - [x] YokaKit identity preserved
   - [x] pinkieit → yokakit adaptations applied
   - [x] No branding violations

   ## Validation

   - [x] All files present
   - [x] Functional tests pass
   - [x] Structure matches PinkieIt pattern

   **Status**: ✅ Complete (see commit {yokakit_commit_hash})
   EOF
   )"
   ```

2. Link to Epic #{epic_number}:
   ```bash
   gh issue comment #{new_issue_number} --repo {org}/YokaKit \
     --body "Part of Epic #{epic_number}"
   ```

**Validation**:
- [ ] Issue created with correct labels
- [ ] Linked to Phase {N} milestone
- [ ] Referenced in Epic

---
```

### 5. Generate Complete tasks.md

Create `{FEATURE_DIR}/tasks.md`:

```markdown
# Phase {N}: {Phase Name} - Task Breakdown

## Overview

**PinkieIt Commits**: `{start_commit}..{end_commit}`
**Total Commits**: {count}
**Commits to Replay**: {replay_count} (excluding {skip_count} constitutional skips)
**Total Tasks**: {task_count}

**Task Structure**: Each Commit Replay (CR) follows this pattern:
1. **Analyze**: Review PinkieIt commit and plan adaptations
2. **Implement**: Replay files with constitutional compliance
3. **Validate**: Verify implementation matches PinkieIt + YokaKit identity
4. **Commit**: Create commit with audit trail reference
5. **Track**: Create/update GitHub Issues (if needed)

## Constitutional Skips

{For each skipped commit:}

### COMMIT SKIP: {hash} - {description}

**PinkieIt Commit**: `{full_hash}`
**Reason**: {constitutional_reason}
**Action**: NO tasks generated (constitutional requirement)

**Example**: Commit 643414f renames YokaKit → PinkieIt, violates Identity Preservation requirement.

---

## Commit Replays

{For each commit to replay, generate full task structure as described in section 4...}

### Summary by Commit Replay:

- **CR1** ({hash}): Tasks T001-T{N} ({count} tasks)
- **CR2** ({hash}): Tasks T{N+1}-T{M} ({count} tasks)
- **CR{X}** ({hash}): Tasks T{Y}-T{Z} ({count} tasks)

---

## COMMIT REPLAY 1: {hash} - {description}

{Full task structure from section 4...}

---

## COMMIT REPLAY 2: {hash} - {description}

{Full task structure from section 4...}

---

{Continue for all CRs...}

---

## Task Execution Strategy

### Sequential Execution (Recommended)

Execute tasks in order (T001 → T002 → ... → T{end}):

```bash
# Example: Phase 1 execution
# CR1: Docker Foundation
# T001: Analyze commit a5d3b77
# T002: Implement docker-compose.yml
# T003: Implement Dockerfile
# T004: Validate Docker setup
# T005: Commit CR1
# T006: Create GitHub Story

# CR3: Application Reorganization
# T007: Analyze commit fad82e6
# ...
```

**Advantage**: Clear audit trail, easier debugging, constitutional compliance verification at each step

### Parallel Execution (Advanced)

Some tasks can run in parallel if they affect different files:

**Example**: CR4-CR6 (if independent)
```bash
# Terminal 1: CR4 tasks
# Terminal 2: CR5 tasks
# Terminal 3: CR6 tasks
```

**Caution**: Only parallelize if commits are truly independent (check dependencies in research.md)

---

## GitHub Issue Management

### Issue Creation Pattern

**Epic** (created once per phase):
- Title: `[EPIC] Phase {N}: {Phase Name}`
- Labels: `epic:phase-{N}`, `constitutional:identity-preservation`
- Milestone: `Phase {N}`

**Stories** (one per CR or group of related CRs):
- Title: `[Story] CR{N}: {description}`
- Labels: `story:phase-{N}`, `constitutional:identity-preservation`
- Milestone: `Phase {N}`
- References: PinkieIt commit hash, Epic issue

### Issue Lifecycle

1. **Create**: After commit (T{XXX} task)
2. **Track**: Update with validation results
3. **Close**: When CR validation passes + commit merged

---

## Progress Tracking

### Commit Replay Checklist

- [ ] **CR1** ({hash}): {description} (T001-T{N})
- [ ] **CR2** ({hash}): {description} (T{N+1}-T{M})
- [ ] **CR{X}** ({hash}): {description} (T{Y}-T{Z})

### Constitutional Compliance Checklist

- [ ] Zero pinkieit references in codebase
- [ ] YokaKit identity preserved in all configs
- [ ] All commits reference PinkieIt hashes
- [ ] GitHub Issues track all CRs

### Phase Completion Criteria

- [ ] All {replay_count} commits replayed
- [ ] All {task_count} tasks completed
- [ ] Constitutional compliance: 100%
- [ ] All GitHub Issues closed
- [ ] YokaKit submodule updated in YokaKit_Replay

---

## Next Steps

1. **Execute Tasks**: Start with T001 (CR1 Analysis)
2. **Validate Continuously**: Check constitutional compliance after each CR
3. **Track Progress**: Update GitHub Issues and this checklist
4. **Complete Phase**: Run `/implement` to execute all tasks (or manual execution)

---

**Created**: {date}
**PinkieIt Reference**: {start_commit}..{end_commit}
**Total Tasks**: {task_count}
**Estimated Duration**: {weeks} weeks
```

### 6. Task Count Calculation

Calculate tasks per CR based on commit complexity:

**Simple Commits** (1-3 files, config changes):
- 5 tasks: Analyze (1) + Implement (1) + Validate (1) + Commit (1) + GitHub (1)

**Medium Commits** (4-10 files, multiple features):
- 7 tasks: Analyze (1) + Implement (3) + Validate (1) + Commit (1) + GitHub (1)

**Complex Commits** (10+ files, major restructuring):
- 9+ tasks: Analyze (1) + Implement (5+) + Validate (1) + Commit (1) + GitHub (1)

**Constitutional Skips**:
- 0 tasks (documented but not executed)

### 7. Validation Checklist

Before completing:

**Task Structure**:
- [ ] All CRs have Analyze → Implement → Validate → Commit → GitHub pattern
- [ ] All tasks numbered sequentially (T001, T002, ...)
- [ ] All tasks reference specific PinkieIt commits
- [ ] All constitutional skips documented

**Task Detail**:
- [ ] Each implementation task specifies exact files
- [ ] Each validation task has clear success criteria
- [ ] Each commit task includes PinkieIt hash reference
- [ ] Each GitHub task has issue template

**Constitutional Compliance**:
- [ ] All tasks include constitutional adaptation steps
- [ ] All validations check for pinkieit references
- [ ] All commits note identity preservation

### 8. Completion Report

Output:
```
✅ Task Breakdown Complete

Phase: {N} - {name}
Tasks File: {FEATURE_DIR}/tasks.md

Task Summary:
- Commit Replays: {cr_count}
- Constitutional Skips: {skip_count}
- Total Tasks: {task_count}
- GitHub Issues: {issue_count}

Task Breakdown:
- Analyze: {count} tasks
- Implement: {count} tasks
- Validate: {count} tasks
- Commit: {count} tasks
- GitHub: {count} tasks

Estimated Duration: {weeks} weeks ({hours} hours)

Next: Run /implement to execute tasks, or start manual execution with T001

Status: Ready for implementation ✅
```

## Critical Requirements

**DO NOT**:
- Create tasks without PinkieIt commit reference
- Skip constitutional compliance validation tasks
- Generate generic "implement feature" tasks
- Forget commit tasks with audit trail

**ALWAYS**:
- Reference full 40-character commit hashes
- Include constitutional adaptation steps in each implementation task
- Add validation tasks for each CR
- Specify exact file paths from actual commits
- Include GitHub Issue creation tasks

## If Plan Missing

Output:
```
❌ Cannot proceed with /tasks

Missing prerequisite: /plan not completed

Please run:
/plan

This will create:
- research.md (commit analysis)
- plan.md (commit replay strategy)
- data-model.md (entities from commits)
- contracts/ (configuration contracts)

Then retry /tasks after plan is complete.
```

## Example Usage

```
User: "/tasks"
```

Context for task generation: $ARGUMENTS
