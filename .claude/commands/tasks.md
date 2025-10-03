---
description: Generate task breakdown from implementation plan
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Transform the implementation plan into a detailed, executable task breakdown that:
1. Creates actionable tasks from design documents (plan.md, data-model.md, contracts/, etc.)
2. For commit-based replays: Maps each PinkieIt commit to YokaKit replay tasks
3. Maintains proper execution order (dependencies, TDD, chronological)
4. Ensures constitutional compliance validation at each step
5. Generates GitHub Issue creation guidance

**This step transforms `/plan` output into executable task list using tasks-template.md structure.**

## Execution Workflow

### 1. Load Prerequisites

Run the setup script to get paths:
```bash
.specify/scripts/bash/check-prerequisites.sh --json --paths-only
```

Parse JSON for:
- `FEATURE_DIR`: Specs directory for this phase/feature
- `FEATURE_SPEC`: Path to spec.md
- `IMPL_PLAN`: Path to plan.md

**Verification**:
- [ ] plan.md exists and contains implementation strategy
- [ ] Design documents exist (research.md, data-model.md, contracts/)

**If missing**: Instruct user to run `/plan` first.

### 2. Determine Task Generation Strategy

Read `{FEATURE_DIR}/plan.md` to determine approach:

**If commit-based replay** (contains "PinkieIt Commits", "CR1", "CR2", etc.):
- Use commit replay task structure (Section 4)
- Extract CR list with commit hashes
- Generate tasks per commit

**If feature-based** (standard implementation):
- Use tasks-template.md structure (Section 5)
- Extract from data-model.md, contracts/
- Generate TDD tasks

### 3. Load Design Documents

**For all approaches**, read:
- `plan.md`: Overall strategy, tech stack, structure
- `research.md`: Technical decisions, dependencies
- `data-model.md`: Entities, relationships
- `contracts/`: API/config contracts
- `quickstart.md`: Setup and validation steps

**For commit-based**, additionally extract:
- Commit replay list (CR1, CR2, ..., CRN)
- Each CR's commit hash, description, files, constitutional handling

### 4. Generate Commit Replay Tasks (if commit-based)

Load `.specify/templates/tasks-template.md` as base structure, then adapt for commit replay:

For each commit replay (CR1, CR2, ..., CRN):

#### Task Naming Convention
- `T{XXX}`: Task number (zero-padded, e.g., T001, T010, T100)
- Each CR gets 4-9 tasks depending on complexity:
  - Preparation task (1)
  - Implementation tasks (1-5)
  - Validation task (1)
  - Commit task (1)
  - GitHub Issue tasks (0-2, if stories needed)

#### Commit Replay Task Template

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

### T{XXX}: [P?] Analyze {commit_description}

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

### T{XXX}: [P?] Implement {specific_feature_from_commit}

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

**[P] Marker**: Add [P] if this task modifies different files than parallel tasks

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

### T{XXX}: [P] Create GitHub Story for CR{N}

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

**Output**: tasks.md with commit-replay structure

### 5. Generate Feature-Based Tasks (if NOT commit-based)

Use `.specify/templates/tasks-template.md` structure directly:

#### Execution Flow (from tasks-template.md)
```
1. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tech stack, libraries, structure
2. Load optional design documents:
   → data-model.md: Extract entities → model tasks
   → contracts/: Each file → contract test task
   → research.md: Extract decisions → setup tasks
3. Generate tasks by category:
   → Setup: project init, dependencies, linting
   → Tests: contract tests, integration tests
   → Core: models, services, CLI commands
   → Integration: DB, middleware, logging
   → Polish: unit tests, performance, docs
4. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → Tests before implementation (TDD)
5. Number tasks sequentially (T001, T002...)
6. Generate dependency graph
7. Create parallel execution examples
8. Validate task completeness:
   → All contracts have tests?
   → All entities have models?
   → All endpoints implemented?
9. Return: SUCCESS (tasks ready for execution)
```

#### Task Categories (from tasks-template.md)

