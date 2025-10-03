---
description: Validate phase scope and constitutional compliance before implementation
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Perform non-destructive validation of phase artifacts to ensure:
1. PinkieIt commit range accuracy (spec ↔ git log)
2. Constitutional compliance in all documents
3. Task breakdown completeness (all commits → tasks)
4. Consistency across spec.md, plan.md, tasks.md

**This is a READ-ONLY analysis command. NO file modifications.**

**Critical for replay project**: Prevent Phase 1 scope creep mistakes by validating actual commits vs documented commits.

## Execution Workflow

### 1. Load Prerequisites

Run the setup script:
```bash
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
```

Parse JSON for:
- `FEATURE_DIR`: Specs directory
- `spec.md`: Phase specification
- `plan.md`: Implementation plan
- `tasks.md`: Task breakdown
- `research.md`: Commit analysis

**Verification**:
- [ ] All required files exist
- [ ] Constitution loaded (memory/constitution.md)

**If missing**: Report which prerequisite command to run.

### 2. Load Artifacts

Read all phase documents:

**spec.md**:
- Phase number and name
- PinkieIt commit range
- Commit list
- Constitutional clarifications
- YokaKit adaptations

**plan.md**:
- Commit replay strategy (CR1-CRN)
- Constitutional handling
- Validation criteria

**tasks.md**:
- Task breakdown (T001-T{end})
- Commit replay mapping
- Constitutional skip documentation

**research.md**:
- PinkieIt commit analysis
- Technical decisions
- Implementation patterns

**Constitution** (memory/constitution.md):
- Identity Preservation principles
- Historical Fidelity requirements
- Sequential Phase constraints

### 3. PinkieIt Commit Range Validation

**Objective**: Verify spec commits match actual PinkieIt git history

#### A. Extract Spec Commit Range

From spec.md:
- Start commit: {start_hash}
- End commit: {end_hash}
- Documented commits: {list}
- Constitutional skips: {list}

#### B. Get Actual PinkieIt Commits

```bash
cd pinkieit
git log --oneline --reverse {start_hash}..{end_hash}
```

#### C. Compare Spec vs Git Log

**Check**:
- [ ] All spec commits exist in git log
- [ ] No git log commits missing from spec
- [ ] All commit hashes are full 40-character
- [ ] Constitutional skips documented with reasons

**Report Discrepancies**:
```markdown
## Commit Range Validation

### ✅ Matches (git log = spec)
- {hash}: {description}
- ...

### ❌ Missing from Spec (in git log, not in spec)
- {hash}: {description}
  - **Risk**: Scope gap, feature missing
  - **Action**: Add to spec or document exclusion reason

### ❌ Extra in Spec (in spec, not in git log)
- {hash}: {description}
  - **Risk**: Invalid reference, scope creep
  - **Action**: Remove from spec or verify hash

### ⚠️ Abbreviated Hashes (not full 40-char)
- {short_hash}: {description}
  - **Risk**: Audit trail ambiguity
  - **Action**: Expand to full hash
```

### 4. Constitutional Compliance Analysis

**Objective**: Verify all documents follow constitutional requirements

#### A. Identity Preservation Validation

**Scan all documents for violations**:
```bash
# Check for pinkieit references in specs
grep -ri "pinkieit" {FEATURE_DIR}/ --exclude-dir=contracts

# Should only appear in:
# - PinkieIt commit references (acceptable)
# - Constitutional adaptation docs (acceptable)
# - NOT in: Implementation code examples, config samples
```

**Report**:
```markdown
## Constitutional: Identity Preservation

### ✅ Compliant
- All PinkieIt references are in commit citations
- All YokaKit adaptations documented
- No identity violations in implementation examples

### ❌ Violations
- {file}:{line}: "pinkieit" in config example
  - **Risk**: Constitutional violation
  - **Action**: Replace with yokakit

- {file}:{line}: Database name "pinkieit"
  - **Risk**: Identity not preserved
  - **Action**: Change to yokakit
```

#### B. Historical Fidelity Validation

**Check commit references**:
- [ ] All CRs reference PinkieIt commit hashes
- [ ] All hashes are full 40-character
- [ ] All commit dates documented
- [ ] No assumptions about commit contents

