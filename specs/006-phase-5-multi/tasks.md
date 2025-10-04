# Tasks: Phase 5 - Multi-Architecture Docker Support

**Input**: Design documents from `specs/006-phase-5-multi/`
**Prerequisites**: plan.md, research.md, data-model.md, contracts/

## Execution Flow (/tasks command scope)

```
1. Load plan.md (commit replay strategy)
   → ✅ Loaded: Single commit replay (CR1: 9bfa0b5)
   → Extract: Docker Buildx multi-architecture implementation
2. Load research.md (commit analysis)
   → ✅ Loaded: PinkieIt commit 9bfa0b5 fully analyzed
   → Extract: Dockerfile changes, CLAUDE.md updates, constitutional adaptations
3. Generate tasks by CR:
   → CR1: Analyze → Implement (Dockerfile + CLAUDE.md) → Validate → Commit → GitHub
4. Apply task rules:
   → Single CR (no parallel CRs)
   → Dockerfile base/development stages sequential
   → Constitutional checks in every validation task
5. Number tasks sequentially (T001-T014)
6. Validate completeness:
   → ✅ CR1 has full task cycle (analyze, implement, validate, commit, GitHub)
   → ✅ All constitutional adaptations documented (pinkieit → yokakit)
7. Return: SUCCESS (14 tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths and PinkieIt commit references

## Path Conventions
- **YokaKit Repository**: `YokaKit/` (submodule where implementation happens)
- **YokaKit_Replay Repository**: Repository root (for CLAUDE.md documentation)
- **PinkieIt Repository**: `pinkieit/` (reference for commit replay)

---

## Overview

**PinkieIt Commits**: `9bfa0b5` (single commit)
**Total Commits**: 1
**Commits to Replay**: 1 (excluding 0 constitutional skips)
**Total Tasks**: 14

**Task Structure**: Commit Replay 1 (CR1) follows this pattern:
1. **Analyze**: Review PinkieIt commit 9bfa0b5 and verify prerequisites (T001-T002)
2. **Implement**: Replay Dockerfile and CLAUDE.md with constitutional compliance (T003-T007)
3. **Validate**: Verify multi-architecture builds and constitutional compliance (T008-T011)
4. **Commit**: Create commit with audit trail reference (T012)
5. **Track**: Create GitHub Issues for Phase 5 tracking (T013-T014)

---

## Constitutional Skips

**None** - All commits in Phase 5 are replayed. No constitutional violations in commit 9bfa0b5.

---

## Commit Replays

### Summary by Commit Replay:

- **CR1** (9bfa0b5): Tasks T001-T014 (14 tasks) - Multi-Architecture Docker Support

---

## COMMIT REPLAY 1: 9bfa0b5 - Multi-Architecture Docker Support

**PinkieIt Commit**: `9bfa0b555b94e14a3b55a2a8d8f205486432a027`
**Date**: 2025-06-26 22:58:51 +0900
**Files**: 2 files (+37, -12)
**Constitutional**: identity-preservation + adaptation (CLAUDE.md pinkieit → yokakit)

### Story/Issue Reference
- **YokaKit Epic**: #TBD (Phase 5: Multi-Architecture Docker Support)
- **YokaKit Story**: #TBD (CR1: Multi-Architecture Build Implementation)

---

### T001: Analyze Multi-Architecture Commit (9bfa0b5)

**Type**: Preparation
**Estimated**: 15 min

**Objective**: Verify PinkieIt commit 9bfa0b5 and plan constitutional adaptations for YokaKit

**Steps**:

1. Checkout PinkieIt at commit 9bfa0b5:
   ```bash
   cd pinkieit
   git checkout 9bfa0b555b94e14a3b55a2a8d8f205486432a027
   git show 9bfa0b5 --stat
   ```
   Expected: 2 files changed (Dockerfile, CLAUDE.md)

2. Review actual Dockerfile changes:
   ```bash
   git show 9bfa0b5 -- Dockerfile
   ```
   Expected: Base stage + development stage with `sharing=locked`, `--no-install-recommends`, cleanup

3. Review actual CLAUDE.md changes:
   ```bash
   git show 9bfa0b5 -- CLAUDE.md
   ```
   Expected: Phase 3 section, build commands with `pinkieit:*` tags

4. Identify constitutional adaptations needed:
   - [x] CLAUDE.md: `pinkieit:latest` → `yokakit:latest` (image tags)
   - [x] CLAUDE.md: `pinkieit:dev` → `yokakit:dev` (image tags)
   - [x] CLAUDE.md: `pinkieit:amd64` → `yokakit:amd64` (platform tags)
   - [x] CLAUDE.md: `pinkieit:arm64` → `yokakit:arm64` (platform tags)
   - [x] CLAUDE.md: Phase number 3 → 5 (YokaKit phase alignment)
   - [x] CLAUDE.md: Date 2025-06-26 → 2025-10-04 (YokaKit implementation date)
   - [x] Dockerfile: No naming changes needed (no pinkieit references)

5. Document findings:
   - All findings already documented in `specs/006-phase-5-multi/research.md`

**Validation**:
- [ ] All files in commit identified (Dockerfile, CLAUDE.md)
- [ ] Constitutional adaptations documented (6 changes in CLAUDE.md)
- [ ] No assumptions (all verified from `git show 9bfa0b5`)

---

### T002: [P] Verify Docker Buildx Prerequisites

**Type**: Preparation
**Estimated**: 10 min

**Objective**: Ensure Docker Buildx and QEMU are installed for multi-architecture builds

**Steps**:

1. Check Docker version:
   ```bash
   docker version
   ```
   Expected: Docker Engine 19.03 or higher

2. Check Docker Buildx:
   ```bash
   docker buildx version
   ```
   Expected: `github.com/docker/buildx v0.10.0` or higher

   If not installed:
   ```bash
   docker buildx install
   ```

3. Install QEMU binfmt for cross-platform builds:
   ```bash
   docker run --privileged --rm tonistiigi/binfmt --install all
   ```
   Expected: `Installing: linux/amd64, linux/arm64/v8, ...`

4. Verify multi-platform support:
   ```bash
   docker buildx ls
   ```
   Expected: Active builder with `linux/amd64*, linux/arm64` in platforms

**Validation**:
- [ ] Docker Buildx v0.10+ installed
- [ ] QEMU binfmt installed
- [ ] Multi-platform builder active
- [ ] Can build for both linux/amd64 and linux/arm64

**[P] Marker**: Can run in parallel with T001 (different systems/environments)

---

### T003: Implement Dockerfile Base Stage Multi-Arch Optimizations

**Type**: Implementation
**Estimated**: 20 min
**Dependencies**: T001

**Objective**: Update YokaKit Dockerfile base stage with multi-architecture support from PinkieIt 9bfa0b5

**Files to Modify**:
- `YokaKit/Dockerfile` (base stage RUN command)

**Implementation Steps**:

1. Review PinkieIt base stage changes:
   ```bash
   cd pinkieit
   git show 9bfa0b5:Dockerfile | sed -n '/^FROM php.*AS base/,/^FROM.*AS development/p' | head -35
   ```

2. Open YokaKit Dockerfile:
   ```bash
   cd ../YokaKit
   vim Dockerfile  # or your preferred editor
   ```

3. Locate base stage RUN command (around line 10-26):
   ```dockerfile
   # Current (Phase 2):
   RUN --mount=type=cache,target=/var/cache/apt \
       --mount=type=cache,target=/var/lib/apt \
       apt-get update && apt-get install -y \
       build-essential \
       curl \
       ...
   ```

4. Replace with multi-architecture version:
   ```dockerfile
   # Phase 5 (from PinkieIt 9bfa0b5):
   RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
       --mount=type=cache,target=/var/lib/apt,sharing=locked \
       rm -f /etc/apt/apt.conf.d/docker-clean \
       && apt-get update \
       && apt-get install -y --no-install-recommends \
       build-essential \
       curl \
       ca-certificates \
       && apt-get install -y --no-install-recommends \
       libfreetype6 libfreetype6-dev \
       libjpeg62-turbo libjpeg62-turbo-dev \
       libmariadb-dev libmariadb-dev-compat libmariadb3 \
       libonig-dev \
       libpng-dev libpng16-16 \
       libzip-dev libzip4 \
       locales pkg-config unzip zip \
       && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
       && apt-get update \
       && apt-get install -y --no-install-recommends nodejs \
       && a2enmod rewrite \
       && rm -rf /var/lib/apt/lists/*
   ```

**Key Changes Applied**:
- [x] Add `,sharing=locked` to both cache mounts (lines 1-2)
- [x] Add `rm -f /etc/apt/apt.conf.d/docker-clean` before apt-get
- [x] Change all `apt-get install -y` → `apt-get install -y --no-install-recommends`
- [x] Split package installation (essentials first, libraries second)
- [x] Add `ca-certificates` package (line 8)
- [x] Add `apt-get update` after Node.js repository setup
- [x] Add `rm -rf /var/lib/apt/lists/*` cleanup at end

**Constitutional Compliance**:
- [x] No pinkieit references in Dockerfile (verified in PinkieIt 9bfa0b5)
- [x] YokaKit identity preserved (Dockerfile has no naming)

**Validation**:
- [ ] Base stage RUN has `sharing=locked` on both cache mounts
- [ ] All apt-get install commands have `--no-install-recommends`
- [ ] `ca-certificates` package added
- [ ] Cleanup `rm -rf /var/lib/apt/lists/*` at end
- [ ] No syntax errors (Dockerfile lints successfully)

---

### T004: Implement Dockerfile Development Stage Multi-Arch Optimizations

**Type**: Implementation
**Estimated**: 10 min
**Dependencies**: T003

**Objective**: Update YokaKit Dockerfile development stage with multi-architecture support from PinkieIt 9bfa0b5

**Files to Modify**:
- `YokaKit/Dockerfile` (development stage RUN command)

**Implementation Steps**:

1. Review PinkieIt development stage changes:
   ```bash
   cd pinkieit
   git show 9bfa0b5:Dockerfile | sed -n '/^FROM base AS development/,/^FROM.*AS builder/p' | head -20
   ```

2. Locate YokaKit development stage RUN command (around line 90-95):
   ```dockerfile
   # Current (Phase 2):
   RUN --mount=type=cache,target=/var/cache/apt \
       --mount=type=cache,target=/var/lib/apt \
       apt-get update && apt-get install -y \
       gifsicle git jpegoptim optipng pngquant vim \
       && pecl install pcov && docker-php-ext-enable pcov
   ```

3. Replace with multi-architecture version:
   ```dockerfile
   # Phase 5 (from PinkieIt 9bfa0b5):
   RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
       --mount=type=cache,target=/var/lib/apt,sharing=locked \
       apt-get update && apt-get install -y --no-install-recommends \
       gifsicle git jpegoptim optipng pngquant vim \
       && pecl install pcov && docker-php-ext-enable pcov \
       && rm -rf /var/lib/apt/lists/*
   ```

**Key Changes Applied**:
- [x] Add `,sharing=locked` to both cache mounts
- [x] Add `--no-install-recommends` to apt-get install
- [x] Add `rm -rf /var/lib/apt/lists/*` cleanup at end

**Constitutional Compliance**:
- [x] No pinkieit references in Dockerfile
- [x] Consistent with base stage optimizations

**Validation**:
- [ ] Development stage RUN has `sharing=locked` on both cache mounts
- [ ] apt-get install has `--no-install-recommends`
- [ ] Cleanup `rm -rf /var/lib/apt/lists/*` at end
- [ ] No syntax errors

---

### T005: Update YokaKit_Replay CLAUDE.md with Multi-Arch Documentation

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T001

**Objective**: Add Phase 5 multi-architecture documentation to YokaKit_Replay CLAUDE.md with constitutional adaptations

**Files to Modify**:
- `CLAUDE.md` (YokaKit_Replay repository root, NOT in YokaKit submodule)

**Implementation Steps**:

1. Review PinkieIt CLAUDE.md changes:
   ```bash
   cd pinkieit
   git show 9bfa0b5:CLAUDE.md
   ```
   Expected: "Phase 3 Complete" section with pinkieit build commands

2. Open YokaKit_Replay CLAUDE.md:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay
   vim CLAUDE.md
   ```

3. Locate Docker Architecture section (search for "## Current Status"):
   - Find insertion point after "Phase 4 Framework Modernization - COMPLETE ✅"

4. Add Phase 5 section with YokaKit adaptations:
   ```markdown
   ### Phase 5 Complete: Multi-Architecture Docker Support (2025-10-04)

   **Status**: ✅ **COMPLETED** - Phase 5 multi-architecture support successfully implemented

   **Architecture Enhancements**:
   - **Multi-Architecture Support**: Linux AMD64 and ARM64 builds via Docker Buildx
   - **Concurrent Build Optimization**: `sharing=locked` cache mounts for parallel builds
   - **Image Size Optimization**: `--no-install-recommends` + cleanup
   - **Security Enhancement**: `ca-certificates` package for secure HTTPS

   **Build Commands** (Multi-Architecture):
   ```bash
   # Multi-architecture builds (Phase 5)
   docker buildx build --platform linux/amd64,linux/arm64 --target production -t yokakit:latest .
   docker buildx build --platform linux/amd64,linux/arm64 --target development -t yokakit:dev .

   # Platform-specific builds
   docker buildx build --platform linux/amd64 --target production --load -t yokakit:amd64 .
   docker buildx build --platform linux/arm64 --target production --load -t yokakit:arm64 .
   docker buildx build --platform linux/amd64 --target development --load -t yokakit:dev-amd64 .
   docker buildx build --platform linux/arm64 --target development --load -t yokakit:dev-arm64 .
   ```

   **Verification**:
   - ✅ AMD64 builds complete successfully
   - ✅ ARM64 builds complete successfully
   - ✅ Multi-architecture manifest created
   - ✅ All 425 tests passing on AMD64
   - ✅ Cross-platform functionality maintained
   ```

**Constitutional Adaptations Applied**:
- [x] Phase number: 3 → 5 (YokaKit phase alignment)
- [x] Date: 2025-06-26 → 2025-10-04
- [x] Image tags: `pinkieit:latest` → `yokakit:latest`
- [x] Image tags: `pinkieit:dev` → `yokakit:dev`
- [x] Image tags: `pinkieit:amd64` → `yokakit:amd64`
- [x] Image tags: `pinkieit:arm64` → `yokakit:arm64`
- [x] Image tags: `pinkieit:dev-*` → `yokakit:dev-*`

**Validation**:
- [ ] Phase 5 section added to CLAUDE.md
- [ ] All image tags use `yokakit:*` prefix
- [ ] Build commands are accurate and testable
- [ ] No `pinkieit` references in added content

---

### T006: [P] Verify Dockerfile Syntax and Linting

**Type**: Validation
**Estimated**: 5 min
**Dependencies**: T003, T004

**Objective**: Ensure Dockerfile has no syntax errors and follows best practices

**Steps**:

1. Use Dockerfile linter (if available):
   ```bash
   cd YokaKit
   docker run --rm -i hadolint/hadolint < Dockerfile
   ```
   Expected: No critical errors (warnings acceptable)

2. Manual syntax check (build dry-run):
   ```bash
   docker buildx build --target base --no-cache --progress=plain . 2>&1 | head -50
   ```
   Expected: No syntax errors in first few steps

**Validation**:
- [ ] No syntax errors in Dockerfile
- [ ] Hadolint checks pass (or not available)
- [ ] Dry-run build starts successfully

**[P] Marker**: Can run in parallel with T005 (different files)

---

### T007: [P] Verify Constitutional Compliance (No PinkieIt References)

**Type**: Validation
**Estimated**: 5 min
**Dependencies**: T003, T004, T005

**Objective**: Ensure zero pinkieit references in YokaKit codebase and YokaKit_Replay documentation

**Steps**:

1. Check YokaKit repository:
   ```bash
   cd YokaKit
   grep -ri "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules --exclude-dir=.git
   ```
   Expected: No results

2. Check YokaKit_Replay CLAUDE.md:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay
   grep -i "pinkieit" CLAUDE.md | grep -v "PinkieIt" | grep -v "reference"
   ```
   Expected: No results (except historical PinkieIt commit references)

3. Check Phase 5 specs directory:
   ```bash
   grep -ri "pinkieit" specs/006-phase-5-multi/ --exclude="*.md"
   ```
   Expected: No results (markdown files document PinkieIt for reference)

**Validation**:
- [ ] Zero pinkieit references in YokaKit Dockerfile
- [ ] Zero pinkieit image tags in CLAUDE.md build commands
- [ ] Only historical references to PinkieIt commits (acceptable)

**[P] Marker**: Can run in parallel with T006 (grep operations)

---

### T008: Test AMD64 Platform Builds

**Type**: Validation
**Estimated**: 10-15 min
**Dependencies**: T006, T007

**Objective**: Verify successful AMD64 builds for production and development stages

**Steps**:

1. Build production stage for AMD64:
   ```bash
   cd YokaKit
   docker buildx build --platform linux/amd64 --target production --load -t yokakit:amd64 .
   ```
   Expected: `Successfully built ...` with no errors

2. Build development stage for AMD64:
   ```bash
   docker buildx build --platform linux/amd64 --target development --load -t yokakit:dev-amd64 .
   ```
   Expected: `Successfully built ...` with no errors

3. Verify images created:
   ```bash
   docker images | grep yokakit
   ```
   Expected: `yokakit:amd64` and `yokakit:dev-amd64` present

4. Check image sizes:
   ```bash
   docker images yokakit:amd64 --format "{{.Repository}}:{{.Tag}} {{.Size}}"
   docker images yokakit:dev-amd64 --format "{{.Repository}}:{{.Tag}} {{.Size}}"
   ```
   Expected: Sizes similar to Phase 2 baseline (no significant increase)

**Validation**:
- [ ] Production AMD64 build succeeds
- [ ] Development AMD64 build succeeds
- [ ] Images tagged correctly (yokakit:amd64, yokakit:dev-amd64)
- [ ] Image sizes reasonable (not significantly larger than Phase 2)

---

### T009: Test ARM64 Platform Builds

**Type**: Validation
**Estimated**: 15-20 min (may be slower due to QEMU emulation)
**Dependencies**: T006, T007

**Objective**: Verify successful ARM64 builds for production and development stages

**Steps**:

1. Build production stage for ARM64:
   ```bash
   cd YokaKit
   docker buildx build --platform linux/arm64 --target production --load -t yokakit:arm64 .
   ```
   Expected: `Successfully built ...` (may take longer due to QEMU emulation)

2. Build development stage for ARM64:
   ```bash
   docker buildx build --platform linux/arm64 --target development --load -t yokakit:dev-arm64 .
   ```
   Expected: `Successfully built ...`

3. Verify images created:
   ```bash
   docker images | grep yokakit | grep arm64
   ```
   Expected: `yokakit:arm64` and `yokakit:dev-arm64` present

**Validation**:
- [ ] Production ARM64 build succeeds
- [ ] Development ARM64 build succeeds
- [ ] Images tagged correctly (yokakit:arm64, yokakit:dev-arm64)
- [ ] No architecture-specific build errors

**Note**: ARM64 builds may use QEMU emulation on AMD64 hosts (slower but functional)

---

### T010: Test Multi-Architecture Build (AMD64 + ARM64)

**Type**: Validation
**Estimated**: 20-25 min
**Dependencies**: T008, T009

**Objective**: Verify simultaneous multi-architecture builds work correctly

**Steps**:

1. Build multi-architecture production image:
   ```bash
   cd YokaKit
   docker buildx build --platform linux/amd64,linux/arm64 --target production -t yokakit:latest .
   ```
   Expected: `Successfully built ...` for both platforms
   Note: Cannot use `--load` with multiple platforms (use `--push` to registry or build separately)

2. Build multi-architecture development image:
   ```bash
   docker buildx build --platform linux/amd64,linux/arm64 --target development -t yokakit:dev .
   ```
   Expected: `Successfully built ...` for both platforms

3. Verify concurrent cache usage (check logs for sharing=locked):
   ```bash
   docker buildx build --platform linux/amd64,linux/arm64 --target production --progress=plain . 2>&1 | grep "cache"
   ```
   Expected: No cache conflict errors

**Validation**:
- [ ] Multi-architecture production build succeeds
- [ ] Multi-architecture development build succeeds
- [ ] Both AMD64 and ARM64 layers built
- [ ] No cache conflicts (sharing=locked works)

---

### T011: Run Tests on AMD64 Platform

**Type**: Validation
**Estimated**: 5-10 min
**Dependencies**: T008

**Objective**: Verify all 425 tests pass on AMD64 platform

**Steps**:

1. Run full test suite on AMD64 development image:
   ```bash
   cd YokaKit
   docker run --rm \
     -v $(pwd)/app/laravel:/var/www/html \
     yokakit:dev-amd64 \
     php artisan test
   ```
   Expected: `Tests: 425 passed (425 total)`

2. Verify DevContainer tests (if using DevContainer):
   ```bash
   docker exec yokakit-dev php artisan test
   ```
   Expected: `Tests: 425 passed (425 total)`

**Validation**:
- [ ] All 425 tests pass on AMD64
- [ ] No new test failures introduced
- [ ] Test execution time reasonable (<15 seconds)

**Note**: ARM64 runtime testing deferred if no ARM64 host available (build success sufficient)

---

### T012: Commit CR1 with Audit Trail

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T011

**Objective**: Commit Phase 5 multi-architecture changes with PinkieIt reference

**Steps**:

1. Stage all changes:
   ```bash
   cd YokaKit
   git add Dockerfile
   cd /mnt/shared_data/YokaKit_Replay
   git add CLAUDE.md
   ```

2. Commit YokaKit changes:
   ```bash
   cd YokaKit
   git commit -m "feat: add multi-architecture Docker support (PinkieIt: 9bfa0b5)

   Replay of PinkieIt commit 9bfa0b555b94e14a3b55a2a8d8f205486432a027

   Constitutional adaptations:
   - CLAUDE.md: pinkieit → yokakit image tags
   - CLAUDE.md: Phase 3 → Phase 5 alignment
   - CLAUDE.md: Date 2025-06-26 → 2025-10-04

   Files changed: 1 (Dockerfile)
   - Base stage: Add sharing=locked, --no-install-recommends, ca-certificates, cleanup
   - Development stage: Add sharing=locked, --no-install-recommends, cleanup

   Multi-architecture support:
   - Platforms: linux/amd64, linux/arm64
   - Concurrent builds: sharing=locked cache mounts
   - Image optimization: --no-install-recommends + cleanup
   - Security: ca-certificates for HTTPS

   Validation:
   - ✅ AMD64 builds successful (production + development)
   - ✅ ARM64 builds successful (production + development)
   - ✅ Multi-arch builds successful (simultaneous platforms)
   - ✅ All 425 tests passing on AMD64
   - ✅ Constitutional compliance (zero pinkieit references)

   Phase 5 CR1
   YokaKit identity preserved ✓"
   ```

3. Commit YokaKit_Replay changes:
   ```bash
   cd /mnt/shared_data/YokaKit_Replay
   git add CLAUDE.md
   git commit -m "docs: add Phase 5 multi-architecture Docker documentation

   Add multi-architecture build commands and verification checklist for Phase 5.

   Changes:
   - Phase 5 Complete section with build commands
   - yokakit:* image tags (constitutional adaptation from pinkieit:*)
   - Platform-specific build examples (AMD64, ARM64)
   - Verification checklist (425 tests, cross-platform)

   Reference: PinkieIt commit 9bfa0b555b94e14a3b55a2a8d8f205486432a027"
   ```

4. Verify commits:
   ```bash
   cd YokaKit
   git log -1 --stat
   cd /mnt/shared_data/YokaKit_Replay
   git log -1 --stat
   ```

**Validation**:
- [ ] YokaKit commit references PinkieIt hash 9bfa0b555b94e14a3b55a2a8d8f205486432a027
- [ ] Constitutional adaptations documented in commit message
- [ ] Phase 5 and CR1 noted in commit
- [ ] YokaKit_Replay CLAUDE.md commit created
- [ ] Both commits have clear descriptions

---

### T013: [P] Create GitHub Epic for Phase 5

**Type**: GitHub Issue
**Estimated**: 10 min
**Dependencies**: T012

**Objective**: Create tracking Epic in YokaKit repository for Phase 5

**Steps**:

1. Create Epic issue:
   ```bash
   gh issue create --repo w-pinkietech/YokaKit \
     --title "[EPIC] Phase 5: Multi-Architecture Docker Support" \
     --label "epic:phase-5,constitutional:identity-preservation" \
     --milestone "Phase 5" \
     --body "$(cat <<'EOF'
   ## Overview

   Implement cross-platform Docker build support for AMD64 and ARM64 architectures using Docker Buildx.

   ## PinkieIt Reference

   **Commit**: 9bfa0b555b94e14a3b55a2a8d8f205486432a027
   **Date**: 2025-06-26
   **Files**: 2 files (Dockerfile, CLAUDE.md)

   ## Implementation Status

   - ✅ CR1: Multi-Architecture Docker Support (Tasks T001-T014)

   ## Deliverables

   - ✅ Dockerfile base stage: Multi-arch optimizations (sharing=locked, --no-install-recommends, cleanup)
   - ✅ Dockerfile development stage: Multi-arch optimizations
   - ✅ CLAUDE.md documentation: Phase 5 build commands (yokakit:* tags)
   - ✅ AMD64 builds: Production + development stages
   - ✅ ARM64 builds: Production + development stages
   - ✅ Multi-architecture builds: Simultaneous AMD64 + ARM64
   - ✅ Test validation: 425/425 tests passing on AMD64

   ## Constitutional Compliance

   - ✅ YokaKit identity preserved (zero pinkieit references)
   - ✅ Constitutional adaptations: pinkieit → yokakit in CLAUDE.md
   - ✅ Audit trail: PinkieIt commit 9bfa0b5 referenced

   ## Success Criteria

   - ✅ Multi-architecture builds functional
   - ✅ Cross-platform compatibility maintained
   - ✅ Image size optimized
   - ✅ All tests passing
   - ✅ Documentation complete

   **Status**: ✅ Complete (YokaKit commit: TBD)
   EOF
   )"
   ```

2. Record Epic issue number:
   ```bash
   # Note the issue number from output (e.g., #120)
   echo "Epic Issue: #120" >> /mnt/shared_data/YokaKit_Replay/specs/006-phase-5-multi/github-issues.txt
   ```

**Validation**:
- [ ] Epic issue created with correct labels
- [ ] Linked to Phase 5 milestone
- [ ] Issue number recorded for reference

**[P] Marker**: Can run in parallel with T014 if creating multiple issues

---

### T014: [P] Create GitHub Story for CR1

**Type**: GitHub Issue
**Estimated**: 10 min
**Dependencies**: T012, T013

**Objective**: Create tracking Story in YokaKit repository for CR1

**Steps**:

1. Get Epic issue number:
   ```bash
   EPIC_NUMBER=$(cat /mnt/shared_data/YokaKit_Replay/specs/006-phase-5-multi/github-issues.txt | grep "Epic" | grep -oP '#\K[0-9]+')
   echo "Epic: #${EPIC_NUMBER}"
   ```

2. Create Story issue:
   ```bash
   gh issue create --repo w-pinkietech/YokaKit \
     --title "[Story] CR1: Multi-Architecture Docker Support Implementation" \
     --label "story:phase-5,constitutional:identity-preservation" \
     --milestone "Phase 5" \
     --body "$(cat <<'EOF'
   ## PinkieIt Reference

   **Commit**: 9bfa0b555b94e14a3b55a2a8d8f205486432a027
   **Date**: 2025-06-26 22:58:51 +0900
   **Files**: 2 files (+37, -12)

   ## Implementation Tasks

   - [x] T001: Analyze PinkieIt commit 9bfa0b5
   - [x] T002: Verify Docker Buildx prerequisites
   - [x] T003: Implement Dockerfile base stage multi-arch optimizations
   - [x] T004: Implement Dockerfile development stage multi-arch optimizations
   - [x] T005: Update CLAUDE.md with multi-arch documentation
   - [x] T006: Verify Dockerfile syntax and linting
   - [x] T007: Verify constitutional compliance (no pinkieit references)
   - [x] T008: Test AMD64 platform builds
   - [x] T009: Test ARM64 platform builds
   - [x] T010: Test multi-architecture build (AMD64 + ARM64)
   - [x] T011: Run tests on AMD64 platform (425/425 passing)
   - [x] T012: Commit CR1 with audit trail
   - [x] T013: Create GitHub Epic for Phase 5
   - [x] T014: Create GitHub Story for CR1 (this issue)

   ## Dockerfile Changes

   ### Base Stage
   - Added `sharing=locked` to cache mounts (concurrent builds)
   - Added `--no-install-recommends` to apt-get install (image size)
   - Added `ca-certificates` package (HTTPS security)
   - Added `rm -rf /var/lib/apt/lists/*` cleanup
   - Split package installation (essentials first, libraries second)

   ### Development Stage
   - Added `sharing=locked` to cache mounts
   - Added `--no-install-recommends` to apt-get install
   - Added `rm -rf /var/lib/apt/lists/*` cleanup

   ## CLAUDE.md Updates

   - Added Phase 5 Complete section
   - Build commands with yokakit:* tags (constitutional adaptation)
   - Platform-specific build examples (AMD64, ARM64)
   - Verification checklist

   ## Constitutional Compliance

   - [x] Zero pinkieit references in Dockerfile
   - [x] All pinkieit → yokakit adaptations in CLAUDE.md
   - [x] YokaKit identity preserved
   - [x] Audit trail: PinkieIt commit 9bfa0b5 referenced

   ## Validation Results

   - ✅ AMD64 production build: SUCCESS
   - ✅ AMD64 development build: SUCCESS
   - ✅ ARM64 production build: SUCCESS
   - ✅ ARM64 development build: SUCCESS
   - ✅ Multi-arch build (AMD64 + ARM64): SUCCESS
   - ✅ Test suite: 425/425 passing on AMD64
   - ✅ Constitutional check: PASS (zero violations)

   **Status**: ✅ Complete (YokaKit commit: TBD)

   Part of Epic #TBD_EPIC_NUMBER
   EOF
   )"
   ```

3. Link to Epic:
   ```bash
   STORY_NUMBER=$(gh issue list --repo w-pinkietech/YokaKit --label "story:phase-5" --limit 1 --json number --jq '.[0].number')
   gh issue comment ${STORY_NUMBER} --repo w-pinkietech/YokaKit \
     --body "Part of Epic #${EPIC_NUMBER}"
   ```

4. Record Story issue number:
   ```bash
   echo "Story Issue: #${STORY_NUMBER}" >> /mnt/shared_data/YokaKit_Replay/specs/006-phase-5-multi/github-issues.txt
   ```

**Validation**:
- [ ] Story issue created with correct labels
- [ ] Linked to Phase 5 milestone
- [ ] Referenced Epic issue
- [ ] Issue number recorded

**[P] Marker**: Can run in parallel with T013 if Epic already created

---

## Dependencies

### Commit Replay Sequence:
- **CR1**: T001 → T002 → T003 → T004 → T005 → T006 → T007 → T008 → T009 → T010 → T011 → T012 → T013 → T014

### Within CR1:
- **Preparation**: T001 (analyze) || T002 (prerequisites)
- **Implementation**: T003 (base stage) → T004 (dev stage) || T005 (CLAUDE.md)
- **Validation**: T006 (syntax) || T007 (constitutional) → T008 (AMD64) || T009 (ARM64) → T010 (multi-arch) → T011 (tests)
- **Commit**: T012 (after all validation passes)
- **GitHub**: T013 (Epic) || T014 (Story)

---

## Task Execution Strategy

### Sequential Execution (Recommended)

Execute tasks in order (T001 → T002 → ... → T014):

```bash
# Phase 5 CR1 Execution
# T001: Analyze PinkieIt commit 9bfa0b5
# T002: Verify Docker Buildx + QEMU prerequisites
# T003: Update Dockerfile base stage
# T004: Update Dockerfile development stage
# T005: Update CLAUDE.md documentation
# T006: Verify Dockerfile syntax
# T007: Constitutional compliance check
# T008: Test AMD64 builds
# T009: Test ARM64 builds
# T010: Test multi-architecture builds
# T011: Run 425 tests on AMD64
# T012: Commit with PinkieIt reference
# T013: Create GitHub Epic
# T014: Create GitHub Story
```

**Advantage**: Clear audit trail, easier debugging, constitutional compliance at each step

### Parallel Execution (Advanced)

Some tasks can run in parallel:

**Preparation** (T001 || T002):
```bash
# Terminal 1: Analyze commit
# Terminal 2: Verify Docker Buildx prerequisites
```

**Implementation** (T003 → T004 || T005):
```bash
# Terminal 1: Dockerfile base → dev stages (sequential)
# Terminal 2: CLAUDE.md documentation (parallel)
```

**Validation** (T006 || T007):
```bash
# Terminal 1: Dockerfile syntax check
# Terminal 2: Constitutional compliance grep
```

**Build Testing** (T008 || T009):
```bash
# Terminal 1: AMD64 builds
# Terminal 2: ARM64 builds (if sufficient resources)
```

**GitHub Issues** (T013 || T014):
```bash
# Terminal 1: Create Epic
# Terminal 2: Create Story (after Epic number obtained)
```

**Caution**: Ensure dependencies respected (e.g., T008/T009 after T006/T007)

---

## GitHub Issue Management

### Issue Creation Pattern

**Epic** (T013):
- Title: `[EPIC] Phase 5: Multi-Architecture Docker Support`
- Labels: `epic:phase-5`, `constitutional:identity-preservation`
- Milestone: `Phase 5`

**Story** (T014):
- Title: `[Story] CR1: Multi-Architecture Docker Support Implementation`
- Labels: `story:phase-5`, `constitutional:identity-preservation`
- Milestone: `Phase 5`
- References: PinkieIt commit 9bfa0b5, Epic issue

---

## Progress Tracking

### Commit Replay Checklist

- [ ] **CR1** (9bfa0b5): Multi-Architecture Docker Support (T001-T014) ✅

### Task Completion Checklist

- [ ] T001: Analyze commit 9bfa0b5
- [ ] T002: Verify Docker Buildx prerequisites
- [ ] T003: Implement Dockerfile base stage
- [ ] T004: Implement Dockerfile development stage
- [ ] T005: Update CLAUDE.md documentation
- [ ] T006: Verify Dockerfile syntax
- [ ] T007: Constitutional compliance check
- [ ] T008: Test AMD64 builds
- [ ] T009: Test ARM64 builds
- [ ] T010: Test multi-architecture builds
- [ ] T011: Run 425 tests on AMD64
- [ ] T012: Commit with audit trail
- [ ] T013: Create GitHub Epic
- [ ] T014: Create GitHub Story

### Constitutional Compliance Checklist

- [ ] Zero pinkieit references in YokaKit Dockerfile
- [ ] All pinkieit → yokakit adaptations in CLAUDE.md
- [ ] YokaKit identity preserved in all configurations
- [ ] All commits reference PinkieIt hash 9bfa0b5
- [ ] GitHub Issues track CR1 implementation

### Phase 5 Completion Criteria

- [ ] CR1 replayed successfully (1/1 commits)
- [ ] All 14 tasks completed
- [ ] Constitutional compliance: 100%
- [ ] GitHub Epic + Story created and closed
- [ ] YokaKit submodule updated in YokaKit_Replay

---

**Created**: 2025-10-04
**PinkieIt Reference**: 9bfa0b555b94e14a3b55a2a8d8f205486432a027
**Total Tasks**: 14
**Estimated Duration**: 4-6 hours
