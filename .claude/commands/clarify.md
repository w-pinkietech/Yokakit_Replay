---
description: Verify constitutional compliance and confirm PinkieIt commit range accuracy for replay
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Verify that the phase specification is ready for implementation by:
1. Confirming all PinkieIt commits are accurately analyzed
2. Validating constitutional compliance strategy
3. Detecting any missing or out-of-scope commits
4. Ensuring YokaKit naming adaptations are complete

**This step is CRITICAL** to prevent Phase 1's scope creep mistake (T033-T047).

## Execution Workflow

### 1. Load Prerequisites

Run the setup script to get paths:
```bash
.specify/scripts/bash/check-prerequisites.sh --json --paths-only
```

Parse JSON for:
- `FEATURE_DIR`: Specs directory for this phase
- `FEATURE_SPEC`: Path to spec.md

If missing, instruct user to run `/specify` first.

### 2. Load and Analyze Spec

Read `FEATURE_SPEC` and extract:
- Phase number and name
- PinkieIt commit range (start..end)
- List of commits to replay
- Constitutional skips documented
- YokaKit adaptations planned

### 3. Verify Commit Range Accuracy

For the commit range specified in spec:

```bash
cd pinkieit
git log --oneline --reverse {start_commit}..{end_commit}
```

**Check**:
- [ ] All commits listed in spec match `git log` output
- [ ] No extra commits in git log missing from spec
- [ ] Commit hashes are full 40-character (not abbreviated)
- [ ] Commit dates are accurate

**If discrepancies found**:
- List missing commits
- List extra commits in spec
- Ask user to confirm which is correct

### 4. Constitutional Compliance Verification

For each commit in the range:

#### A. Checkout and Analyze
```bash
git checkout {commit_hash}
git show {commit_hash} --stat
```

#### B. Check for Constitutional Issues

Detect rename/branding commits:
- Files changed include: README.md, package.json, .env.example, language files
- Commit message contains: "rename", "rebrand", "name change"
- Diffs show: "YokaKit" → "PinkieIt", "yokakit" → "pinkieit"

**Action**: If found and NOT marked as skip → Flag for user confirmation

Detect identity preservation needs:
- Database name changes (yokakit → pinkieit)
- Application branding (APP_NAME, copyright)
- Service names in docker-compose.yml

**Action**: If found and NOT documented in adaptations → Flag for user

#### C. Verify YokaKit Adaptations

For each commit needing adaptation:
- [ ] Spec documents what to change (e.g., "pinkieit → yokakit in docker-compose.yml")
- [ ] Adaptation is specific (file name + change)
- [ ] No vague statements ("update naming as needed")

### 5. Scope Boundary Check

Verify commits are within phase boundaries:

```bash
# Check if commits belong to other phases
git log --oneline --all | grep -A5 -B5 "{commit_hash}"
```

**Questions to ask**:
1. Do all commits logically belong together?
2. Are there dependency commits from earlier phases?
3. Are there follow-up commits that should be in next phase?

### 6. Generate Clarification Report

Create `## Clarifications` section in spec.md (if not exists):

```markdown
## Clarifications

### Session {YYYY-MM-DD}

#### Commit Range Verification
- ✅ All {count} commits verified against PinkieIt git log
- ✅ Commit hashes are full 40-character format
- ⚠️ Discrepancy: {details} → **Resolution**: {user answer}

#### Constitutional Compliance
- ✅ {count} rename commits identified and marked for skip
- ✅ {count} adaptation commits documented with specific changes
- ⚠️ Missing constitutional handling for commit {hash}: {issue} → **Resolution**: {user answer}

#### YokaKit Naming Adaptations
- ✅ All adaptations documented with file paths
- ⚠️ Vague adaptation: "{description}" → **Clarified**: {specific change}

#### Scope Boundaries
- ✅ All commits belong to this phase
- ⚠️ Commit {hash} may belong to {other phase} → **Decision**: {keep/move/defer}

#### Ready for Planning
- [ ] All commits verified
- [ ] Constitutional strategy confirmed
- [ ] Adaptations clarified
- [ ] Scope boundaries clear
```

### 7. Interactive Clarification (Max 5 Questions)

Only ask questions if issues found. Priority order:

**Priority 1: Critical Errors**
1. "Commit {hash} appears in git log but not in spec. Include it?"
   - A: Yes, add to replay list
   - B: No, belongs to different phase
   - C: Skip (constitutional reason)

2. "Commit {hash} renames YokaKit→PinkieIt. Should skip per constitution?"
   - A: Yes, skip and document
   - B: No, adapt with YokaKit branding
   - C: Partial skip (explain)

**Priority 2: Constitutional Adaptations**
3. "Commit {hash} changes {file}. How to adapt for YokaKit?"
   - Format: Short answer (specific file + change)

4. "Database name in commit {hash} changes to 'pinkieit'. YokaKit action?"
   - A: Keep 'yokakit' (identity preservation)
   - B: Follow PinkieIt change
   - C: Other (explain)

**Priority 3: Scope Clarifications**
5. "Commit {hash} seems related to {feature}. Is this in Phase {N} scope?"
   - A: Yes, include in this phase
   - B: No, defer to later phase
   - C: Split (explain)

### 8. Update Spec After Each Answer

For each clarification:
1. Add to Clarifications section: `- Q: {question} → A: {answer}`
2. Update relevant spec section:
   - Commit list (add/remove)
   - Constitutional Skips (add commit with reason)
   - YokaKit Adaptations (add specific change)
   - Scope Analysis (adjust if needed)
3. Save spec.md immediately

### 9. Final Validation

Before completing:
- [ ] All commits from git log accounted for (replay, skip, or defer)
- [ ] All constitutional skips have documented reasons
- [ ] All adaptations have specific file+change details
- [ ] No assumptions about commit contents (all verified with `git show`)
- [ ] Clarifications section updated with session date

### 10. Completion Report

Output:
```
✅ Constitutional Verification Complete

Spec File: {FEATURE_SPEC}
Session: {date}

Commits Verified: {count}
Constitutional Skips: {count} (with reasons)
YokaKit Adaptations: {count} (with specifics)
Questions Asked: {count}/5

Issues Resolved:
- {issue_1}: {resolution}
- {issue_2}: {resolution}

Status: Ready for /plan ✅

Next: Run /plan to generate commit-based implementation strategy
```

## Critical Requirements

**DO NOT**:
- Skip commit verification (always run `git log`)
- Accept abbreviated commit hashes (require full 40-char)
- Allow vague adaptations ("update as needed")
- Assume commits without checking actual diffs

**ALWAYS**:
- Checkout PinkieIt at each commit to verify
- Cross-reference spec commits with actual git log
- Document constitutional skips with specific reasons
- Ensure all adaptations have file names and specific changes
- Save spec.md after each clarification

## If No Issues Found

Output:
```
✅ No critical clarifications needed

All commits verified against PinkieIt git log
Constitutional handling documented
YokaKit adaptations specified
Scope boundaries clear

Ready for /plan ✅
```

## Example Session

```
User: "/clarify"