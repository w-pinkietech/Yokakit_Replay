# Tasks: Phase 6 - CI/CD Pipeline & Multi-Architecture Publishing

**Input**: Design documents from `specs/007-phase-6-cicd/`
**Prerequisites**: plan.md, research.md, data-model.md, contracts/

## Execution Flow (/tasks command scope)
```
1. Load plan.md (commit replay strategy: single CR)
2. Load research.md (commit 6bb70e1 analysis)
3. Generate tasks by CR:
   → CR1: Analyze → Implement (3 workflows) → Validate → Commit → Documentation
4. Apply task rules:
   → Workflow files are [P] (independent YAML files)
   → Documentation tasks sequential (CLAUDE.md, README.md)
   → Constitutional checks in every validation task
5. Number tasks sequentially (T001-T013)
6. Validate completeness:
   → All CRs have full task cycle? ✅
   → All constitutional adaptations documented? ✅
9. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths and PinkieIt commit references

## Path Conventions
- **YokaKit Repository**: `/mnt/shared_data/YokaKit_Replay/YokaKit/` (implementation target)
- **YokaKit_Replay Repository**: `/mnt/shared_data/YokaKit_Replay/` (documentation)
- **PinkieIt Repository**: `/mnt/shared_data/YokaKit_Replay/pinkieit/` (reference)

## Overview

**PinkieIt Commits**: `6bb70e1` (single commit)
**Total Commits**: 1
**Commits to Replay**: 1 (excluding 0 constitutional skips)
**Total Tasks**: 13

**Task Structure**: CR1 follows this pattern:
1. **Analyze**: Review PinkieIt commit 6bb70e1 and extract workflow files (T001)
2. **Implement**: Create 3 workflow files with constitutional compliance (T002-T004)
3. **Documentation**: Update YokaKit_Replay CLAUDE.md and README.md (T005-T006)
4. **Configure**: Set up GitHub Container Registry permissions (T007)
5. **Validate**: Test all workflows with manual dispatch (T008-T010)
6. **Compliance**: Verify constitutional compliance (T011)
7. **Verify**: Confirm all workflows pass (T012)
8. **Commit**: Create commits with audit trail (T013)

## Constitutional Skips

**None** - This single commit contains only technical CI/CD automation with naming adaptations.

---

## Commit Replays

### Summary by Commit Replay:

- **CR1** (6bb70e1): Tasks T001-T013 (13 tasks, 6-8 hours)

---

## COMMIT REPLAY 1: 6bb70e1 - CI/CD Pipeline with Multi-Architecture Docker Builds

**PinkieIt Commit**: `6bb70e13a520e2acf59905708446083d4ccf9f8e`
**Date**: 2025-07-04 02:39:33 +0900
**Files**: 5 files (+423, -200)
**Constitutional**: Identity preservation (automatic via ${{ github.repository }})

### Story/Issue Reference
- **YokaKit Epic**: Create Epic for Phase 6 (T001 prerequisite)
- **YokaKit Story**: Create Story for CR1 after completion

---

### T001: Analyze PinkieIt commit 6bb70e1 and extract workflow files

**Type**: Preparation
**Estimated**: 15 min

**Objective**: Verify PinkieIt commit 6bb70e1 state and extract GitHub Actions workflow files

**Steps**:

1. Navigate to PinkieIt repository:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/pinkieit
   git checkout 6bb70e13a520e2acf59905708446083d4ccf9f8e
   ```

2. Review commit changes:
   ```bash
   git show 6bb70e1 --stat
   # Expected: 5 files changed, +423, -200
   ```

3. Extract workflow files to temporary location:
   ```bash
   git show 6bb70e1:.github/workflows/docker-build.yml > /tmp/phase6-docker-build.yml
   git show 6bb70e1:.github/workflows/docker-publish.yml > /tmp/phase6-docker-publish.yml
   git show 6bb70e1:.github/workflows/cache-cleanup.yml > /tmp/phase6-cache-cleanup.yml
   ```

