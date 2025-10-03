---
description: Create or update the feature specification from a natural language feature description.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/specify` in the triggering message **is** the feature description. Assume you always have it available in this conversation even if `$ARGUMENTS` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

## Goal

Create a comprehensive feature specification from the provided description that:
1. Captures the feature requirements and scope
2. For YokaKit_Replay commit-based replay: Analyzes PinkieIt commit range and extracts improvements
3. For standard features: Defines functional and non-functional requirements
4. Provides a foundation for `/plan` to generate implementation strategy

## Execution Workflow

### 1. Parse Feature Description

Extract from `$ARGUMENTS`:

**Standard Feature Format**: Natural language description
- Example: "Add user authentication with JWT tokens"
- Extract: Feature purpose, key capabilities, constraints

**Commit-Based Replay Format** (YokaKit_Replay specific): "Phase {N}: {start_commit}..{end_commit} - {description}"
- Example: "Phase 2: 13b40d1..a1b2c3d - Quality Infrastructure Day"
- Extract:
  - Phase number (e.g., "2")
  - Start commit hash (e.g., "13b40d1")
  - End commit hash (e.g., "a1b2c3d")
  - Phase name/description (e.g., "Quality Infrastructure Day")

### 2. Run Feature Creation Script

Run the script `.specify/scripts/bash/create-new-feature.sh --json "$ARGUMENTS"` from repo root and parse its JSON output for:
- `BRANCH_NAME`: New branch name
- `SPEC_FILE`: Absolute path to spec.md
- `FEATURE_NUM`: Feature number (e.g., "003")

**IMPORTANT**: You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.

### 3. Load Specification Template

Load `.specify/templates/spec-template.md` to understand required sections.

The template defines the structure for spec.md with placeholders for:
- Overview and scope
- Functional requirements
- Non-functional requirements
- Success criteria
- Technical constraints

### 4A. Standard Feature Specification (if NOT commit-based)

Write the specification to `SPEC_FILE` using the template structure, replacing placeholders with concrete details derived from the feature description while preserving section order and headings.

**Sections to fill**:
- **Overview**: Feature purpose and goals
- **Functional Requirements**: What the feature does
- **Non-Functional Requirements**: Performance, security, etc.
- **Success Criteria**: How to validate completion
- **Technical Constraints**: Platform, dependencies, etc.
- **Out of Scope**: What this feature doesn't include

**Output**: Standard spec.md following spec-template.md structure

### 4B. Commit-Based Replay Specification (if YokaKit_Replay format detected)

For commit range format, analyze PinkieIt commits:

#### Step 1: Analyze PinkieIt Commit Range

Navigate to PinkieIt submodule and analyze commits:

```bash
cd pinkieit
git log --oneline --reverse {start_commit}..{end_commit}
```

For **each commit** in the range:

**A. Extract Commit Details**
```bash
git show {hash} --stat
git show {hash}
```

Document:
- Commit hash (full 40-character)
- Commit date
- Commit message
- Files changed (count and list)
- Purpose/intent of the commit
- YokaKit naming adaptations needed (pinkieit → yokakit, PinkieIt → YokaKit)

**B. Identify Constitutional Issues**

For each commit, check if it requires constitutional handling:
- **Rename commits**: YokaKit → PinkieIt name changes → **SKIP**
- **Branding commits**: Logo, copyright changes → **ADAPT** with YokaKit branding
- **Identity commits**: Database name changes → **PRESERVE** YokaKit identity

Document all constitutional skips and adaptations.

#### Step 2: Generate Commit-Based Spec

Write to `SPEC_FILE` using this structure:

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

1. Run `/clarify` to verify commit range and constitutional handling (optional)
2. Run `/plan` to generate commit-based implementation plan
3. Run `/tasks` to create commit-by-commit task breakdown

---

**Created**: {date}
**PinkieIt Commits**: {start_commit}..{end_commit}
**Constitution Version**: {version from memory/constitution.md}
```

**Output**: Commit-based spec.md with PinkieIt analysis

### 5. Validation Checks

Before completing:

**For Standard Features**:
- [ ] All spec-template.md sections filled
- [ ] Functional requirements are clear and testable
- [ ] Success criteria are measurable
- [ ] No placeholder text remains

**For Commit-Based Replay**:
- [ ] All commits in range analyzed (verified with `git log`)
- [ ] Constitutional skips identified and documented
- [ ] YokaKit adaptations listed for each applicable commit
- [ ] No assumptions made (all info from actual git commits)
- [ ] Commit hashes verified (full 40-character hashes)

### 6. Report Completion

**For Standard Features**:
```
✅ Feature specification created

Branch: {BRANCH_NAME}
Spec File: {SPEC_FILE}
Feature: {feature_name}

Next: Run /plan to generate implementation strategy
Or: Run /clarify to resolve any ambiguities (optional)
```

