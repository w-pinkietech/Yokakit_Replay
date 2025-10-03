---
description: Execute commit-by-commit implementation from tasks.md with constitutional compliance
---

The user input can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

## Goal

Execute the commit-by-commit replay implementation by:
1. Following the task sequence from tasks.md (T001 → T{end})
2. Validating constitutional compliance at each commit replay
3. Creating audit trail commits with PinkieIt references
4. Managing GitHub Issues for tracking

**This command executes the full phase implementation with constitutional safeguards.**

## Execution Workflow

### 1. Load Prerequisites

Run the setup script to verify environment:
```bash
.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
```

Parse JSON for:
- `FEATURE_DIR`: Specs directory for this phase
- `tasks.md`: Task breakdown file
- `plan.md`: Implementation plan
- `research.md`: Commit analysis

**Verification**:
- [ ] tasks.md exists with commit replay structure
- [ ] plan.md contains commit replay strategy
- [ ] research.md contains PinkieIt commit analysis
- [ ] All constitutional clarifications resolved

**If missing**: Instruct user to run prerequisite commands (`/tasks`, `/plan`, `/clarify`).

### 2. Load Implementation Context

Read implementation artifacts:

**tasks.md**:
- Commit replay list (CR1, CR2, ..., CRN)
- Task sequence (T001 → T{end})
- Constitutional skip documentation
- GitHub Issue tracking requirements

**plan.md**:
- Commit replay strategy
- Constitutional handling approach
- Validation criteria

**research.md**:
- PinkieIt commit details
- Technical decisions
- Implementation patterns

### 3. Parse Task Structure

Extract from tasks.md:

**Commit Replays**:
- CR{N}: PinkieIt commit hash
- Tasks per CR (Analyze → Implement → Validate → Commit → GitHub)
- Constitutional adaptations required
- Dependencies between CRs

**Task Types**:
- **Preparation** (Analyze): Review PinkieIt commit
- **Implementation**: Replay files with adaptations
- **Validation**: Verify constitutional compliance
- **Git Commit**: Create audit trail
- **GitHub**: Track progress

### 4. Execute Commit-by-Commit Implementation

For each Commit Replay (CR1 → CRN):

#### Phase 1: Analyze (Preparation Task)

**Objective**: Verify PinkieIt commit state and plan adaptations

```bash
cd pinkieit
git checkout {commit_hash}
git show {commit_hash} --stat
git show {commit_hash}
```

**Extract**:
- Files changed
- Constitutional adaptations needed (pinkieit → yokakit)
- Implementation dependencies

**Document**: Update research.md if needed

**Validation**:
- [ ] All files identified
- [ ] Adaptations documented
- [ ] No assumptions

#### Phase 2: Implement (Implementation Tasks)

**Objective**: Replay PinkieIt commit with YokaKit identity

For each implementation task in the CR:

1. **Review PinkieIt file**:
   ```bash
   cd pinkieit
   git show {commit_hash}:{file_path}
   ```

2. **Apply constitutional adaptations**:
   - Replace `pinkieit` → `yokakit` (all occurrences)
   - Replace `PinkieIt` → `YokaKit` (all occurrences)
   - Preserve YokaKit database identity
   - Adapt service names in configs

3. **Create/modify YokaKit file**:
   ```bash
   cd ../YokaKit
   # Create or edit {file_path} with adaptations
   ```

**Constitutional Compliance Checks**:
- [ ] All pinkieit references changed
- [ ] YokaKit identity preserved in configs
- [ ] No PinkieIt branding
- [ ] Service names use yokakit

**Validation**:
- [ ] File structure matches PinkieIt (with naming)
- [ ] Functional requirements met
- [ ] No constitutional violations

#### Phase 3: Validate (Validation Task)

**Objective**: Verify CR implementation correctness

**File Existence Check**:
```bash
cd YokaKit
# Verify all expected files exist
ls -la {file_paths_from_commit}
```

**Constitutional Compliance Check**:
```bash
# No pinkieit references (case-insensitive)
grep -ri "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules --exclude-dir=.git
# Expected: No results
```

**Functional Validation**:
Run CR-specific tests:
- Docker services start (if Docker CR)
- Application loads (if app CR)
- Tests pass (if test infrastructure CR)

**Structural Validation**:
```bash
# Compare structure with PinkieIt (ignoring naming)
diff -r YokaKit/{path} pinkieit/{path} | grep -v "pinkieit\|yokakit"
```

**Success Criteria**:
- [ ] All files present
- [ ] Zero constitutional violations
- [ ] Functional tests pass
- [ ] Structure matches PinkieIt pattern

#### Phase 4: Commit (Git Commit Task)

**Objective**: Create commit with PinkieIt audit trail

```bash
cd YokaKit
git add .
git commit -m "{commit_type}: {description} (PinkieIt: {short_hash})

Replay of PinkieIt commit {full_40_char_hash}
Constitutional adaptations:
- pinkieit → yokakit naming
- YokaKit identity preserved in {configs}
- {other_specific_adaptations}

Files changed: {count}
- {key_file_1}
- {key_file_2}

Phase {N} CR{N}
YokaKit identity preserved ✓"
```