4. Review constitutional compliance in workflows:
   ```bash
   # Verify IMAGE_NAME uses context variable (not hardcoded pinkieit)
   grep "IMAGE_NAME" /tmp/phase6-*.yml
   # Expected: IMAGE_NAME: ${{ github.repository }}
   ```

5. Document findings in research.md (if not already done)

**Validation**:
- [ ] All 3 workflow files extracted successfully
- [ ] IMAGE_NAME uses ${{ github.repository }} (automatic YokaKit adaptation)
- [ ] No hardcoded "pinkieit" in workflow logic
- [ ] Constitutional adaptations identified (CLAUDE.md documentation only)

---

### T002: [P] Create docker-build.yml workflow in YokaKit

**Type**: Implementation
**Estimated**: 30 min
**Dependencies**: T001

**Objective**: Create multi-architecture Docker build workflow with GitHub Actions cache

**File to Create**:
- `YokaKit/.github/workflows/docker-build.yml` (based on PinkieIt commit 6bb70e1)

**Implementation Steps**:

1. Create workflows directory if not exists:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   mkdir -p .github/workflows
   ```

2. Copy workflow from temporary location:
   ```bash
   cp /tmp/phase6-docker-build.yml .github/workflows/docker-build.yml
   ```

3. Verify constitutional compliance (automatic via ${{ github.repository }}):
   ```bash
   # Confirm IMAGE_NAME uses GitHub context variable
   grep "IMAGE_NAME" .github/workflows/docker-build.yml
   # Expected: IMAGE_NAME: ${{ github.repository }}
   # This automatically resolves to w-pinkietech/YokaKit for YokaKit
   ```

4. Review workflow configuration:
   - Triggers: workflow_dispatch, push to main, pull_request
   - Matrix: [production, development]
   - Platforms: linux/amd64, linux/arm64
   - Cache: type=gha, scoped by environment
   - Conditional push: PRs build only, main branch pushes to registry

**Constitutional Compliance**:
- [x] IMAGE_NAME uses ${{ github.repository }} (automatic YokaKit reference)
- [x] No hardcoded "pinkieit" references in workflow
- [x] Registry: ghcr.io (GitHub Container Registry)

**Validation**:
- [ ] File created at YokaKit/.github/workflows/docker-build.yml
- [ ] Workflow uses ${{ github.repository }} for IMAGE_NAME
- [ ] No constitutional violations (no "pinkieit" literals)
- [ ] Syntax valid (check with `gh workflow view docker-build.yml` after push)

**Reference**: contracts/docker-build-workflow.contract.md

---

### T003: [P] Create docker-publish.yml workflow in YokaKit

**Type**: Implementation
**Estimated**: 20 min
**Dependencies**: T001

**Objective**: Create registry publishing workflow with environment selection

**File to Create**:
- `YokaKit/.github/workflows/docker-publish.yml` (based on PinkieIt commit 6bb70e1)

**Implementation Steps**:

1. Copy workflow from temporary location:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   cp /tmp/phase6-docker-publish.yml .github/workflows/docker-publish.yml
   ```

2. Verify constitutional compliance (automatic):
   ```bash
   grep "IMAGE_NAME" .github/workflows/docker-publish.yml
   # Expected: IMAGE_NAME: ${{ github.repository }}
   ```

3. Review workflow configuration:
   - Triggers: workflow_dispatch (manual), push to main, version tags (v*)
   - Environment selection: production / development / both
   - Conditional build logic based on input
   - Multi-architecture publishing (AMD64 + ARM64)

**Constitutional Compliance**:
- [x] IMAGE_NAME uses ${{ github.repository }} (automatic YokaKit reference)
- [x] No hardcoded "pinkieit" references
- [x] Conditional logic uses generic variables

**Validation**:
- [ ] File created at YokaKit/.github/workflows/docker-publish.yml
- [ ] Environment selection logic correct (production/development/both)
- [ ] No constitutional violations
- [ ] Syntax valid (check with `gh workflow view docker-publish.yml` after push)

**Reference**: contracts/docker-publish-workflow.contract.md

---