```markdown
# Tasks: {Feature Name}

**Input**: Design documents from `specs/{branch_name}/`
**Prerequisites**: plan.md (required), research.md, data-model.md, contracts/

## Phase 3.1: Setup
- [ ] T001 Create project structure per implementation plan
- [ ] T002 Initialize {language} project with {framework} dependencies
- [ ] T003 [P] Configure linting and formatting tools

## Phase 3.2: Tests First (TDD) ⚠️ MUST COMPLETE BEFORE 3.3
**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**

{From contracts/:}
- [ ] T{N} [P] Contract test {endpoint} in tests/contract/{file}
  - From: contracts/{contract_file}
  - Expected: Test fails (no implementation yet)

{From data-model.md entities:}
- [ ] T{N} [P] Integration test {entity} in tests/integration/{file}
  - From: data-model.md entity {EntityName}
  - Expected: Test fails (no model yet)

{From quickstart.md scenarios:}
- [ ] T{N} [P] Integration test {scenario} in tests/integration/{file}
  - From: quickstart.md Step {N}
  - Expected: Test validates quickstart scenario

## Phase 3.3: Core Implementation (ONLY after tests are failing)

{From data-model.md:}
- [ ] T{N} [P] {Entity} model in src/models/{entity}.{ext}
  - From: data-model.md entity definition
  - Expected: Test T{ref} passes

{From contracts/:}
- [ ] T{N} {Method} {endpoint} endpoint in src/api/{file}
  - From: contracts/{contract_file}
  - Expected: Contract test T{ref} passes
  - Dependencies: T{model_task}

{From plan.md services:}
- [ ] T{N} [P] {Service} in src/services/{service}.{ext}
  - From: plan.md Phase 1 design
  - Expected: Integration tests pass

## Phase 3.4: Integration
- [ ] T{N} Connect {Service} to {storage}
- [ ] T{N} {Middleware} middleware
- [ ] T{N} Request/response logging
- [ ] T{N} {Security} configuration

## Phase 3.5: Polish
- [ ] T{N} [P] Unit tests for {component} in tests/unit/{file}
- [ ] T{N} Performance tests ({performance_goal})
- [ ] T{N} [P] Update docs/{file}
- [ ] T{N} Remove duplication
- [ ] T{N} Run quickstart.md validation

## Dependencies
- Tests (T{range}) before implementation (T{range})
- {Entity} model blocks {Service}
- {Middleware} blocks {Integration}
- Implementation before polish

## Parallel Example
```
# Launch test tasks together (different files):
Task: "Contract test POST /api/users in tests/contract/test_users_post.py"
Task: "Contract test GET /api/users/{id} in tests/contract/test_users_get.py"
Task: "Integration test registration in tests/integration/test_registration.py"
```

## Task Generation Rules
*Applied during execution*

1. **From Contracts**:
   - Each contract file → contract test task [P]
   - Each endpoint → implementation task

2. **From Data Model**:
   - Each entity → model creation task [P]
   - Relationships → service layer tasks

3. **From User Stories**:
   - Each story → integration test [P]
   - Quickstart scenarios → validation tasks

4. **Ordering**:
   - Setup → Tests → Models → Services → Endpoints → Polish
   - Dependencies block parallel execution

## Validation Checklist
*GATE: Checked before completing*

- [ ] All contracts have corresponding tests
- [ ] All entities have model tasks
- [ ] All tests come before implementation
- [ ] Parallel tasks truly independent
- [ ] Each task specifies exact file path
- [ ] No task modifies same file as another [P] task
```

**Output**: tasks.md with TDD structure

### 6. Write tasks.md File

Create `{FEATURE_DIR}/tasks.md` using appropriate structure:

#### For Commit-Based Replay:

```markdown
# Tasks: Phase {N} - {Phase Name}

**Input**: Design documents from `specs/{branch_name}/`
**Prerequisites**: plan.md, research.md, data-model.md, contracts/

## Execution Flow (/tasks command scope)
```
{From tasks-template.md Execution Flow, adapted for commit replay}
1. Load plan.md (commit replay strategy)
2. Load research.md (commit analysis)
3. Generate tasks by CR:
   → Each CR: Analyze → Implement → Validate → Commit → GitHub
4. Apply task rules:
   → Different CRs may be [P] if independent commits
   → Same files = sequential (no [P])
   → Constitutional checks in every task
5. Number tasks sequentially (T001, T002...)
6. Validate completeness:
   → All CRs have full task cycle?
   → All constitutional adaptations documented?
9. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files/CRs, no dependencies)
- Include exact file paths and PinkieIt commit references

## Path Conventions
- **YokaKit Repository**: Where implementation happens
- **PinkieIt Repository**: Reference for commit replay
- Paths from plan.md project structure

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

