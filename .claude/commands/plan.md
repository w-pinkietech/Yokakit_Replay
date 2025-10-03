---
description: Generate commit-by-commit implementation plan from phase specification
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Transform the phase specification into a detailed, commit-by-commit implementation plan that:
1. Analyzes PinkieIt commits to map each to YokaKit replay tasks
2. Defines constitutional compliance strategy
3. Creates implementation artifacts (research.md, data-model.md, contracts/, quickstart.md, plan.md)
4. Ensures accurate scope based on actual commits

**Note**: `/clarify` is optional. Run it if you need to resolve ambiguities after reviewing this plan.

## Execution Workflow

### 1. Load Prerequisites

Run the setup script to get paths:
```bash
.specify/scripts/bash/check-prerequisites.sh --json --paths-only
```

Parse JSON for:
- `FEATURE_DIR`: Specs directory for this phase
- `FEATURE_SPEC`: Path to spec.md

**Verification**:
- [ ] FEATURE_SPEC exists and is readable
- [ ] spec.md contains PinkieIt commit range (if phase-based replay)

**Optional**: Check if `## Clarifications` section exists. If missing but ambiguities arise during planning, recommend `/clarify` at the end.

### 2. Load and Analyze Spec

Read `FEATURE_SPEC` and extract:
- Phase number and name
- PinkieIt commit range (start..end) if specified
- Feature requirements and success criteria
- Any existing clarifications (if `/clarify` was run)
- Technical constraints or dependencies

**Incorporate user arguments**:
If `$ARGUMENTS` provided, integrate into Technical Context during plan.md generation.

### 3. Analyze PinkieIt Commits (if commit range specified)

Navigate to PinkieIt submodule and analyze commit range:

```bash
cd pinkieit
git log --oneline --reverse {start_commit}..{end_commit}
```

For **each commit** in the range:

#### A. Extract Commit Details
```bash
git show {commit_hash} --stat
git show {commit_hash}
```

**Document**:
- Commit hash (full 40-character)
- Commit date and author
- Commit message
- Files created/modified/deleted
- Technologies introduced (Docker, MQTT, etc.)
- Configuration changes (docker-compose, .env)
- Database schema changes (migrations)
- Dependencies added (composer.json, package.json)

#### B. Identify Constitutional Requirements

For each commit, check:
- [ ] **Identity preservation**: Does commit rename YokaKit → PinkieIt? → **SKIP**
- [ ] **Branding changes**: Logos, copyright, etc. → **ADAPT** with YokaKit branding
- [ ] **Database names**: Preserve YokaKit database identity
- [ ] **Service names**: Adapt pinkieit → yokakit in docker-compose, etc.

Document:
- Commits to skip (with constitutional reasons)
- Commits requiring YokaKit naming adaptations (with specific files/changes)

### 4. Execute Implementation Plan Template

Load `.specify/templates/plan-template.md` as the base structure.

Follow the template's Execution Flow:
1. Load feature spec from FEATURE_SPEC
2. Fill Technical Context (incorporate $ARGUMENTS)
3. Read constitution at `memory/constitution.md`
4. Fill Constitution Check section
5. Execute Phase 0 → research.md
6. Execute Phase 1 → data-model.md, contracts/, quickstart.md
7. Re-evaluate Constitution Check
8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
9. STOP - Ready for `/tasks` command

**IMPORTANT**: Follow plan-template.md structure exactly. The /plan command STOPS after generating plan.md and artifacts. Phase 2 (tasks.md) is created by `/tasks` command.

### 5. Generate research.md (Phase 0)

Create `{FEATURE_DIR}/research.md` following this structure:

```markdown
# Phase {N}: {Phase Name} - Technical Research

## PinkieIt Commit Analysis

**Commit Range**: `{start_commit}..{end_commit}` (if applicable)
**Total Commits**: {count} ({replay_count} to replay, {skip_count} skipped)

### Commit-by-Commit Technical Details

{For each commit to replay:}

#### Commit {N}: {short_hash} - {description}

**Full Hash**: `{full_40_char_hash}`
**Date**: {commit_date}
**Author**: {author}
**Files Changed**: {count} files (+{insertions}, -{deletions})

**Technologies Introduced**:
- {tech_1} (e.g., Docker Compose 3.8)
- {tech_2} (e.g., MQTT Eclipse Mosquitto)

**Key File Changes**:
- `{file_path}`: {change_description}
  - Lines changed: +{add}, -{del}
  - Purpose: {why_changed}

**Dependencies**:
- Depends on: {previous_commit_hash} (reason)
- Enables: {next_feature}

**Constitutional Handling**:
- Identity preservation: {yokakit_changes}
- Naming adaptations: {specific_changes}
- Skips applied: {if_any}

**Implementation Strategy**:
- Approach: {single_commit | multi_task | incremental}
- Risks: {technical_risks}
- Validation: {how_to_verify}

---

## Technical Decisions

### Technology Stack

**From PinkieIt Commits** (if applicable):
- {tech_1}: {version} (commit {hash})
- {tech_2}: {version} (commit {hash})

**YokaKit Adaptations**:
- {adaptation_1}: {reason}
- {adaptation_2}: {reason}

**Or from Feature Requirements** (if not commit-based):
- {requirement-based tech stack}

### Architecture Patterns

**Identified from Commits** (if applicable):
- {pattern_1}: {where_used} (commit {hash})
- {pattern_2}: {where_used} (commit {hash})

**Constitutional Compliance**:
- Identity: {how_preserved}
- Branding: {how_adapted}

### Implementation Order

**Commit Replay Sequence** (if commit-based):
1. CR1 ({hash}): {description} - Foundation
2. CR2 ({hash}): {description} - Enhancement
3. CR{N} ({hash}): {description} - Completion

**Rationale**: {why_this_order}

**Or Feature-Based Order** (if not commit-based):
1. {feature_1}: {approach}
2. {feature_2}: {approach}

## Risk Assessment

**Technical Risks** (from commit analysis or feature requirements):
- {risk_1}: {mitigation}
- {risk_2}: {mitigation}

**Constitutional Risks**:
- {risk_1}: {mitigation}

## References

**PinkieIt Commits** (if applicable):
- {hash_1}: https://github.com/w-pinkietech/pinkieit/commit/{hash_1}
- {hash_2}: https://github.com/w-pinkietech/pinkieit/commit/{hash_2}

**Documentation**:
- {relevant_docs}
```

**Output**: `research.md` with all technical context resolved

### 6. Generate data-model.md (Phase 1)

Create `{FEATURE_DIR}/data-model.md`:

```markdown
# Phase {N}: {Phase Name} - Data Model

## Entities

{For each entity identified:}

### {EntityName}

**Introduced in**: Commit {hash} ({date}) or Feature requirement {ref}
**Source**: {file_path} or {spec section}

**Attributes**:
```php
// From {file_path} at commit {hash} or designed for {feature}
{actual_code_structure or designed structure}
```

**Constitutional Adaptations** (if from PinkieIt):
- {pinkieit_naming} → {yokakit_naming}
- {branding_change}

**Relationships**:
- {relationship_1}
- {relationship_2}

**Validation Rules**:
- {rule_1}
- {rule_2}

---

## Database Schema Changes

**From Migration Files** (if applicable):

### Migration: {migration_name}

**Commit**: {hash} (if from PinkieIt)
**File**: {migration_file_path}

```php
// Schema from PinkieIt commit {hash} or designed for YokaKit
{migration_code}
```

**YokaKit Adaptations**:
- Table name: {pinkieit_name} → {yokakit_name} (if needed)
- Constraints: {changes}

---

## Configuration Entities

**From docker-compose.yml, .env, etc.** (if applicable):

### {ConfigName}

**Commit**: {hash} or **Designed for**: {feature}
**File**: {config_file_path}

**PinkieIt Original** (if from PinkieIt):
```yaml
{original_config}
```

**YokaKit Adapted** or **YokaKit Design**:
```yaml
{adapted_or_designed_config}
```

**Changes**:
- {change_1}: {reason}
- {change_2}: {reason}
```