### T004: [P] Create cache-cleanup.yml workflow in YokaKit

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T001

**Objective**: Create automated GitHub Actions cache lifecycle management workflow

**File to Create**:
- `YokaKit/.github/workflows/cache-cleanup.yml` (based on PinkieIt commit 6bb70e1)

**Implementation Steps**:

1. Copy workflow from temporary location:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   cp /tmp/phase6-cache-cleanup.yml .github/workflows/cache-cleanup.yml
   ```

2. Verify constitutional compliance (automatic):
   ```bash
   grep "github.repository" .github/workflows/cache-cleanup.yml
   # Expected: Uses ${{ github.repository }} in GitHub API calls
   ```

3. Review workflow configuration:
   - Schedule: Weekly on Sundays at 2 AM UTC (cron: '0 2 * * 0')
   - Manual trigger: workflow_dispatch
   - Cache age threshold: 7 days (604800 seconds)
   - GitHub API integration for cache management

**Constitutional Compliance**:
- [x] Repository reference uses ${{ github.repository }} (automatic YokaKit)
- [x] No hardcoded "pinkieit" references
- [x] Generic cache cleanup logic (scope-agnostic)

**Validation**:
- [ ] File created at YokaKit/.github/workflows/cache-cleanup.yml
- [ ] Schedule cron expression correct: '0 2 * * 0'
- [ ] Age threshold: 604800 seconds (7 days)
- [ ] No constitutional violations
- [ ] Syntax valid (check with `gh workflow view cache-cleanup.yml` after push)

**Reference**: contracts/cache-cleanup-workflow.contract.md

---

### T005: Update YokaKit_Replay CLAUDE.md with Phase 6 documentation

**Type**: Documentation
**Estimated**: 20 min
**Dependencies**: T002, T003, T004

**Objective**: Document Phase 6 CI/CD pipeline in YokaKit_Replay CLAUDE.md

**File to Update**:
- `YokaKit_Replay/CLAUDE.md`

**Implementation Steps**:

1. Update "Current Status" section:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay
   # Edit CLAUDE.md
   ```

2. Add Phase 6 status:
   ```markdown
   ## Current Status: Phase 6 CI/CD Pipeline & Multi-Architecture Publishing - IN PROGRESS 🚧

   ### Phase 6 Implementation Status 🚧
   - **GitHub Actions Workflows**: ✅ 3 workflows created
     - docker-build.yml: Multi-architecture build with testing
     - docker-publish.yml: Registry publishing with environment selection
     - cache-cleanup.yml: Automated cache lifecycle management
   - **GitHub Container Registry**: 🚧 Configuration pending
   - **Workflow Testing**: 🚧 Manual dispatch validation pending
   - **PinkieIt Reference**: 1 commit (6bb70e1)
   ```

3. Update Phase Structure section:
   ```markdown
   - **Phase 6**: CI/CD Integration & Final Polish 🚧 IN PROGRESS
   ```

4. Add Phase 6 workflow documentation:
   ```markdown
   ### Phase 6 CI/CD Workflows

   **Multi-Architecture Build** (docker-build.yml):
   - Triggers: Manual dispatch, push to main, pull requests
   - Matrix: production + development environments
   - Platforms: linux/amd64, linux/arm64
   - Cache: GitHub Actions cache (type=gha, scoped by environment)
   - Push: Conditional (PRs build only, main pushes to ghcr.io)

   **Registry Publishing** (docker-publish.yml):
   - Triggers: Manual dispatch, push to main, version tags (v*)
   - Environment selection: production / development / both
   - Multi-architecture publishing to ghcr.io

   **Cache Cleanup** (cache-cleanup.yml):
   - Schedule: Weekly on Sundays at 2 AM UTC
   - Deletes caches older than 7 days
   - Reports cache usage via GitHub API
   ```

**Constitutional Compliance**:
- [x] All workflow examples reference yokakit (not pinkieit)
- [x] Repository references use w-pinkietech/YokaKit
- [x] Image names: ghcr.io/w-pinkietech/yokakit:*

