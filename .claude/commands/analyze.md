---
description: Validate phase scope and constitutional compliance before implementation
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Perform comprehensive validation of the phase specification to ensure:
1. **Commit Range Accuracy**: All PinkieIt commits properly analyzed
2. **Constitutional Compliance**: Identity preservation and audit trail requirements met
3. **Scope Integrity**: No out-of-phase features included
4. **Task Coverage**: All commits have corresponding tasks
5. **Implementation Readiness**: All artifacts complete and consistent

**This is a READ-ONLY analysis. NO files will be modified.**

## Execution Workflow

### 1. Load Prerequisites

Run the setup script:
```bash
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
```

Parse JSON for:
- `FEATURE_DIR`: Specs directory
- `FEATURE_SPEC`: spec.md path
- `IMPL_PLAN`: plan.md path
- `TASKS_FILE`: tasks.md path

**Abort if missing**: Instruct user to run prerequisite commands.

### 2. Load All Artifacts

Read and parse:
- **spec.md**: Phase description, commit range, clarifications
- **plan.md**: Commit replay strategy, constitutional handling
- **tasks.md**: Task breakdown, CR mapping
- **research.md**: Technical analysis (if exists)
- **constitution**: `.specify/memory/constitution.md` (non-negotiable)

### 3. Build Semantic Models

#### Commit Inventory
From spec.md and plan.md:
- PinkieIt commit range (start..end)
- Each commit's:
  - Full hash (40-char)
  - Short hash
  - Date
  - Description
  - Constitutional status (replay | skip | adapt)

#### Task Inventory
From tasks.md:
- All tasks (T001, T002, ...)
- Task type (Analyze | Implement | Validate | Commit | GitHub)
- CR mapping (which commit each task belongs to)
- File references
- Validation criteria

#### Constitutional Requirements
From constitution:
- Identity Preservation: YokaKit naming mandatory
- Historical Fidelity: PinkieIt commit references required
- Audit Trail: Full commit hash references mandatory
- Sequential Phases: No cross-phase contamination

### 4. Detection Passes

#### A. Commit Range Accuracy

**Verify**:
1. Run actual git log:
   ```bash
   cd pinkieit
   git log --oneline --reverse {start_commit}..{end_commit}
   ```

2. Compare with spec.md commits:
   - [ ] All git log commits listed in spec
   - [ ] No extra commits in spec not in git log
   - [ ] All commit hashes are full 40-character
   - [ ] Commit dates match git log

**Report**:
- Missing commits (in git log, not in spec)
- Extra commits (in spec, not in git log)
- Abbreviated hashes (not 40-char)

**Severity**: CRITICAL (any discrepancy)

#### B. Constitutional Compliance

**Identity Preservation**:
1. Check spec.md for YokaKit naming adaptations:
   - [ ] pinkieit → yokakit documented
   - [ ] PinkieIt → YokaKit documented
   - [ ] Database identity preserved

2. Check tasks.md for constitutional validation:
   - [ ] Each CR has validation task
   - [ ] Validation includes `grep -ri "pinkieit"` check
   - [ ] Commit tasks note "YokaKit identity preserved"

**Historical Fidelity**:
1. Check commit skip rationale:
   - [ ] All skips have constitutional reason
   - [ ] Rename commits marked as skip
   - [ ] Branding commits marked for adaptation

2. Check commit references:
   - [ ] All tasks reference PinkieIt commit hash
   - [ ] Commit messages template includes hash
   - [ ] Audit trail documented

**Severity**: CRITICAL (constitutional violations)

#### C. Scope Integrity

**Phase Boundary Check**:
1. Analyze commit dates:
   - [ ] All commits within expected timeline
   - [ ] No commits from future phases
   - [ ] No commits from prior phases (unless dependency)

2. Compare with development timeline:
   - Read `docs/analysis/timeline/pinkieit-development-timeline.md`
   - Verify commits belong to this phase

3. Check for scope creep:
   - [ ] No features not in actual commits
   - [ ] No assumption-based tasks
   - [ ] All tasks traceable to specific commit

**Report**:
- Out-of-scope commits
- Assumption-based features
- Phase boundary violations

**Severity**: HIGH (scope creep risks)

#### D. Task Coverage

**Commit-to-Task Mapping**:
1. For each commit to replay:
   - [ ] Has Analyze task
   - [ ] Has Implement task(s)
   - [ ] Has Validate task
   - [ ] Has Commit task
   - [ ] Has GitHub task (if needed)

2. For each task:
   - [ ] References specific PinkieIt commit
   - [ ] Specifies exact files
   - [ ] Has validation criteria

