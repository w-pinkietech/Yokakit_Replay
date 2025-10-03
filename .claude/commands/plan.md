---
description: Generate commit-by-commit implementation plan from verified phase specification
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Transform the verified phase specification into a detailed, commit-by-commit implementation plan that:
1. Maps each PinkieIt commit to YokaKit replay tasks
2. Defines constitutional compliance strategy
3. Creates implementation artifacts (research.md, data-model.md, contracts/, quickstart.md)
4. Ensures accurate scope based on actual commits

**This step transforms `/clarify` output into actionable implementation strategy.**

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
- [ ] FEATURE_SPEC exists and contains `## Clarifications` section
- [ ] Clarifications section has at least one `Session {date}` entry
- [ ] All constitutional issues resolved (no open ⚠️ without resolutions)

**If missing**: Instruct user to run `/clarify` first to verify constitutional compliance.

### 2. Load and Analyze Verified Spec

Read `FEATURE_SPEC` and extract:
- Phase number and name
- PinkieIt commit range (start..end)
- Total commits to replay (excluding skips)
- Constitutional skips (with reasons)
- YokaKit adaptations (with specific file+change details)
- Clarifications session outcomes

**Verification**:
- [ ] All commits have full 40-character hashes
- [ ] All skips documented with reasons
- [ ] All adaptations have specific file paths
- [ ] Clarifications section shows "Ready for /plan ✅"

### 3. Analyze PinkieIt Commit Dependencies

For the commit range, analyze dependencies:

```bash
cd pinkieit
git log --oneline --reverse {start_commit}..{end_commit}
```

For each commit (excluding constitutional skips):

#### A. Extract Technical Context
```bash
git show {commit_hash} --stat
git show {commit_hash}
```

**Document**:
- Files created/modified/deleted
- Technologies introduced (Docker, MQTT, etc.)
- Configuration changes (docker-compose, .env)
- Database schema changes (migrations)
- Dependencies added (composer.json, package.json)

#### B. Identify Implementation Patterns
- Single-stage vs multi-stage commits
- Infrastructure vs application code
- Breaking vs non-breaking changes
- Test coverage requirements

#### C. Map Constitutional Requirements
For each commit, verify:
- [ ] Identity preservation needed? (yokakit vs pinkieit naming)
- [ ] Branding adaptation needed? (logos, copyright)
- [ ] Database names preserved? (yokakit database identity)
- [ ] Service names adapted? (docker-compose service names)

### 4. Create research.md

Generate `{FEATURE_DIR}/research.md`:

```markdown
# Phase {N}: {Phase Name} - Technical Research

## PinkieIt Commit Analysis

**Commit Range**: `{start_commit}..{end_commit}`
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

**From PinkieIt Commits**:
- {tech_1}: {version} (commit {hash})
- {tech_2}: {version} (commit {hash})

**YokaKit Adaptations**:
- {adaptation_1}: {reason}
- {adaptation_2}: {reason}

### Architecture Patterns

**Identified from Commits**:
- {pattern_1}: {where_used} (commit {hash})
- {pattern_2}: {where_used} (commit {hash})

**Constitutional Compliance**:
- Identity: {how_preserved}
- Branding: {how_adapted}

### Implementation Order

**Commit Replay Sequence**:
1. CR1 ({hash}): {description} - Foundation
2. CR2 ({hash}): {description} - Enhancement
3. CR{N} ({hash}): {description} - Completion

**Rationale**: {why_this_order}

## Risk Assessment

**Technical Risks** (from commit analysis):
- {risk_1}: {mitigation}
- {risk_2}: {mitigation}

**Constitutional Risks**:
- {risk_1}: {mitigation}

## References

**PinkieIt Commits**:
- {hash_1}: {url_to_github}
- {hash_2}: {url_to_github}

**Documentation**:
- {relevant_docs}
```

### 5. Create data-model.md

Generate `{FEATURE_DIR}/data-model.md`:

```markdown
# Phase {N}: {Phase Name} - Data Model

## Entities from PinkieIt Commits

{For each entity identified in commits:}

### {EntityName}

**Introduced in**: Commit {hash} ({date})
**Source**: {file_path}

**Attributes**:
```php
// From {file_path} at commit {hash}
{actual_code_structure}
```

**Constitutional Adaptations**:
- {pinkieit_naming} → {yokakit_naming}
- {branding_change}

**Relationships**:
- {relationship_1}
- {relationship_2}

---

## Database Schema Changes

**From Migration Files** (commits analyzed):

### Migration: {migration_name}

**Commit**: {hash}
**File**: {migration_file_path}

```php
// Schema from PinkieIt commit {hash}
{migration_code}
```

**YokaKit Adaptations**:
- Table name: {pinkieit_name} → {yokakit_name} (if needed)
- Constraints: {changes}

---

## Configuration Entities

**From docker-compose.yml, .env, etc.**:

### {ConfigName}

**Commit**: {hash}
**File**: {config_file_path}

**PinkieIt Original**:
```yaml
{original_config}
```

**YokaKit Adapted**:
```yaml
{adapted_config}
```

**Changes**:
- {change_1}: {reason}
- {change_2}: {reason}
```

### 6. Create contracts/

Generate contract files in `{FEATURE_DIR}/contracts/`:

```bash
mkdir -p {FEATURE_DIR}/contracts
```

For each configuration file type:

#### contracts/docker-compose.contract.md
```markdown
# Docker Compose Configuration Contract

**Source**: PinkieIt commit {hash}
**Target**: YokaKit docker-compose.yml

## Services

### {service_name}

**PinkieIt Reference** (commit {hash}):
```yaml
{pinkieit_service_config}
```

**YokaKit Contract**:
```yaml
{yokakit_service_config}
```

**Adaptations**:
- Service name: {pinkieit} → {yokakit}
- Container name: {pinkieit} → {yokakit}
- Volume names: {pinkieit} → {yokakit}

**Validation**:
- [ ] Service starts successfully
- [ ] Healthcheck passes
- [ ] Constitutional identity preserved
```

#### contracts/env.contract.md
```markdown
# Environment Configuration Contract

**Source**: PinkieIt commit {hash}
**Target**: YokaKit .env.example

## Variables

### {VARIABLE_NAME}

**PinkieIt Value**: `{pinkieit_value}`
**YokaKit Value**: `{yokakit_value}`
**Reason**: {adaptation_reason}

**Constitutional Compliance**:
- Identity: {preserved | adapted}
- Branding: {preserved | adapted}
```

### 7. Create quickstart.md

Generate `{FEATURE_DIR}/quickstart.md`:

```markdown
# Phase {N}: {Phase Name} - Quickstart Guide

## Prerequisites

**From PinkieIt Commits**:
- {requirement_1} (commit {hash})
- {requirement_2} (commit {hash})

**YokaKit Environment**:
- {yokakit_requirement}

## 15-Minute Setup

### Step 1: Clone and Setup ({X} min)

```bash
# Clone YokaKit
git clone {yokakit_url}
cd YokaKit

# Checkout Phase {N} branch
git checkout {branch_name}
```

### Step 2: Environment Configuration ({Y} min)

**Based on**: PinkieIt commit {hash}

```bash
# Copy environment template
cp .env.example .env

# Configure for YokaKit (constitutional adaptations)
# Change pinkieit → yokakit in:
# - APP_NAME
# - DB_DATABASE
# - {other_vars}
```

### Step 3: Start Services ({Z} min)

**Based on**: PinkieIt commits {hash_1}, {hash_2}

```bash
# Start Docker environment
docker-compose up -d

# Verify services
docker-compose ps
```

### Step 4: Validation

**Constitutional Compliance**:
```bash
# Verify YokaKit identity preserved
grep -r "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules
# Expected: No results (all should be yokakit)
```

**Service Health**:
```bash
# Check all services running
docker-compose ps | grep "Up"
# Expected: All services healthy
```

## Troubleshooting

**From PinkieIt Commit Analysis**:
- {issue_1}: {solution} (commit {hash})
- {issue_2}: {solution} (commit {hash})

## Next Steps

1. Review commit replay tasks in tasks.md
2. Execute CR1 (commit {hash})
3. Validate constitutional compliance after each CR
```

### 8. Generate Implementation Plan Summary

Create `{FEATURE_DIR}/plan.md`:

```markdown
# Phase {N}: {Phase Name} - Implementation Plan

## Overview

**PinkieIt Commits**: `{start_commit}..{end_commit}`
**Commits to Replay**: {count} (excluding {skip_count} constitutional skips)
**Estimated Duration**: {weeks} weeks ({based_on_commit_dates})

**Constitutional Compliance**: Identity preservation + YokaKit branding adaptations

## Commit Replay Strategy

### CR1: {hash} - {description}
**PinkieIt Commit**: `{full_hash}`
**Date**: {date}
**Files**: {count} files

**Tasks**:
1. {task_1}
2. {task_2}
3. {task_3}

**Constitutional Handling**:
- {adaptation_1}
- {adaptation_2}

**Validation**:
- [ ] {validation_1}
- [ ] {validation_2}

---

{Repeat for each commit replay...}

---

## Implementation Phases

### Phase 0: Research ✅
- [x] Analyze all PinkieIt commits
- [x] Document constitutional skips
- [x] Create research.md

### Phase 1: Data Modeling ✅
- [x] Extract entities from commits
- [x] Document schema changes
- [x] Create data-model.md

### Phase 2: Contract Definition ✅
- [x] Define configuration contracts
- [x] Document adaptations
- [x] Create contracts/

### Phase 3: Task Generation (Next)
- [ ] Run `/tasks` to generate commit-by-commit tasks
- [ ] Create GitHub Issues in YokaKit repository
- [ ] Begin implementation

## Artifacts Generated

- ✅ `research.md`: Technical analysis of {count} PinkieIt commits
- ✅ `data-model.md`: Entity definitions from actual commits
- ✅ `contracts/`: Configuration contracts with adaptations
- ✅ `quickstart.md`: 15-minute setup guide
- ✅ `plan.md`: This implementation plan

## Success Criteria

Based on PinkieIt commits and constitutional requirements:

- [ ] All {count} commits replayed (excluding skips)
- [ ] YokaKit identity preserved (no pinkieit references)
- [ ] All constitutional adaptations applied
- [ ] All validations pass
- [ ] Quickstart guide verified (15-minute setup)

## Next Step

Run `/tasks` to generate detailed task breakdown from this plan.

---

**Created**: {date}
**PinkieIt Reference**: {start_commit}..{end_commit}
**Constitution**: v{version}
**Clarifications**: Session {clarify_date}
```

### 9. Validation Checklist

Before completing:

**Research Validation**:
- [ ] All commits analyzed (git log matches spec)
- [ ] All commit hashes are full 40-character
- [ ] All technical decisions based on actual commits
- [ ] No assumptions (all from git show output)

**Data Model Validation**:
- [ ] All entities from actual commit files
- [ ] All schema changes documented with commit refs
- [ ] Constitutional adaptations specified

**Contracts Validation**:
- [ ] All configuration files have contracts
- [ ] All adaptations documented (pinkieit → yokakit)
- [ ] Validation criteria specified

**Quickstart Validation**:
- [ ] 15-minute timeline realistic
- [ ] All commands based on actual commits
- [ ] Constitutional compliance check included

### 10. Completion Report

Output:
```
✅ Implementation Plan Complete

Phase: {N} - {name}
Specs Directory: {FEATURE_DIR}

Artifacts Generated:
- research.md: {line_count} lines ({commit_count} commits analyzed)
- data-model.md: {entity_count} entities
- contracts/: {contract_count} contracts
- quickstart.md: {step_count} steps (15-minute setup)
- plan.md: {cr_count} commit replays

Commit Replays Planned: {count}
Constitutional Skips: {count}
YokaKit Adaptations: {count}

Next: Run /tasks to generate detailed task breakdown

Status: Ready for /tasks ✅
```

## Critical Requirements

**DO NOT**:
- Create plan without analyzing actual commits
- Assume technologies not in commit diffs
- Skip constitutional adaptation documentation
- Generate generic implementation steps

**ALWAYS**:
- Base research.md on actual `git show` output
- Reference specific commit hashes (full 40-char)
- Document constitutional handling for each commit
- Verify all adaptations have specific file paths
- Ensure quickstart guide is testable (15-minute rule)

## If Clarifications Missing

Output:
```
❌ Cannot proceed with /plan

Missing prerequisite: /clarify not completed

Please run:
/clarify

This will verify:
- Commit range accuracy
- Constitutional compliance
- YokaKit adaptation strategy

Then retry /plan after clarifications are complete.
```

## Example Usage

```
User: "/plan"