**Output**: `data-model.md` with entity definitions

### 7. Generate contracts/ (Phase 1)

Create contract files in `{FEATURE_DIR}/contracts/`:

```bash
mkdir -p {FEATURE_DIR}/contracts
```

For each configuration or API contract:

#### contracts/docker-compose.contract.md (if applicable)
```markdown
# Docker Compose Configuration Contract

**Source**: PinkieIt commit {hash} or YokaKit feature design
**Target**: YokaKit docker-compose.yml

## Services

### {service_name}

**PinkieIt Reference** (commit {hash}) or **Design Specification**:
```yaml
{pinkieit_service_config or designed_config}
```

**YokaKit Contract**:
```yaml
{yokakit_service_config}
```

**Adaptations** (if from PinkieIt):
- Service name: {pinkieit} → {yokakit}
- Container name: {pinkieit} → {yokakit}
- Volume names: {pinkieit} → {yokakit}

**Validation**:
- [ ] Service starts successfully
- [ ] Healthcheck passes
- [ ] Constitutional identity preserved
```

#### contracts/api.contract.md (if applicable)
```markdown
# API Contract

**Endpoint**: {endpoint}
**Method**: {HTTP_METHOD}

**Request Schema**:
```json
{request_schema}
```

**Response Schema**:
```json
{response_schema}
```

**Validation**:
- [ ] Contract test passes
- [ ] Schema validation implemented
```

**Output**: `contracts/` directory with relevant contract files

### 8. Generate quickstart.md (Phase 1)

Create `{FEATURE_DIR}/quickstart.md`:

```markdown
# Phase {N}: {Phase Name} - Quickstart Guide

## Prerequisites

**From PinkieIt Commits** (if applicable):
- {requirement_1} (commit {hash})
- {requirement_2} (commit {hash})

**Or Feature Requirements**:
- {requirement_1}
- {requirement_2}

**YokaKit Environment**:
- {yokakit_requirement}

## 15-Minute Setup

### Step 1: Clone and Setup ({X} min)

```bash
# Clone YokaKit
git clone {yokakit_url}
cd YokaKit

# Checkout Phase {N} branch (or feature branch)
git checkout {branch_name}
```

### Step 2: Environment Configuration ({Y} min)

**Based on**: PinkieIt commit {hash} or Feature design

```bash
# Copy environment template
cp .env.example .env

# Configure for YokaKit
# Constitutional adaptations (if from PinkieIt):
# - Change pinkieit → yokakit in APP_NAME
# - Change pinkieit → yokakit in DB_DATABASE
# - {other_vars}
```

### Step 3: Start Services ({Z} min)

**Based on**: PinkieIt commits {hash_1}, {hash_2} or Feature design

```bash
# Start Docker environment (if applicable)
docker-compose up -d

# Or run application directly
{run_command}

# Verify services
docker-compose ps  # or alternative verification
```

### Step 4: Validation

**Constitutional Compliance** (if from PinkieIt):
```bash
# Verify YokaKit identity preserved
grep -r "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules
# Expected: No results (all should be yokakit)
```

**Service Health**:
```bash
# Check all services running
docker-compose ps | grep "Up"  # or alternative health check
# Expected: All services healthy
```

**Feature Validation**:
```bash
# Test feature-specific functionality
{feature_test_command}
# Expected: {expected_result}
```

## Troubleshooting

**Common Issues**:
- {issue_1}: {solution} (from commit {hash} or design)
- {issue_2}: {solution}

## Next Steps

1. Review commit replay tasks in tasks.md (generated by `/tasks`)
2. Execute CR1 (commit {hash}) or Task 1
3. Validate constitutional compliance after each CR (if applicable)
```

**Output**: `quickstart.md` with 15-minute setup guide

### 9. Generate plan.md (Implementation Plan Summary)

Create `{FEATURE_DIR}/plan.md` using **plan-template.md structure**:

```markdown
# Implementation Plan: Phase {N} - {Phase Name}

**Branch**: `{branch_name}` | **Date**: {date} | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `specs/{branch_name}/spec.md`

## Execution Flow (/plan command scope)

{Copy from plan-template.md, adapted for commit replay if applicable}

**IMPORTANT**: The /plan command STOPS at step 9. Phase 2 is executed by /tasks command:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary

{Extract from spec.md: Phase purpose + commit range or feature description}

**PinkieIt Commits**: `{start_commit}..{end_commit}` (if applicable)
**Commits to Replay**: {count} (excluding {skip_count} constitutional skips)
**Estimated Duration**: {weeks} weeks (based on commit dates or feature complexity)

## Technical Context

**Language/Version**: {from research.md or spec.md}
**Primary Dependencies**: {from research.md or spec.md}
**Storage**: {if applicable}
**Testing**: {framework}
**Target Platform**: {platform}
**Project Type**: {single/web/mobile}
**Performance Goals**: {from spec or N/A}
**Constraints**: {from spec or N/A}
**Scale/Scope**: {from spec or N/A}

**PinkieIt Reference** (if applicable): Commits {start_hash}..{end_hash}
**Constitutional Requirements**: Identity preservation + YokaKit branding adaptations

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

{Load from memory/constitution.md and evaluate:}

**Constitutional Principles**:
- [ ] **Identity Preservation (NON-NEGOTIABLE)**: YokaKit naming maintained
- [ ] **Historical Fidelity**: PinkieIt improvements extracted incrementally
- [ ] **Sequential Phases**: Phase order respected
- [ ] **Audit Trail**: Commit references maintained
- [ ] **Complexity Bounds**: {evaluate based on constitution}

**Violations**: {list if any, with justifications in Complexity Tracking}

## Project Structure

### Documentation (this feature)
```
specs/{branch_name}/
├── spec.md              # Feature specification (/specify output)
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (repository root or YokaKit submodule)

{Adapt based on project type - use plan-template.md structure options}

**Structure Decision**: {Document the selected structure}

## Phase 0: Outline & Research

**Status**: ✅ Complete (research.md generated)

**Key Findings** (from research.md):
- {finding_1}
- {finding_2}

**Output**: research.md with all technical context resolved

## Phase 1: Design & Contracts

**Status**: ✅ Complete (data-model.md, contracts/, quickstart.md generated)

**Entities Identified**: {count} entities in data-model.md
**Contracts Defined**: {count} contracts in contracts/
**Quickstart**: 15-minute setup guide validated