**Report**:
- Commits without tasks
- Tasks without commit references
- Vague tasks (no file paths)

**Severity**: HIGH (incomplete implementation)

#### E. Artifact Consistency

**Cross-Document Validation**:
1. spec.md ↔ plan.md:
   - [ ] Same commit count
   - [ ] Same commit hashes
   - [ ] Same constitutional skips

2. plan.md ↔ tasks.md:
   - [ ] All CRs in plan have tasks
   - [ ] Task count matches complexity estimate
   - [ ] Constitutional handling consistent

3. spec.md ↔ tasks.md:
   - [ ] Clarifications addressed in tasks
   - [ ] Success criteria have validation tasks

**Report**:
- Inconsistent commit counts
- Missing CR tasks
- Unaddressed clarifications

**Severity**: MEDIUM (consistency issues)

#### F. Implementation Readiness

**Required Artifacts**:
- [ ] spec.md with Clarifications section
- [ ] plan.md with commit replay strategy
- [ ] tasks.md with full task breakdown
- [ ] research.md with technical analysis
- [ ] contracts/ (if configuration changes)

**Quality Checks**:
- [ ] No placeholders (TODO, TBD, ???)
- [ ] No vague descriptions ("implement feature")
- [ ] All file paths specific
- [ ] All validation criteria measurable

**Report**:
- Missing artifacts
- Incomplete sections
- Vague specifications

**Severity**: HIGH (blocks implementation)

### 5. Severity Assignment

**CRITICAL** (blocks implementation):
- Commit range discrepancies
- Constitutional violations
- Missing constitutional skips
- Abbreviated commit hashes

**HIGH** (risks quality):
- Out-of-scope commits
- Incomplete task coverage
- Missing validation tasks
- Vague task descriptions

**MEDIUM** (cosmetic issues):
- Inconsistent terminology
- Minor documentation gaps
- Optional artifact missing

**LOW** (improvements):
- Wording suggestions
- Additional validation ideas

### 6. Generate Analysis Report

Output Markdown report (NO FILE WRITES):

```markdown
# Phase {N} Specification Analysis Report

**Generated**: {date}
**Phase**: {N} - {name}
**PinkieIt Commits**: `{start_commit}..{end_commit}`

## Executive Summary

**Overall Status**: {READY | ISSUES FOUND | CRITICAL ISSUES}

**Metrics**:
- Commits Analyzed: {count}
- Constitutional Skips: {count}
- Tasks Generated: {count}
- Critical Issues: {count}
- High Issues: {count}
- Medium Issues: {count}

**Recommendation**: {PROCEED | FIX ISSUES | BLOCKED}

---

## Detailed Findings

| ID | Category | Severity | Location | Summary | Recommendation |
|----|----------|----------|----------|---------|----------------|
| CR1 | Commit Range | CRITICAL | spec.md:L45 | Missing commit {hash} from git log | Add commit to spec, analyze |
| CC1 | Constitutional | CRITICAL | tasks.md:T015 | No validation task for CR3 | Add validation task |
| SI1 | Scope Integrity | HIGH | tasks.md:T033-T047 | DevContainer is Phase 4 feature | Remove out-of-scope tasks |
| TC1 | Task Coverage | HIGH | plan.md:CR5 | No implement tasks for CR5 | Generate tasks for commit {hash} |
| AC1 | Artifact Consistency | MEDIUM | plan.md vs tasks.md | Different commit counts (6 vs 5) | Verify and align |

---

## Commit Range Validation

**Expected** (from spec.md):
- {hash_1}: {description}
- {hash_2}: {description}
- {hash_N}: {description}

**Actual** (from git log):
```bash
cd pinkieit
git log --oneline --reverse {start}..{end}
```
{git_log_output}

**Discrepancies**:
- ❌ Missing: {hash} - {description}
- ❌ Extra: {hash} - {description}
- ✅ Matching: {count} commits

---

## Constitutional Compliance

### Identity Preservation
- ✅ YokaKit naming adaptations documented
- ✅ Database identity preservation noted
- ⚠️ Issue: {specific_issue}

### Historical Fidelity
- ✅ All commits reference PinkieIt hashes
- ✅ Constitutional skips documented
- ⚠️ Issue: {specific_issue}

### Audit Trail
- ✅ Commit message template includes hash
- ✅ Phase and CR documented
- ⚠️ Issue: {specific_issue}

---

## Scope Integrity

**Phase Boundaries**:
- ✅ All commits within {phase_name} timeline
- ⚠️ Out-of-scope: {commit_hash} - {reason}

**Feature Analysis**:
- ✅ All features from actual commits
- ⚠️ Assumption-based: {feature} - {location}

---

## Task Coverage

**Commit Replay Coverage**:
| CR | PinkieIt Hash | Analyze | Implement | Validate | Commit | GitHub | Status |
|----|---------------|---------|-----------|----------|--------|--------|--------|
| CR1 | {hash} | T001 ✅ | T002-T005 ✅ | T006 ✅ | T007 ✅ | T008 ✅ | Complete |
| CR2 | {hash} | SKIP | - | - | - | - | Constitutional |
| CR3 | {hash} | T009 ✅ | T010-T015 ✅ | ❌ MISSING | T016 ✅ | T017 ✅ | Incomplete |

**Issues**:
- ❌ CR3 missing validation task
- ❌ CR5 has no implement tasks

---

## Artifact Consistency

**spec.md ↔ plan.md**:
- Commits: {spec_count} vs {plan_count} {✅ | ❌}
- Skips: {spec_count} vs {plan_count} {✅ | ❌}
- Hashes: {match_status}

**plan.md ↔ tasks.md**:
- CRs: {plan_count} vs {tasks_count} {✅ | ❌}
- Tasks per CR: {consistent | inconsistent}

---

## Implementation Readiness

**Required Artifacts**:
- [x] spec.md (with Clarifications)
- [x] plan.md (with commit replay strategy)
- [x] tasks.md (with task breakdown)
- [x] research.md (technical analysis)
- [ ] contracts/ (OPTIONAL - not needed for this phase)

**Quality Checks**:
- [ ] No placeholders: {count} found
- [ ] No vague descriptions: {count} found
- [ ] All file paths specific: {yes | no}
- [ ] All validations measurable: {yes | no}

---

## Next Actions

{IF CRITICAL ISSUES:}
❌ **BLOCKED**: Cannot proceed with implementation

**Required Fixes** (Priority Order):
1. {critical_issue_1}: {remediation}
2. {critical_issue_2}: {remediation}

**Commands**:
```bash
# Fix commit range
/specify "Phase {N}: {corrected_range}"