**Validation**:
- [ ] Commit message references PinkieIt hash
- [ ] Constitutional compliance documented
- [ ] Phase and CR number included

#### Phase 5: Track (GitHub Issue Task, if needed)

**Objective**: Create/update GitHub tracking issue

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

- [x] Analyzed PinkieIt commit
- [x] Implemented with constitutional adaptations
- [x] Validated implementation
- [x] Committed with audit trail

## Constitutional Compliance

- [x] YokaKit identity preserved
- [x] pinkieit → yokakit adaptations
- [x] No branding violations

**YokaKit Commit**: {yokakit_commit_hash}
EOF
)"
```

**Validation**:
- [ ] Issue created with labels
- [ ] Linked to milestone
- [ ] Referenced in Epic

### 5. Progress Tracking

After each CR completion:

**Update tasks.md**:
- Mark completed tasks with [x]
- Note any deviations or issues

**Report Progress**:
```
✅ CR{N} Complete: {description}

PinkieIt: {commit_hash}
YokaKit: {yokakit_commit_hash}
Tasks: T{start}-T{end} ({count} tasks)
Constitutional: ✓ Compliant

Remaining: CR{N+1}-CR{X} ({count} CRs)
```

**Halt Conditions**:
- Constitutional violation detected → Fix before proceeding
- Functional validation fails → Debug and resolve
- File structure mismatch → Review adaptations

### 6. Error Handling

**Constitutional Violation Detected**:
```
❌ Constitutional Violation in CR{N}

Issue: {description}
Location: {file_path}:{line}
Violation: {pinkieit reference | identity not preserved}

Action Required:
1. Review {file_path}
2. Apply constitutional adaptation
3. Rerun validation
4. Retry commit

Do not proceed to CR{N+1} until resolved.
```

**Functional Validation Failure**:
```
❌ Validation Failed for CR{N}

Test: {test_description}
Error: {error_message}

Debugging Steps:
1. Review PinkieIt commit: git show {hash}
2. Compare YokaKit implementation
3. Check constitutional adaptations
4. Verify dependencies from previous CRs

Fix and rerun validation before commit.
```

**Structural Mismatch**:
```
❌ Structure Mismatch in CR{N}

Expected (from PinkieIt): {expected_structure}
Actual (YokaKit): {actual_structure}

Action Required:
1. Review PinkieIt commit structure
2. Verify constitutional adaptations didn't alter structure
3. Adjust YokaKit implementation
4. Rerun structural validation
```

### 7. Completion Validation

After all CRs completed:

**Final Checks**:
- [ ] All tasks.md tasks marked [x]
- [ ] All CRs replayed (excluding constitutional skips)
- [ ] Zero constitutional violations
- [ ] All GitHub Issues created/closed
- [ ] YokaKit submodule reference ready for update

**Phase Completion Report**:
```
✅ Phase {N} Implementation Complete

**Commit Replays**:
- Total: {cr_count}
- Completed: {cr_count}
- Skipped: {skip_count} (constitutional)

**Constitutional Compliance**:
- Violations: 0
- Identity Preservation: ✓
- Audit Trail: ✓ (all commits reference PinkieIt)

**GitHub Tracking**:
- Epic: #{epic_number}
- Stories: #{story_numbers}
- All Issues: Closed ✓

**YokaKit Repository**:
- Commits: {count}
- Files Changed: {count}
- Lines Changed: +{add}, -{del}

**Next Steps**:
1. Update YokaKit_Replay submodule reference
2. Create Phase Completion Report
3. Close Phase {N} milestone
4. Begin Phase {N+1} planning
```

### 8. Manual Intervention Points

**Automatic Execution**:
- Simple file replays (configs, documentation)
- Clear constitutional adaptations
- Non-interactive validations

**User Confirmation Required**:
- Complex structural changes (app/ → app/laravel/)
- Database migrations affecting data
- Breaking changes requiring rollback plan
- Ambiguous constitutional adaptations

**Example**:
```
⚠️ User Confirmation Required for CR{N}

Task: Implement {complex_feature}
Risk: {risk_description}

PinkieIt Commit: {hash}
Files Affected: {count} files
Constitutional: {adaptation_summary}

Options:
1. Proceed with implementation
2. Review implementation plan first
3. Skip and defer to manual execution

Your choice: _
```

## Critical Requirements

**DO NOT**:
- Skip constitutional compliance validation
- Proceed with violations unresolved
- Commit without PinkieIt hash reference
- Create issues without constitutional labels

**ALWAYS**:
- Execute tasks in sequence (T001 → T{end})
- Validate after each CR before committing
- Document constitutional adaptations in commits
- Update tasks.md progress markers
- Halt on critical errors

## If Prerequisites Missing

Output:
```
❌ Cannot proceed with /implement

Missing prerequisites:

- [ ] tasks.md: Run /tasks to generate
- [ ] plan.md: Run /plan to create
- [ ] Clarifications: Run /clarify to verify

Complete all prerequisites before implementation.
```

## Example Usage

```
User: "/implement"
Assistant: [Executes T001 → T{end} with constitutional safeguards]

User: "/implement CR3"  # Resume from specific CR
Assistant: [Starts from CR3 tasks]
```

Context for implementation: $ARGUMENTS