{For each CR, use template from Section 4}

### Summary by Commit Replay:

- **CR1** ({hash}): Tasks T001-T{N} ({count} tasks)
- **CR2** ({hash}): Tasks T{N+1}-T{M} ({count} tasks)
- **CR{X}** ({hash}): Tasks T{Y}-T{Z} ({count} tasks)

---

## COMMIT REPLAY 1: {hash} - {description}

{Full task structure from Section 4}

---

## COMMIT REPLAY 2: {hash} - {description}

{Full task structure from Section 4}

---

{Continue for all CRs}

---

## Dependencies
- CR sequence: CR1 → CR2 → ... → CR{N} (chronological)
- Within each CR: Analyze → Implement → Validate → Commit → GitHub
- Some CRs may be [P] if commits are truly independent

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

Some CRs can run in parallel if commits are independent:

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

**Created**: {date}
**PinkieIt Reference**: {start_commit}..{end_commit}
**Total Tasks**: {task_count}
**Estimated Duration**: {weeks} weeks
```

#### For Feature-Based Tasks:

Use tasks-template.md structure directly (Section 5 content)

### 7. Validation Checklist

Before completing:

**For Commit-Based**:
- [ ] All CRs have Analyze → Implement → Validate → Commit → GitHub pattern
- [ ] All tasks numbered sequentially (T001, T002, ...)
- [ ] All tasks reference specific PinkieIt commits
- [ ] All constitutional skips documented
- [ ] Each implementation task specifies exact files
- [ ] Each validation task has clear success criteria
- [ ] Each commit task includes PinkieIt hash reference
- [ ] All tasks include constitutional adaptation steps

**For Feature-Based**:
- [ ] All contracts have corresponding tests
- [ ] All entities have model tasks
- [ ] All tests come before implementation
- [ ] Parallel tasks truly independent
- [ ] Each task specifies exact file path
- [ ] No task modifies same file as another [P] task

**Common**:
- [ ] Tasks follow tasks-template.md structure
- [ ] Dependencies clearly documented
- [ ] Parallel execution guidance provided
- [ ] Execution flow section included

### 8. Completion Report

Output:
```
✅ Task Breakdown Complete

Phase/Feature: {N} - {name}
Tasks File: {FEATURE_DIR}/tasks.md
Approach: {commit-based replay | feature-based TDD}

{If commit-based:}
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

{If feature-based:}
Task Summary:
- Setup: {count} tasks
- Tests: {count} tasks
- Implementation: {count} tasks
- Integration: {count} tasks
- Polish: {count} tasks
- Total Tasks: {task_count}

Parallel Tasks: {count}

Estimated Duration: {weeks} weeks ({hours} hours)

Next: Run /implement to execute tasks, or start manual execution with T001

Status: Ready for implementation ✅
```

## Critical Requirements

**DO NOT**:
- Create tasks without referencing source documents (plan.md, contracts/, data-model.md)
- Skip TDD pattern (tests before implementation) for feature-based
- Skip constitutional compliance validation for commit-based
- Generate generic "implement feature" tasks without file paths
- Forget commit tasks with audit trail (commit-based)
- Mix commit-based and feature-based structures

**ALWAYS**:
- Follow tasks-template.md Execution Flow structure
- Reference specific files/commits from design documents
- Include constitutional adaptation steps (commit-based)
- Add [P] markers for truly parallel tasks
- Specify exact file paths in task descriptions
- Include validation criteria for each task
- Number tasks sequentially (T001, T002, ...)

**For Commit-Based ONLY**:
- Reference full 40-character commit hashes
- Include GitHub Issue creation tasks
- Document constitutional skips (no tasks generated)

**For Feature-Based ONLY**:
- Tests before implementation (TDD)
- Contract tests from contracts/
- Model tasks from data-model.md

## If Plan Missing

Output:
```
❌ Cannot proceed with /tasks

Missing prerequisite: /plan not completed

Please run:
/plan

This will create:
- research.md (technical analysis)
- plan.md (implementation strategy)
- data-model.md (entities)
- contracts/ (API/config contracts)
- quickstart.md (validation guide)

Then retry /tasks after plan is complete.
```

## Example Usage

```
User: "/tasks"
```

Context for task generation: $ARGUMENTS

The tasks.md should be immediately executable - each task must be specific enough that an LLM or developer can complete it without additional context