**Report**:
```markdown
## Constitutional: Historical Fidelity

### ✅ Compliant
- All CRs reference full PinkieIt hashes
- All commit dates documented
- research.md based on actual git show output

### ❌ Violations
- CR{N}: Missing PinkieIt hash reference
  - **Risk**: Audit trail broken
  - **Action**: Add full commit hash

- CR{N}: Assumed feature without git verification
  - **Risk**: Scope creep (Phase 1 mistake)
  - **Action**: Verify with git show {hash}
```

#### C. Sequential Phase Validation

**Check phase dependencies**:
- [ ] Phase {N-1} completed before Phase {N}
- [ ] No Phase {N+1} features in Phase {N}
- [ ] Dependencies documented

**Report**:
```markdown
## Constitutional: Sequential Phases

### ✅ Compliant
- Phase {N} follows Phase {N-1} completion
- No future phase features included
- All dependencies from previous phases documented

### ❌ Violations
- Task T{XXX}: References Phase {N+1} feature
  - **Risk**: Phase boundary violation
  - **Action**: Defer to Phase {N+1}

- CR{N}: Depends on Phase {N+1} infrastructure
  - **Risk**: Circular dependency
  - **Action**: Reorder or split commits
```

### 5. Task Coverage Analysis

**Objective**: Ensure all commits mapped to tasks

#### A. Build Coverage Map

For each PinkieIt commit (excluding skips):
- Extract from tasks.md: Associated tasks
- Verify: Analyze → Implement → Validate → Commit → GitHub pattern
- Check: All files from commit covered in tasks

#### B. Detect Coverage Gaps

**Missing Coverage**:
- Commits with no tasks
- Files in commits not in tasks
- Validations without success criteria

**Excessive Coverage**:
- Tasks referencing non-existent commits
- Files not in any PinkieIt commit
- Features from assumptions (not actual commits)

**Report**:
```markdown
## Task Coverage Analysis

### Coverage Summary
- Total Commits: {count}
- Constitutional Skips: {skip_count}
- Commits to Replay: {replay_count}
- Commits with Tasks: {covered_count}
- Coverage: {percentage}%

### ✅ Full Coverage
- CR1 ({hash}): T001-T005 (5 tasks)
- CR3 ({hash}): T006-T014 (9 tasks)
- ...

### ❌ Missing Coverage
- Commit {hash}: {description}
  - **Files**: {file_list}
  - **Risk**: Implementation gap
  - **Action**: Add tasks for this commit

### ❌ Excessive Coverage
- T{XXX}: References non-existent commit {hash}
  - **Risk**: Scope creep (Phase 1 lesson!)
  - **Action**: Remove task or verify commit

- T{XXX}: Implements {file} not in any commit
  - **Risk**: Assumption-based feature
  - **Action**: Verify file is from actual commit
```

### 6. Cross-Artifact Consistency Check

**Objective**: Ensure spec, plan, tasks are aligned

#### A. Commit Count Consistency

**Check**:
- spec.md commit count
- plan.md CR count
- tasks.md CR count
- All should match (excluding constitutional skips)

#### B. Naming Consistency

**Check**:
- Phase number and name consistent
- CR numbering consistent (CR1-CRN)
- Task numbering sequential (T001-T{end})

#### C. Constitutional Handling Consistency

**Check**:
- Skips documented in all files
- Adaptations consistent across files
- Validation criteria aligned

**Report**:
```markdown
## Cross-Artifact Consistency

### ✅ Consistent
- Commit count: spec (7) = plan (7) = tasks (7)
- Phase name: "Phase 1 Docker Foundation" in all files
- CR numbering: CR1-CR6 sequential

### ❌ Inconsistencies
- spec.md: 7 commits, tasks.md: 6 commits
  - **Missing**: {commit_description}
  - **Action**: Add missing CR to tasks.md

- plan.md: CR3 uses {name1}, tasks.md: CR3 uses {name2}
  - **Risk**: Confusion, tracking issues
  - **Action**: Standardize naming

- spec.md: Skip {hash} (reason A), plan.md: Skip {hash} (reason B)
  - **Risk**: Constitutional ambiguity
  - **Action**: Align skip reasons
```

### 7. Scope Boundary Validation

**Objective**: Detect out-of-scope features (Phase 1 lesson learned)

#### A. Verify All Features from Commits

**Check**:
- All tasks reference actual commit files
- No "nice to have" features
- No assumptions about what commit "should" contain

#### B. Detect Scope Creep Indicators

**Red Flags**:
- Tasks with no PinkieIt commit reference
- Features not in any commit diff
- "Also implement..." without commit citation
- Validation scripts not in commit range