**Output**: data-model.md, contracts/*, quickstart.md

## Phase 2: Task Planning Approach

*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:

**If commit-based replay**:
- Each PinkieIt commit → Commit Replay (CR) story
- Each CR → 3-5 tasks (validate, implement, test, commit)
- Constitutional skips documented (no tasks generated)
- Naming adaptations applied in each CR

**If feature-based**:
- Load `.specify/templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (contracts, data model, quickstart)
- Each contract → contract test task [P]
- Each entity → model creation task [P]
- Each user story → integration test task
- Implementation tasks to make tests pass

**Ordering Strategy**:
- TDD order: Tests before implementation
- Dependency order: Models before services before UI
- Commit order: Sequential replay (if commit-based)
- Mark [P] for parallel execution (independent files)

**Estimated Output**: {count} numbered, ordered tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Commit Replay Strategy (if applicable)

### CR1: {hash} - {description}
**PinkieIt Commit**: `{full_hash}`
**Date**: {date}
**Files**: {count} files

**Tasks Preview**:
1. Validate PinkieIt commit {hash}
2. Implement {feature} with YokaKit naming
3. Test {feature} functionality
4. Commit with reference to {hash}

**Constitutional Handling**:
- {adaptation_1}
- {adaptation_2}

---

{Repeat for each commit replay...}

---

## Complexity Tracking

*Fill ONLY if Constitution Check has violations that must be justified*

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| {violation} | {justification} | {reason} |

## Progress Tracking

*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command) - research.md
- [x] Phase 1: Design complete (/plan command) - data-model.md, contracts/, quickstart.md
- [x] Phase 2: Task planning approach described (/plan command)
- [ ] Phase 3: Tasks generated (/tasks command) - tasks.md
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All technical context resolved (research.md)
- [ ] Complexity deviations documented (if any)

**Artifacts Generated**:
- ✅ `research.md`: {line_count} lines ({commit_count} commits analyzed or feature research)
- ✅ `data-model.md`: {entity_count} entities
- ✅ `contracts/`: {contract_count} contracts
- ✅ `quickstart.md`: {step_count} steps (15-minute setup)
- ✅ `plan.md`: This implementation plan

**Next Step**: Run `/tasks` to generate detailed task breakdown

---

*Based on Constitution v{version} - See `memory/constitution.md`*
*PinkieIt Reference*: `{start_commit}..{end_commit}` (if applicable)
*Created*: {date}
```

**Output**: `plan.md` following plan-template.md structure

### 10. Validation Checklist

Before completing:

**Research Validation**:
- [ ] All commits analyzed (git log matches spec) OR feature requirements researched
- [ ] All commit hashes are full 40-character (if commit-based)
- [ ] All technical decisions based on actual commits or spec requirements
- [ ] No assumptions (all from git show output or spec)

**Data Model Validation**:
- [ ] All entities from actual commit files or spec requirements
- [ ] All schema changes documented with commit refs (if applicable)
- [ ] Constitutional adaptations specified (if from PinkieIt)

**Contracts Validation**:
- [ ] All configuration/API files have contracts
- [ ] All adaptations documented (pinkieit → yokakit) if applicable
- [ ] Validation criteria specified

**Quickstart Validation**:
- [ ] 15-minute timeline realistic
- [ ] All commands based on actual commits or feature design
- [ ] Constitutional compliance check included (if applicable)

**Plan Validation**:
- [ ] Follows plan-template.md structure
- [ ] All sections filled (Summary, Technical Context, Constitution Check, etc.)
- [ ] Progress Tracking updated
- [ ] Phase 2 approach described (NOT executed)

### 11. Completion Report

Output:
```
✅ Implementation Plan Complete

Phase: {N} - {name}
Branch: {BRANCH_NAME}
Specs Directory: {FEATURE_DIR}

Artifacts Generated:
- research.md: {line_count} lines ({commit_count} commits analyzed OR feature research)
- data-model.md: {entity_count} entities
- contracts/: {contract_count} contracts
- quickstart.md: {step_count} steps (15-minute setup)
- plan.md: Implementation plan (follows plan-template.md structure)

{If commit-based:}
Commit Replays Planned: {count}
Constitutional Skips: {count}
YokaKit Adaptations: {count}

Next: Run /tasks to generate detailed task breakdown

{If ambiguities detected during planning:}
⚠️  Recommendation: Run /clarify to resolve:
- {ambiguity_1}
- {ambiguity_2}

Status: Ready for /tasks ✅ {or "Ready for /clarify (optional) → /tasks"}
```

## Critical Requirements

**DO NOT**:
- Create plan without analyzing actual commits (if commit-based) or spec requirements
- Assume technologies not in commit diffs or spec
- Skip constitutional adaptation documentation (if from PinkieIt)
- Generate generic implementation steps
- Create tasks.md (that's /tasks command's job)

**ALWAYS**:
- Base research.md on actual `git show` output (if commit-based) or spec analysis
- Reference specific commit hashes (full 40-char) if applicable
- Document constitutional handling for each commit (if from PinkieIt)
- Verify all adaptations have specific file paths
- Ensure quickstart guide is testable (15-minute rule)
- Follow plan-template.md structure for plan.md
- Stop at Phase 2 planning (do NOT create tasks.md)

**OPTIONAL**:
- `/clarify` can be run if ambiguities arise during planning
- Recommend `/clarify` in completion report if unresolved questions detected

## Example Usage

```
User: "/plan"