**Validation**:
- [ ] CLAUDE.md updated with Phase 6 status
- [ ] Workflow documentation added
- [ ] All references use YokaKit naming (not PinkieIt)
- [ ] Phase structure updated

---

### T006: Update YokaKit_Replay README.md with Phase 6 status

**Type**: Documentation
**Estimated**: 10 min
**Dependencies**: T005

**Objective**: Update README.md component status table with Phase 6 progress

**File to Update**:
- `YokaKit_Replay/README.md`

**Implementation Steps**:

1. Update component status table:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay
   # Edit README.md
   ```

2. Update YokaKit component row:
   ```markdown
   | **YokaKit** | 実際の開発対象アプリケーション | 独立GitHubリポジトリ<br>（サブモジュール参照） | 🚧 Phase 6実装中<br>**CI/CD Pipeline (GitHub Actions)**<br>**Multi-Arch Docker Publishing**<br>425/425 tests (100%) 🎉<br>📋 Phase 6完了予定 |
   ```

3. Update Phase 6 section:
   ```markdown
   #### **Phase 6: CI/CD Pipeline & Multi-Architecture Publishing** 🚧 **実装中** (6-8時間見積)
   **Timeline**: 実装中 (2025-10-04開始)
   **Pattern Source**: PinkieIt 2025-07-04 (1 commit: 6bb70e1)
   **Spec**: [specs/007-phase-6-cicd/](./specs/007-phase-6-cicd/)

   **実装中**:
   - ✅ **GitHub Actions Workflows**: 3 workflows created
   - 🚧 **GitHub Container Registry**: Configuration pending
   - 🚧 **Workflow Testing**: Validation pending
   - 🚧 **Cache Management**: Automated cleanup setup

   **実装結果**: CI/CD自動化完成（予定）
   ```

**Validation**:
- [ ] README.md component status updated
- [ ] Phase 6 section shows "実装中" status
- [ ] Workflow count correct (3 workflows)
- [ ] Timeline and references accurate

---

### T007: Configure GitHub Container Registry permissions

**Type**: Configuration
**Estimated**: 10 min
**Dependencies**: T002, T003, T004

**Objective**: Ensure YokaKit repository has ghcr.io publishing permissions

**Steps**:

1. Verify GITHUB_TOKEN permissions in workflows:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   grep -A 5 "permissions:" .github/workflows/docker-build.yml
   # Expected:
   # permissions:
   #   contents: read
   #   packages: write
   ```

2. Check repository settings (via web or gh CLI):
   ```bash
   gh api repos/w-pinkietech/YokaKit/actions/permissions
   # Expected: {"enabled": true, "allowed_actions": "all"}
   ```

3. Verify workflow permissions setting:
   ```bash
   # Repository Settings > Actions > General > Workflow permissions
   # Should be: "Read and write permissions"
   gh api repos/w-pinkietech/YokaKit -q '.permissions'
   ```

4. Test registry authentication (local):
   ```bash
   echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin
   # Expected: Login Succeeded
   ```

**Validation**:
- [ ] Workflow files have packages:write permission
- [ ] Repository Actions enabled
- [ ] Workflow permissions set to "Read and write"
- [ ] Registry authentication test successful

---

### T008: Test docker-build.yml workflow with manual dispatch

**Type**: Validation
**Estimated**: 15 min
**Dependencies**: T002, T007

**Objective**: Validate multi-architecture build workflow executes successfully

**Steps**:

1. Push workflows to YokaKit repository:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   git add .github/workflows/docker-build.yml
   git commit -m "feat: add multi-architecture Docker build workflow (PinkieIt: 6bb70e1)"
   git push origin feature/phase-6-cicd
   ```

2. Create PR or merge to main to enable workflow

3. Trigger manual workflow dispatch (build without push):
   ```bash
   gh workflow run docker-build.yml --repo w-pinkietech/YokaKit --ref main \
     -f push_to_registry=false \
     -f environment=production
   ```

4. Check workflow run status:
   ```bash
   gh run list --workflow=docker-build.yml --repo w-pinkietech/YokaKit --limit 1
   # Expected: Status "completed", Conclusion "success"
   ```

5. View workflow logs:
   ```bash
   RUN_ID=$(gh run list --workflow=docker-build.yml --repo w-pinkietech/YokaKit --limit 1 --json databaseId --jq '.[0].databaseId')
   gh run view $RUN_ID --repo w-pinkietech/YokaKit --log
   ```

**Validation**:
- [ ] Workflow triggered successfully
- [ ] Build completed for both production and development
- [ ] Multi-architecture build (AMD64 + ARM64) successful
- [ ] No registry push (push_to_registry=false respected)
- [ ] GitHub Actions cache populated

**Success Criteria**:
- Workflow status: completed
- Conclusion: success
- Build time: < 15 minutes per environment

---

### T009: Test docker-publish.yml workflow with manual dispatch

**Type**: Validation
**Estimated**: 15 min
**Dependencies**: T003, T007

**Objective**: Validate registry publishing workflow with environment selection

**Steps**:

1. Push workflow to repository:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   git add .github/workflows/docker-publish.yml
   git commit -m "feat: add Docker registry publishing workflow (PinkieIt: 6bb70e1)"
   git push origin feature/phase-6-cicd
   ```

2. Trigger manual publish (production only):
   ```bash
   gh workflow run docker-publish.yml --repo w-pinkietech/YokaKit --ref main \
     -f environment=production
   ```

3. Check workflow run:
   ```bash
   gh run list --workflow=docker-publish.yml --repo w-pinkietech/YokaKit --limit 1
   # Expected: Status "completed", Conclusion "success"
   ```

4. Verify image published to ghcr.io:
   ```bash
   docker pull ghcr.io/w-pinkietech/yokakit:latest-production
   # Expected: Pull successful
   ```

5. Inspect multi-architecture manifest:
   ```bash
   docker buildx imagetools inspect ghcr.io/w-pinkietech/yokakit:latest-production
   # Expected: Platforms: linux/amd64, linux/arm64
   ```

**Validation**:
- [ ] Workflow completed successfully
- [ ] Only production environment built (not development)
- [ ] Image published to ghcr.io
- [ ] Multi-architecture manifest correct (AMD64 + ARM64)
- [ ] Tags applied correctly (latest-production)

**Success Criteria**:
- Image pullable from ghcr.io
- Both AMD64 and ARM64 variants available
- Environment selection logic works

---

### T010: Test cache-cleanup.yml workflow with manual dispatch

**Type**: Validation
**Estimated**: 10 min
**Dependencies**: T004, T007

**Objective**: Validate automated cache cleanup workflow

**Steps**:

1. Push workflow to repository:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   git add .github/workflows/cache-cleanup.yml
   git commit -m "feat: add automated cache cleanup workflow (PinkieIt: 6bb70e1)"
   git push origin feature/phase-6-cicd
   ```

2. Check current cache usage:
   ```bash
   gh api repos/w-pinkietech/YokaKit/actions/caches --jq '.total_count'
   # Expected: Number of caches from previous builds
   ```

3. Trigger manual cleanup:
   ```bash
   gh workflow run cache-cleanup.yml --repo w-pinkietech/YokaKit
   ```

4. Check workflow run and logs:
   ```bash
   gh run list --workflow=cache-cleanup.yml --repo w-pinkietech/YokaKit --limit 1
   RUN_ID=$(gh run list --workflow=cache-cleanup.yml --limit 1 --json databaseId --jq '.[0].databaseId')
   gh run view $RUN_ID --repo w-pinkietech/YokaKit --log
   # Expected: "Found X old caches to delete" or "No old caches found"
   ```

5. Verify cache usage reported:
   ```bash
   # Check workflow logs for cache status report
   # Expected: "Current cache usage: X" and cache sizes listed
   ```

**Validation**:
- [ ] Workflow completed successfully
- [ ] Old caches deleted (if any older than 7 days)
- [ ] Cache usage report generated
- [ ] No errors in deletion process

**Success Criteria**:
- Workflow runs without errors
- Cache cleanup logic executes
- Usage statistics reported

---

### T011: Verify constitutional compliance (no pinkieit references)

**Type**: Validation
**Estimated**: 5 min
**Dependencies**: T002, T003, T004

**Objective**: Ensure zero PinkieIt references in YokaKit workflow files

**Steps**:

1. Check for pinkieit references in workflows:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   grep -ri "pinkieit" .github/workflows/
   # Expected: No results
   ```