# Re-verify
/clarify

# Regenerate plan and tasks
/plan
/tasks
```

{IF HIGH ISSUES ONLY:}
⚠️ **CAUTION**: Issues found but not blocking

**Recommended Fixes**:
1. {high_issue_1}: {remediation}
2. {high_issue_2}: {remediation}

**Decision**: User may proceed with caution or fix issues first

{IF NO ISSUES:}
✅ **READY**: All validations passed

**Proceed with**:
```bash
/implement
```

---

## Constitutional Compliance Score

**Overall**: {percentage}%

**Breakdown**:
- Identity Preservation: {score}% {✅ | ⚠️ | ❌}
- Historical Fidelity: {score}% {✅ | ⚠️ | ❌}
- Audit Trail: {score}% {✅ | ⚠️ | ❌}
- Sequential Phases: {score}% {✅ | ⚠️ | ❌}

**Target**: 100% (non-negotiable)

---

**Analysis Complete**: {date}
**Status**: {READY | FIX REQUIRED | BLOCKED}
```

### 7. User Interaction

After report output, ask:

```
Would you like me to:
A) Suggest concrete fixes for the top {N} issues
B) Proceed with implementation despite warnings
C) Abort and require manual review

[A/B/C]
```

**DO NOT** automatically fix issues. User must approve.

## Critical Requirements

**DO NOT**:
- Modify any files (READ-ONLY analysis)
- Hallucinate missing sections
- Skip constitutional validation
- Approve implementation with CRITICAL issues

**ALWAYS**:
- Verify against actual git log
- Check full 40-character hashes
- Validate constitutional compliance
- Report specific line numbers/locations
- Provide actionable recommendations

## If Artifacts Missing

Output:
```
❌ Cannot perform analysis

Missing prerequisites:
- [ ] spec.md: Run /specify
- [ ] plan.md: Run /plan
- [ ] tasks.md: Run /tasks

Complete workflow:
1. /specify "Phase {N}: {range}"
2. /clarify
3. /plan
4. /tasks
5. /analyze (this command)
6. /implement (after validation)
```

## Behavior Rules

- **Deterministic**: Same input → same output (consistent IDs)
- **Non-destructive**: Never modify files
- **Specific**: Report line numbers, not vague "issues found"
- **Actionable**: Every issue has remediation suggestion
- **Constitutional**: Constitution is non-negotiable authority

Context for analysis: $ARGUMENTS