**For Commit-Based Replay**:
```
✅ Phase {N} specification initialized

Branch: {BRANCH_NAME}
Spec File: {SPEC_FILE}
Commits Analyzed: {count}
Constitutional Skips: {count}
YokaKit Adaptations: {count}

Next: Run /clarify to verify commit range accuracy and constitutional compliance (optional)
Or: Run /plan to generate commit-based implementation strategy
```

## Critical Requirements

**DO NOT**:
- Assume features that aren't in actual commits (if commit-based)
- Include tasks/features from other phases
- Skip commit verification steps (if commit-based)
- Guess at commit purposes without checking actual diffs (if commit-based)
- Leave placeholder text in the spec

**ALWAYS**:
- Follow spec-template.md structure
- Checkout PinkieIt at each commit to verify changes (if commit-based)
- Use `git show {hash}` to see actual file changes (if commit-based)
- Document constitutional skips with specific reasons (if commit-based)
- Reference full 40-character commit hashes (if commit-based)
- Base all information on actual git history or user description

## YokaKit_Replay Commit-Based Analysis

**CRITICAL**: For commit-based replay, always verify actual commits:

### Phase 1 Lesson Learned

**Initial Mistake** ❌:
- Assumed "Docker Foundation" meant simple Dockerfile + docker-compose.yml
- Assumed "Model relocation" was app/Http/Requests → app/Models
- Created spec based on assumptions

**Reality Check** ✅:
```bash
# Check actual PinkieIt commits
cd pinkieit
git log --oneline --reverse a5d3b77..13b40d1

# Discovered:
a5d3b77: Initial Docker (correct assumption)
643414f: Rename YokaKit→PinkieIt (MUST SKIP - constitutional)
fad82e6: app/ → app/laravel/ (MASSIVE - not just models!)
bfd075e: Enhanced docker-compose (networking, healthcheck)
3a0f1cd: Volume refinements
13b40d1: MQTT container addition
```

**Corrected Approach** ✅:
- Analyzed each commit with `git show {hash} --stat`
- Understood actual file changes (200+ files in fad82e6!)
- Created accurate spec based on real commits

### Mandatory Workflow for Commit-Based Specs

#### Step 1: Identify Relevant PinkieIt Commits
```bash
# For Phase 2 (Quality Infrastructure)
cd pinkieit
git log --oneline --grep="test\|quality\|phpunit\|coverage" --reverse

# Or by date range (if known from timeline analysis)
git log --oneline --after="2025-06-13" --before="2025-06-14" --reverse
```

#### Step 2: Analyze Each Commit in Detail
```bash
# For each commit, check what was actually changed
git show {commit_hash} --stat        # File list
git show {commit_hash}               # Full diff
git show {commit_hash}:path/to/file  # Specific file content
```

#### Step 3: Map Commits to Constitutional Requirements
```
FOR EACH COMMIT:
  IF commit renames YokaKit → PinkieIt:
    → SKIP (constitutional requirement III)
  ELSE IF commit adds PinkieIt branding:
    → ADAPT with YokaKit naming
  ELSE:
    → REPLAY with YokaKit identity preserved
```

### PinkieIt Analysis Commands Reference

```bash
# Get commit sequence for a feature
git log --oneline --grep="keyword" --reverse

# Check commit details
git show {hash} --stat                    # Summary
git show {hash} --name-only               # File list only
git show {hash}                           # Full diff

# Find commits by date
git log --oneline --after="YYYY-MM-DD" --before="YYYY-MM-DD"

# Find commits by file
git log --oneline -- path/to/file

# Check file content at specific commit
git show {hash}:path/to/file
```

### Red Flags (Indicators You Need to Check Commits)

🚩 **Vague descriptions**: "structural improvements", "modernization", "cleanup"
🚩 **Large file counts**: If timeline mentions "200+ files", check what actually changed
🚩 **Multiple related commits**: Sequential commits often refine each other
🚩 **Timeline gaps**: If commits span months, check what happened between
🚩 **Merge commits**: Check the PR commits, not just the merge

### Constitutional Compliance in Spec Creation

#### ALWAYS Document Skipped Commits
```markdown
## Constitutional Handling

### Commits to Skip

- **{commit_hash}**: Rename YokaKit to PinkieIt (Constitutional requirement: Identity Preservation)
```

#### ALWAYS Adapt Naming
```markdown
## YokaKit Adaptations

- pinkieit → yokakit (all service names)
- PinkieIt → YokaKit (all documentation)
- DB name "yokakit" preserved (if exists in original)
```

## Example Usage

**Standard Feature**:
```
User: "/specify Add user authentication with JWT tokens and refresh token rotation"
```

**Commit-Based Replay**:
```
User: "/specify Phase 2: 13b40d1..a1b2c3d - Quality Infrastructure Day"
```