2. Verify IMAGE_NAME resolution:
   ```bash
   grep "IMAGE_NAME" .github/workflows/docker-*.yml
   # Expected: IMAGE_NAME: ${{ github.repository }}
   # This resolves to w-pinkietech/YokaKit automatically
   ```

3. Check registry image paths:
   ```bash
   grep "ghcr.io" .github/workflows/*.yml
   # Expected: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
   # No hardcoded "pinkieit" in paths
   ```

4. Verify YokaKit_Replay documentation:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay
   grep -i "pinkieit" CLAUDE.md README.md | grep -v "PinkieIt Reference" | grep -v "pinkieit/"
   # Expected: Only PinkieIt commit references, no code/config pinkieit naming
   ```

**Validation**:
- [ ] Zero "pinkieit" string literals in YokaKit/.github/workflows/
- [ ] IMAGE_NAME uses ${{ github.repository }} (context variable)
- [ ] Documentation uses yokakit for image names
- [ ] Only legitimate PinkieIt references are commit hashes

**Success Criteria**:
- grep "pinkieit" .github/workflows/ returns 0 results
- All image references use YokaKit naming

---

### T012: Verify all workflows pass in YokaKit repository

**Type**: Validation
**Estimated**: 10 min
**Dependencies**: T008, T009, T010, T011

**Objective**: Confirm all Phase 6 workflows execute successfully

**Steps**:

1. List recent workflow runs:
   ```bash
   gh run list --repo w-pinkietech/YokaKit --limit 10
   # Expected: docker-build, docker-publish, cache-cleanup all "success"
   ```

2. Check workflow status summary:
   ```bash
   gh api repos/w-pinkietech/YokaKit/actions/workflows \
     --jq '.workflows[] | select(.path | contains("docker") or contains("cache")) | {name, state, path}'
   # Expected: All workflows "active" state
   ```

3. Verify multi-architecture images in registry:
   ```bash
   # List YokaKit packages
   gh api user/packages?package_type=container --jq '.[] | select(.name=="yokakit") | .name'
   # Expected: "yokakit"

   # Inspect latest image
   docker buildx imagetools inspect ghcr.io/w-pinkietech/yokakit:latest-production
   # Expected: linux/amd64, linux/arm64 platforms
   ```

4. Verify cache infrastructure:
   ```bash
   gh api repos/w-pinkietech/YokaKit/actions/caches --jq '.total_count'
   # Expected: Active caches from production/development builds
   ```

**Validation**:
- [ ] All 3 workflows show "success" status
- [ ] Multi-architecture images available in ghcr.io
- [ ] GitHub Actions cache populated and managed
- [ ] No workflow failures or errors

**Success Criteria**:
- docker-build.yml: ✅ Success
- docker-publish.yml: ✅ Success
- cache-cleanup.yml: ✅ Success
- Registry images: ✅ Available (AMD64 + ARM64)

---

### T013: Commit Phase 6 implementation with audit trail

**Type**: Git Commit
**Estimated**: 5 min
**Dependencies**: T012

**Objective**: Commit all Phase 6 changes with PinkieIt reference

**Steps**:

1. Stage all YokaKit workflow changes:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   git add .github/workflows/docker-build.yml
   git add .github/workflows/docker-publish.yml
   git add .github/workflows/cache-cleanup.yml
   ```