**Report**:
```markdown
## Scope Boundary Validation

### ✅ In Scope
- All tasks reference PinkieIt commits
- All features from actual commit diffs
- No assumed features

### ❌ Out of Scope (Potential Scope Creep)
- T{XXX}: Implement DevContainer
  - **PinkieIt**: Commit 767388b (Phase 4, not Phase 1!)
  - **Risk**: Phase 1 mistake repeat
  - **Action**: Remove or defer to Phase 4

- T{XXX}: Add validation scripts
  - **PinkieIt**: No commit in range
  - **Risk**: Assumption-based feature
  - **Action**: Remove or find actual commit

### Lesson from Phase 1
- Removed T033-T047: DevContainer + validation scripts
- Reason: Not in actual Phase 1 commits (a5d3b77..13b40d1)
- Always verify: git show {hash}
```

### 8. Generate Analysis Report

Create structured report:

```markdown
# Phase {N} Analysis Report

**Date**: {date}
**Scope**: {start_commit}..{end_commit}
**Status**: {READY | ISSUES_FOUND | CRITICAL_ERRORS}

---

## Summary

| Category | Status | Issues | Critical |
|----------|--------|--------|----------|
| Commit Range Validation | ✅ | 0 | 0 |
| Constitutional Compliance | ⚠️ | 2 | 0 |
| Task Coverage | ✅ | 0 | 0 |
| Cross-Artifact Consistency | ⚠️ | 1 | 0 |
| Scope Boundaries | ✅ | 0 | 0 |

**Overall**: {PASS_WITH_WARNINGS | PASS | FAIL}

---

## Detailed Findings

{Include all validation sections from steps 3-7...}

---

## Metrics

- **Commits**: {total} ({replay} to replay, {skip} skipped)
- **Tasks**: {task_count} ({analyze} + {implement} + {validate} + {commit} + {github})
- **Coverage**: {percentage}% (commits with tasks)
- **Constitutional Violations**: {count}
- **Scope Creep Indicators**: {count}

---

## Next Actions

### Critical (Must Fix Before /implement)
{If any critical issues:}
- [ ] Fix: {issue_description}
- [ ] Action: {specific_command}

### Recommended (Should Fix)
{If non-critical issues:}
- [ ] Improve: {issue_description}
- [ ] Action: {suggestion}

### Ready to Proceed
{If no critical issues:}
- ✅ All validations passed
- ✅ Constitutional compliance verified
- ✅ Task coverage complete
- ✅ Scope boundaries clear

**Next**: Run /implement to begin execution

---

**Analysis Complete** | {timestamp}
```

### 9. Output and Recommendations

**If Critical Issues**:
```
❌ Critical Issues Found

Phase {N} has {count} critical issues that MUST be resolved:

1. {issue_1}: {description}
   Action: {command_to_fix}

2. {issue_2}: {description}
   Action: {command_to_fix}

Do NOT proceed with /implement until resolved.

Recommended workflow:
1. Fix critical issues
2. Rerun /analyze
3. Verify all ✅
4. Run /implement
```

**If Warnings Only**:
```
⚠️ Warnings Found (Non-Critical)

Phase {N} has {count} warnings:

{warning_list}

You may proceed with /implement, but consider fixing warnings for quality.

Recommended:
- Review warnings
- Fix if time permits
- Proceed to /implement if acceptable
```

**If All Clear**:
```
✅ Phase {N} Ready for Implementation

All validations passed:
- ✅ Commit range accurate ({count} commits verified)
- ✅ Constitutional compliance (0 violations)
- ✅ Task coverage ({percentage}% of commits)
- ✅ Cross-artifact consistency
- ✅ Scope boundaries clear

Next: Run /implement to begin execution

Estimated Duration: {weeks} weeks
```

## Critical Requirements

**DO NOT**:
- Modify any files (READ-ONLY command)
- Skip PinkieIt git log verification
- Assume commit contents without git show
- Ignore constitutional violations

**ALWAYS**:
- Verify spec commits against actual git log
- Check for Phase 1 scope creep patterns
- Validate constitutional compliance in all docs
- Report discrepancies with specific actions

## Example Usage

```
User: "/analyze"
Assistant: [Performs validation, outputs report]

User: "/analyze --focus=constitutional"
Assistant: [Deep dive on constitutional compliance only]
```

Context for analysis: $ARGUMENTS