2. Commit with PinkieIt reference:
   ```bash
   git commit -m "feat: add CI/CD pipeline with multi-architecture publishing (PinkieIt: 6bb70e1)

   Replay of PinkieIt commit 6bb70e13a520e2acf59905708446083d4ccf9f8e
   Constitutional adaptations: Automatic via \${{ github.repository }} context

   Files added:
   - .github/workflows/docker-build.yml (180 lines)
   - .github/workflows/docker-publish.yml (91 lines)
   - .github/workflows/cache-cleanup.yml (49 lines)

   Workflows:
   - Multi-architecture Docker builds (AMD64 + ARM64)
   - GitHub Container Registry publishing (ghcr.io)
   - Automated cache cleanup (weekly, 7-day retention)

   Phase 6 CR1 Complete
   YokaKit identity preserved ✓

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

3. Stage YokaKit_Replay documentation:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay
   git add CLAUDE.md README.md
   ```

4. Commit documentation updates:
   ```bash
   git commit -m "docs: Phase 6 CI/CD pipeline implementation complete

   - Updated CLAUDE.md with workflow documentation
   - Updated README.md component status (Phase 6 完了)
   - Added GitHub Actions workflow details

   Phase 6 Complete ✅
   PinkieIt Reference: 6bb70e13a520e2acf59905708446083d4ccf9f8e

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

5. Verify commits:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay/YokaKit
   git log -1 --stat

   cd /mnt/shared_data/YokaKit_Replay
   git log -1 --stat
   ```

**Validation**:
- [ ] YokaKit commit includes all 3 workflow files
- [ ] Commit message references PinkieIt hash 6bb70e1
- [ ] YokaKit_Replay commit updates documentation
- [ ] Both commits have audit trail
- [ ] Phase 6 CR1 marked complete

---

## Dependencies

**Commit Replay Sequence**:
- CR1: T001 → T002-T004 (parallel) → T005-T006 (sequential) → T007 → T008-T010 (sequential per workflow) → T011 → T012 → T013

**Within CR1**:
- T001: Analyze (prerequisite for all)
- T002-T004: Implement workflows [P] (parallel, independent YAML files)
- T005-T006: Documentation (sequential, same files)
- T007: Configure (prerequisite for testing)
- T008-T010: Test workflows (sequential, shared resources)
- T011: Constitutional check (validation)
- T012: Final verification (all workflows)
- T013: Commit (after all validation)

---

## Task Execution Strategy

### Sequential Execution (Recommended)

Execute tasks in order T001 → T002 → ... → T013:

```bash
# Phase 6 execution flow:
# T001: Analyze PinkieIt commit 6bb70e1
# T002-T004: [P] Create all 3 workflow files (can parallelize)
# T005-T006: Update documentation (sequential)
# T007: Configure GitHub Container Registry
# T008-T010: Test each workflow (sequential)
# T011: Constitutional compliance check
# T012: Final workflow verification
# T013: Commit with audit trail
```

**Advantage**: Clear validation at each step, easier debugging

### Parallel Execution (Advanced)

T002-T004 can run in parallel (independent YAML files):

```bash
# Terminal 1: docker-build.yml (T002)
# Terminal 2: docker-publish.yml (T003)
# Terminal 3: cache-cleanup.yml (T004)
```

**Caution**: T005-T006 must be sequential (same documentation files), T008-T010 must be sequential (shared GitHub Actions resources)

---

## GitHub Issue Management

### Epic Creation (Prerequisite)

```bash
gh issue create --repo w-pinkietech/YokaKit \
  --title "[EPIC] Phase 6: CI/CD Pipeline & Multi-Architecture Publishing" \
  --label "epic:phase-6,constitutional:identity-preservation" \
  --milestone "Phase 6" \
  --body "$(cat <<'EOF'
## Overview

Complete YokaKit DevOps infrastructure with GitHub Actions CI/CD automation.

**PinkieIt Reference**: Commit 6bb70e13a520e2acf59905708446083d4ccf9f8e
**Estimated Duration**: 6-8 hours

## Objectives

- [ ] Multi-architecture Docker builds (AMD64 + ARM64)
- [ ] GitHub Container Registry publishing
- [ ] Automated cache lifecycle management
- [ ] Constitutional compliance (YokaKit identity preserved)

## Success Criteria

- [ ] All 3 workflows operational
- [ ] ghcr.io images published successfully
- [ ] Cache cleanup automated (weekly)
- [ ] Zero pinkieit references in workflows

**Status**: 🚧 In Progress
EOF
)"
```

### Story Creation (After T013)

```bash
gh issue create --repo w-pinkietech/YokaKit \
  --title "[Story] CR1: CI/CD Pipeline with Multi-Architecture Docker Builds" \
  --label "story:phase-6,constitutional:identity-preservation" \
  --milestone "Phase 6" \
  --body "$(cat <<'EOF'
## PinkieIt Reference

**Commit**: `6bb70e13a520e2acf59905708446083d4ccf9f8e`
**Date**: 2025-07-04 02:39:33 +0900
**Files**: 5 files (+423, -200)

## Implementation

Tasks:
- [x] T001: Analyze PinkieIt commit 6bb70e1
- [x] T002: Create docker-build.yml workflow
- [x] T003: Create docker-publish.yml workflow
- [x] T004: Create cache-cleanup.yml workflow
- [x] T005-T006: Update documentation
- [x] T007: Configure GitHub Container Registry
- [x] T008-T010: Test all workflows
- [x] T011: Verify constitutional compliance
- [x] T012: Verify all workflows pass
- [x] T013: Commit with audit trail

## Workflows Created

1. **docker-build.yml**: Multi-architecture builds with testing
2. **docker-publish.yml**: Registry publishing with environment selection
3. **cache-cleanup.yml**: Automated cache cleanup (weekly)

## Constitutional Compliance

- [x] YokaKit identity preserved (IMAGE_NAME uses ${{ github.repository }})
- [x] Zero pinkieit references in workflow files
- [x] Documentation uses yokakit naming

## Validation

- [x] All workflows execute successfully
- [x] Multi-architecture images in ghcr.io (AMD64 + ARM64)
- [x] Cache cleanup operational

**Status**: ✅ Complete (see commit YOKAKIT_COMMIT_HASH)
EOF
)" \
  && gh issue comment STORY_NUMBER --body "Part of Epic #EPIC_NUMBER"
```

---

## Progress Tracking

### Commit Replay Checklist

- [ ] **CR1** (6bb70e1): CI/CD Pipeline with Multi-Architecture Docker Builds (T001-T013)
  - [ ] T001: Analyze commit
  - [ ] T002: docker-build.yml
  - [ ] T003: docker-publish.yml
  - [ ] T004: cache-cleanup.yml
  - [ ] T005: Update CLAUDE.md
  - [ ] T006: Update README.md
  - [ ] T007: Configure ghcr.io
  - [ ] T008: Test docker-build
  - [ ] T009: Test docker-publish
  - [ ] T010: Test cache-cleanup
  - [ ] T011: Constitutional check
  - [ ] T012: Verify workflows
  - [ ] T013: Commit

### Constitutional Compliance Checklist

- [ ] Zero "pinkieit" references in YokaKit/.github/workflows/
- [ ] IMAGE_NAME uses ${{ github.repository }} context variable
- [ ] Documentation uses yokakit image naming
- [ ] Commit messages reference PinkieIt hash 6bb70e1
- [ ] GitHub Issues track Phase 6 progress

### Phase Completion Criteria

- [ ] All 1 commit replayed (6bb70e1)
- [ ] All 13 tasks completed (T001-T013)
- [ ] Constitutional compliance: 100%
- [ ] All workflows operational in YokaKit
- [ ] GitHub Container Registry publishing active
- [ ] Cache cleanup automated
- [ ] YokaKit submodule updated in YokaKit_Replay (if needed)

---

**Created**: 2025-10-04
**PinkieIt Reference**: 6bb70e13a520e2acf59905708446083d4ccf9f8e (single commit)
**Total Tasks**: 13
**Estimated Duration**: 6-8 hours
**Task Structure**: CR1 (Analyze → Implement 3 workflows → Documentation → Configure → Test → Validate → Commit)
