# Phase 2: Docker Architecture Optimization - Task Breakdown

## Overview

**PinkieIt Commits**: `b980f1e..08ac389`
**Total Commits**: 4
**Commits to Replay**: 4 (excluding 0 constitutional skips)
**Total Tasks**: 24

**Task Structure**: Each Commit Replay (CR) follows this pattern:
1. **Analyze**: Review PinkieIt commit and plan adaptations
2. **Implement**: Replay files with constitutional compliance
3. **Validate**: Verify implementation matches PinkieIt + YokaKit identity
4. **Commit**: Create commit with audit trail reference
5. **Track**: Create/update GitHub Issues

## Constitutional Skips

**No commits skipped** - All 4 commits comply with identity preservation requirements.

---

## Commit Replays

### Summary by Commit Replay:

- **CR1** (b980f1e): Tasks T001-T005 (5 tasks) - Docker baseline
- **CR2** (f9340aa): Tasks T006-T013 (8 tasks) - Multi-stage consolidation
- **CR3** (fe2acac): Tasks T014-T019 (6 tasks) - BuildKit optimization
- **CR4** (08ac389): Tasks T020-T024 (5 tasks) - Final consolidation

---

## COMMIT REPLAY 1: b980f1e - Docker baseline metrics and optimization foundation

**PinkieIt Commit**: `b980f1eef1c628962186f7e18012c1330a55b579`
**Date**: 2025-06-26 19:47:40 +0900
**Files**: 2 files (+160, -2)
**Constitutional**: Direct replay (no PinkieIt/YokaKit naming)

### Story/Issue Reference
- **YokaKit Epic**: #TBD (Phase 2: Docker Architecture Optimization)
- **YokaKit Story**: #TBD (CR1: Docker baseline)

---

### T001: Analyze Docker baseline commit (b980f1e)

**Type**: Preparation
**Estimated**: 15 min

**Objective**: Verify PinkieIt commit state and identify .dockerignore patterns

**Steps**:
1. Checkout PinkieIt at commit b980f1e:
   ```bash
   cd pinkieit
   git checkout b980f1eef1c628962186f7e18012c1330a55b579
   git show b980f1e --stat
   ```

2. Review .dockerignore content:
   ```bash
   git show b980f1e:.dockerignore
   ```

3. Review CLAUDE.md changes:
   ```bash
   git show b980f1e:CLAUDE.md
   ```

4. Document findings:
   - [ ] .dockerignore has 124 lines (generic rules, no PinkieIt/YokaKit naming)
   - [ ] CLAUDE.md adds Docker optimization context
   - [ ] No constitutional adaptations required

**Validation**:
- [ ] All files in commit identified
- [ ] No PinkieIt-specific naming found
- [ ] Ready for direct copy

---

### T002: Implement .dockerignore

**Type**: Implementation
**Estimated**: 10 min
**Dependencies**: T001

**Objective**: Copy .dockerignore from PinkieIt b980f1e

**Files to Create**:
- `YokaKit/.dockerignore` (based on PinkieIt commit)

**Implementation Steps**:
1. Extract .dockerignore from PinkieIt:
   ```bash
   cd pinkieit
   git show b980f1e:.dockerignore > /tmp/dockerignore
   ```

2. Copy to YokaKit repository:
   ```bash
   cp /tmp/dockerignore ../YokaKit/.dockerignore
   ```

3. Verify content (124 lines expected):
   ```bash
   wc -l ../YokaKit/.dockerignore
   ```

**Constitutional Compliance**:
- [ ] No PinkieIt references (generic ignore rules)
- [ ] File content matches PinkieIt commit exactly

**Validation**:
- [ ] .dockerignore exists in YokaKit root
- [ ] 124 lines present
- [ ] Syntax valid (no trailing whitespace issues)

---

### T003: Update CLAUDE.md with Docker optimization context

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T001

**Objective**: Add Docker optimization guidance to YokaKit CLAUDE.md

**Files to Modify**:
- `YokaKit_Replay/CLAUDE.md` (or YokaKit/CLAUDE.md if applicable)

**Implementation Steps**:
1. Review PinkieIt CLAUDE.md changes:
   ```bash
   cd pinkieit
   git show b980f1e:CLAUDE.md
   ```

2. Extract Docker optimization section (lines added in b980f1e)

3. Adapt for YokaKit context:
   - Replace any "PinkieIt" → "YokaKit"
   - Update context to YokaKit_Replay workflow

4. Add to appropriate CLAUDE.md file

**Constitutional Compliance**:
- [ ] All PinkieIt references changed to YokaKit
- [ ] Context adapted for YokaKit_Replay project structure

**Validation**:
- [ ] CLAUDE.md updated with Docker optimization guidance
- [ ] No PinkieIt references in added content
- [ ] Guidance applicable to YokaKit

---

### T004: Validate CR1 implementation

**Type**: Validation
**Estimated**: 10 min
**Dependencies**: T002, T003

**Objective**: Verify CR1 files match PinkieIt with YokaKit identity

**Validation Steps**:

1. **File Existence Check**:
   ```bash
   ls -la YokaKit/.dockerignore
   wc -l YokaKit/.dockerignore  # Expected: 124
   ```

2. **Constitutional Compliance Check**:
   ```bash
   # No pinkieit references in .dockerignore (should be generic)
   grep -i "pinkieit" YokaKit/.dockerignore
   # Expected: No results
   ```

3. **Content Validation**:
   ```bash
   # Compare with PinkieIt (should match exactly for .dockerignore)
   diff <(cd pinkieit && git show b980f1e:.dockerignore) YokaKit/.dockerignore
   # Expected: No diff
   ```

4. **CLAUDE.md Validation**:
   ```bash
   grep -i "pinkieit" CLAUDE.md  # Check for missed references
   # Expected: Only in historical context (if any)
   ```

**Success Criteria**:
- [ ] .dockerignore exists with 124 lines
- [ ] No constitutional violations
- [ ] CLAUDE.md updated appropriately
- [ ] Content matches PinkieIt pattern

---

### T005: Commit CR1 with audit trail

**Type**: Git Commit
**Estimated**: 5 min
**Dependencies**: T004

**Objective**: Commit CR1 changes with PinkieIt reference

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add .dockerignore
   cd ../
   git add CLAUDE.md  # If updated in YokaKit_Replay
   ```

2. Commit with PinkieIt reference:
   ```bash
   git commit -m "$(cat <<'EOF'
   feat: add Docker build context optimization (PinkieIt: b980f1e)

   Replay of PinkieIt commit b980f1eef1c628962186f7e18012c1330a55b579
   Constitutional adaptations: None required (generic .dockerignore rules)

   Files added:
   - .dockerignore (124 lines, build context optimization)
   - CLAUDE.md updates (Docker optimization guidance)

   Phase 2 CR1
   YokaKit identity preserved ✓
   EOF
   )"
   ```

3. Verify commit:
   ```bash
   git log -1 --stat
   ```

**Validation**:
- [ ] Commit message references PinkieIt b980f1e
- [ ] Constitutional compliance noted
- [ ] Phase 2 CR1 labeled

---

## COMMIT REPLAY 2: f9340aa - Consolidate Docker architecture with multi-stage Dockerfile

**PinkieIt Commit**: `f9340aabdec7954898386f61c509ed3e6a541e4f`
**Date**: 2025-06-26 20:01:55 +0900
**Files**: 3 files (+137, -2)
**Constitutional**: **IDENTITY PRESERVATION REQUIRED** (pinkieit → yokakit adaptations)

### Story/Issue Reference
- **YokaKit Epic**: #TBD (Phase 2: Docker Architecture Optimization)
- **YokaKit Story**: #TBD (CR2: Multi-stage consolidation)

---

### T006: Analyze multi-stage consolidation commit (f9340aa)

**Type**: Preparation
**Estimated**: 30 min

**Objective**: Analyze Dockerfile consolidation and identify constitutional adaptations

**Steps**:
1. Checkout PinkieIt at commit f9340aa:
   ```bash
   cd pinkieit
   git checkout f9340aabdec7954898386f61c509ed3e6a541e4f
   git show f9340aa --stat
   ```

2. Review Dockerfile structure:
   ```bash
   git show f9340aa:Dockerfile | head -50
   ```

3. Identify PinkieIt references:
   ```bash
   git show f9340aa:Dockerfile | grep -i "pinkieit"
   git show f9340aa:compose.yml | grep -i "pinkieit"
   git show f9340aa:.devcontainer/docker-compose.extend.yml | grep -i "pinkieit"
   ```

4. Document constitutional adaptations:
   - [ ] Dockerfile line ~1: Comment "PinkieIt" → "YokaKit"
   - [ ] compose.yml: pinkieit-web-app → yokakit-web-app (image, container_name)
   - [ ] .devcontainer: pinkieit-web-app → yokakit-web-app (image reference)
   - [ ] Verify no other "pinkieit" occurrences

**Validation**:
- [ ] All 3 files analyzed
- [ ] All PinkieIt references documented
- [ ] Adaptation plan clear

---

### T007: Create multi-stage Dockerfile with YokaKit identity

**Type**: Implementation
**Estimated**: 1 hour
**Dependencies**: T006

**Objective**: Create consolidated Dockerfile with YokaKit naming

**Files to Create**:
- `YokaKit/Dockerfile` (based on PinkieIt f9340aa with adaptations)

**Implementation Steps**:
1. Extract Dockerfile from PinkieIt:
   ```bash
   cd pinkieit
   git show f9340aa:Dockerfile > /tmp/Dockerfile.pinkieit
   ```

2. Create YokaKit Dockerfile with constitutional adaptations:
   ```bash
   cd ../YokaKit
   cp /tmp/Dockerfile.pinkieit Dockerfile

   # Adapt line ~1: Comment
   sed -i 's/PinkieIt/YokaKit/g' Dockerfile
   sed -i 's/pinkieit/yokakit/g' Dockerfile
   ```

3. Manual review for accuracy:
   - Verify all stages (base, build, production) present
   - Confirm YokaKit naming throughout
   - Check for missed PinkieIt references

**Constitutional Compliance**:
- [ ] Comment line: "YokaKit" (not "PinkieIt")
- [ ] Image references: yokakit naming
- [ ] No pinkieit strings in Dockerfile

**Validation**:
- [ ] Dockerfile exists (129 lines expected)
- [ ] Multi-stage structure intact (base/build/production)
- [ ] Constitutional compliance verified

---

### T008: Rename docker-compose.yml to compose.yml

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T006

**Objective**: Follow Docker Compose v2 naming convention

**Files to Modify**:
- `YokaKit/docker-compose.yml` → `YokaKit/compose.yml`

**Implementation Steps**:
1. Review PinkieIt compose.yml changes:
   ```bash
   cd pinkieit
   git show f9340aa:compose.yml
   ```

2. Rename in YokaKit (if docker-compose.yml exists from Phase 1):
   ```bash
   cd ../YokaKit
   git mv docker-compose.yml compose.yml  # If exists
   # OR create new compose.yml if Phase 1 didn't have one
   ```

3. Apply service updates from PinkieIt f9340aa:
   - Extract relevant service changes
   - Apply with YokaKit naming adaptations

**Constitutional Compliance**:
- [ ] Services use yokakit prefix (not pinkieit)
- [ ] Image: yokakit-web-app
- [ ] Container name: yokakit-web-app

**Validation**:
- [ ] compose.yml exists (docker-compose.yml removed or renamed)
- [ ] Services reference YokaKit naming
- [ ] Docker Compose v2 compatible

---

### T009: Update compose.yml with YokaKit service names

**Type**: Implementation
**Estimated**: 30 min
**Dependencies**: T007, T008

**Objective**: Configure compose.yml with yokakit-web-app image and naming

**Files to Modify**:
- `YokaKit/compose.yml`

**Implementation Steps**:
1. Review PinkieIt compose.yml structure:
   ```bash
   cd pinkieit
   git show f9340aa:compose.yml
   ```

2. Update YokaKit compose.yml:
   ```yaml
   services:
     web-app:
       image: yokakit-web-app  # NOT pinkieit-web-app
       container_name: yokakit-web-app
       build:
         context: .
         dockerfile: Dockerfile
       # ... other configurations from PinkieIt
   ```

3. Apply other service configurations (db, mqtt) from PinkieIt if changed

**Constitutional Compliance**:
- [ ] image: yokakit-web-app (line ~X)
- [ ] container_name: yokakit-web-app (line ~Y)
- [ ] No pinkieit references

**Validation**:
- [ ] compose.yml updated
- [ ] YokaKit naming enforced
- [ ] Service structure matches PinkieIt pattern

---

### T010: Update .devcontainer configuration

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T007

**Objective**: Point devcontainer to yokakit-web-app image

**Files to Modify**:
- `YokaKit/.devcontainer/docker-compose.extend.yml`

**Implementation Steps**:
1. Review PinkieIt devcontainer changes:
   ```bash
   cd pinkieit
   git show f9340aa:.devcontainer/docker-compose.extend.yml
   ```

2. Update YokaKit devcontainer:
   ```yaml
   services:
     web-app:
       image: yokakit-web-app  # NOT pinkieit-web-app
       # ... other devcontainer configurations
   ```

**Constitutional Compliance**:
- [ ] image: yokakit-web-app
- [ ] Container name: yokakit-dev (if specified)

**Validation**:
- [ ] .devcontainer updated
- [ ] References yokakit image
- [ ] No pinkieit strings

---

### T011: Build and test multi-stage Dockerfile

**Type**: Validation
**Estimated**: 30 min
**Dependencies**: T007, T009

**Objective**: Verify multi-stage Dockerfile builds successfully

**Validation Steps**:

1. **Build Test**:
   ```bash
   cd YokaKit
   docker build -t yokakit-web-app .
   ```
   - [ ] Build succeeds without errors
   - [ ] All stages execute (base, build, production)

2. **Image Inspection**:
   ```bash
   docker images | grep yokakit-web-app
   docker inspect yokakit-web-app | grep -i "pinkieit"
   # Expected: No pinkieit references
   ```

3. **Service Startup Test**:
   ```bash
   docker compose up -d
   docker compose ps
   ```
   - [ ] All 3 services start (web-app, db, mqtt)
   - [ ] Containers named with yokakit prefix

4. **Constitutional Compliance**:
   ```bash
   docker compose config | grep -i "pinkieit"
   # Expected: No results
   ```

**Success Criteria**:
- [ ] Docker build completes
- [ ] Services operational
- [ ] No PinkieIt references in runtime
- [ ] YokaKit identity preserved

---

### T012: Validate CR2 constitutional compliance

**Type**: Validation
**Estimated**: 15 min
**Dependencies**: T011

**Objective**: Comprehensive constitutional compliance check for CR2

**Validation Steps**:

1. **File-Level Check**:
   ```bash
   cd YokaKit
   grep -ri "pinkieit" Dockerfile compose.yml .devcontainer/
   # Expected: No results
   ```

2. **Repository-Wide Check**:
   ```bash
   grep -ri "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules --exclude-dir=.git
   # Expected: No results
   ```

3. **Docker Resource Check**:
   ```bash
   docker compose ps --format "{{.Name}}"
   # Expected: All names contain "yokakit"

   docker images | grep web-app
   # Expected: yokakit-web-app (not pinkieit)
   ```

4. **File Structure Validation**:
   - [ ] Dockerfile exists (129 lines)
   - [ ] compose.yml exists (docker-compose.yml removed)
   - [ ] .devcontainer updated
   - [ ] docker/base and docker/app deprecated (if consolidation complete)

**Success Criteria**:
- [ ] Zero pinkieit references
- [ ] All Docker resources use yokakit naming
- [ ] Multi-stage consolidation complete
- [ ] Identity preservation: 100%

---

### T013: Commit CR2 with constitutional adaptations

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T012

**Objective**: Commit CR2 with audit trail and adaptation notes

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add Dockerfile compose.yml .devcontainer/
   git rm docker-compose.yml  # If renamed
   ```

2. Commit with detailed adaptations:
   ```bash
   git commit -m "$(cat <<'EOF'
   feat: consolidate Docker with multi-stage Dockerfile (PinkieIt: f9340aa)

   Replay of PinkieIt commit f9340aabdec7954898386f61c509ed3e6a541e4f
   Constitutional adaptations applied:
   - Dockerfile comment: "PinkieIt" → "YokaKit"
   - Image name: pinkieit-web-app → yokakit-web-app
   - Container names: pinkieit-* → yokakit-*
   - Service identity: YokaKit naming enforced

   Files added/modified:
   - Dockerfile (129 lines, multi-stage: base/build/production)
   - docker-compose.yml → compose.yml (Docker Compose v2)
   - .devcontainer/docker-compose.extend.yml (yokakit image reference)

   Consolidates docker/base + docker/app into single Dockerfile
   Follows Docker Compose v2 conventions (compose.yml)

   Phase 2 CR2
   YokaKit identity preserved ✓
   Constitutional compliance: 100%
   EOF
   )"
   ```

3. Verify commit:
   ```bash
   git log -1 --stat
   ```

**Validation**:
- [ ] Commit references PinkieIt f9340aa
- [ ] Constitutional adaptations documented
- [ ] All file changes listed

---

## COMMIT REPLAY 3: fe2acac - Optimize Dockerfile with build stage separation and cache mounts

**PinkieIt Commit**: `fe2acacf56d1cac8f0962d13b0cc3491d955965d`
**Date**: 2025-06-26 21:31:49 +0900
**Files**: 2 files (+90, -78)
**Constitutional**: Maintain YokaKit naming (no new PinkieIt references)

### Story/Issue Reference
- **YokaKit Epic**: #TBD (Phase 2: Docker Architecture Optimization)
- **YokaKit Story**: #TBD (CR3: BuildKit optimization)

---

### T014: Analyze BuildKit cache optimization (fe2acac)

**Type**: Preparation
**Estimated**: 20 min

**Objective**: Understand BuildKit cache mount strategy

**Steps**:
1. Checkout PinkieIt at commit fe2acac:
   ```bash
   cd pinkieit
   git checkout fe2acacf56d1cac8f0962d13b0cc3491d955965d
   git show fe2acac --stat
   ```

2. Review Dockerfile changes:
   ```bash
   git diff f9340aa..fe2acac -- Dockerfile
   ```

3. Identify new patterns:
   - [ ] BuildKit cache mounts (--mount=type=cache)
   - [ ] Separated composer-deps stage
   - [ ] Separated npm-deps stage
   - [ ] Development vs production targets

4. Document BuildKit requirement:
   - [ ] DOCKER_BUILDKIT=1 environment variable needed

**Validation**:
- [ ] Dockerfile diff analyzed
- [ ] BuildKit features identified
- [ ] No new PinkieIt references found

---

### T015: Implement BuildKit cache mounts in Dockerfile

**Type**: Implementation
**Estimated**: 1 hour
**Dependencies**: T014

**Objective**: Add BuildKit cache optimization to YokaKit Dockerfile

**Files to Modify**:
- `YokaKit/Dockerfile`

**Implementation Steps**:
1. Review PinkieIt fe2acac Dockerfile:
   ```bash
   cd pinkieit
   git show fe2acac:Dockerfile > /tmp/Dockerfile.fe2acac
   ```

2. Apply changes to YokaKit Dockerfile:
   - Add composer-deps stage with cache mount:
     ```dockerfile
     FROM base AS composer-deps
     RUN --mount=type=cache,target=/root/.composer/cache \
         composer install --no-dev
     ```
   - Add npm-deps stage with cache mount:
     ```dockerfile
     FROM base AS npm-deps
     RUN --mount=type=cache,target=/root/.npm \
         npm install --production
     ```
   - Add development and production targets
   - Maintain YokaKit naming from CR2

3. Verify all changes from PinkieIt fe2acac applied:
   ```bash
   diff /tmp/Dockerfile.fe2acac YokaKit/Dockerfile | grep -v "pinkieit\|yokakit"
   # Should show minimal differences (only naming)
   ```

**Constitutional Compliance**:
- [ ] No new pinkieit references introduced
- [ ] Maintains yokakit naming from CR2

**Validation**:
- [ ] Dockerfile updated (166 lines expected)
- [ ] BuildKit cache mounts present
- [ ] Development/production targets defined

---

### T016: Update ProductionLineFactory (if applicable)

**Type**: Implementation
**Estimated**: 10 min
**Dependencies**: T014

**Objective**: Apply minor factory fix from fe2acac (if relevant to YokaKit)

**Files to Modify**:
- `YokaKit/app/laravel/database/factories/ProductionLineFactory.php` (if exists)

**Implementation Steps**:
1. Check if file exists in YokaKit:
   ```bash
   ls -la YokaKit/app/laravel/database/factories/ProductionLineFactory.php
   ```

2. If exists, review PinkieIt change:
   ```bash
   cd pinkieit
   git show fe2acac:app/laravel/database/factories/ProductionLineFactory.php
   ```

3. Apply change (if applicable):
   - Review diff: `git diff f9340aa..fe2acac -- app/laravel/database/factories/ProductionLineFactory.php`
   - Apply to YokaKit if relevant

**Note**: This file may not exist in YokaKit or may be irrelevant. Skip if not applicable.

**Validation**:
- [ ] File checked
- [ ] Change applied or skipped (with reason)

---

### T017: Test BuildKit cache performance

**Type**: Validation
**Estimated**: 30 min
**Dependencies**: T015

**Objective**: Verify BuildKit cache mounts accelerate builds

**Validation Steps**:

1. **Enable BuildKit**:
   ```bash
   export DOCKER_BUILDKIT=1
   ```

2. **First Build (cold cache)**:
   ```bash
   cd YokaKit
   time docker build -t yokakit-web-app .
   # Record build time
   ```

3. **Second Build (warm cache)**:
   ```bash
   time docker build -t yokakit-web-app .
   # Record build time - should be significantly faster
   ```

4. **Cache Validation**:
   - [ ] Second build faster than first
   - [ ] Composer dependencies cached (no re-download)
   - [ ] NPM dependencies cached (no re-download)

5. **Functional Validation**:
   ```bash
   docker compose up -d
   docker compose ps
   # Verify services still operational
   ```

**Success Criteria**:
- [ ] BuildKit build succeeds
- [ ] Cache mounts improve performance
- [ ] Services functional
- [ ] No PinkieIt references

---

### T018: Validate CR3 implementation

**Type**: Validation
**Estimated**: 15 min
**Dependencies**: T017

**Objective**: Verify BuildKit optimization complete

**Validation Steps**:

1. **Dockerfile Structure Check**:
   ```bash
   grep "RUN --mount=type=cache" YokaKit/Dockerfile
   # Expected: 2 occurrences (composer, npm)
   ```

2. **Constitutional Compliance**:
   ```bash
   grep -i "pinkieit" YokaKit/Dockerfile
   # Expected: No results (maintains YokaKit naming from CR2)
   ```

3. **Build Validation**:
   ```bash
   DOCKER_BUILDKIT=1 docker build --target development -t yokakit-web-app:dev .
   DOCKER_BUILDKIT=1 docker build --target production -t yokakit-web-app:prod .
   # Both targets should build successfully
   ```

4. **Service Startup**:
   ```bash
   docker compose up -d
   docker compose ps | grep "Up"
   # All services healthy
   ```

**Success Criteria**:
- [ ] BuildKit features present
- [ ] Development and production targets work
- [ ] Cache mounts functional
- [ ] YokaKit identity maintained

---

### T019: Commit CR3 with BuildKit optimization

**Type**: Git Commit
**Estimated**: 5 min
**Dependencies**: T018

**Objective**: Commit BuildKit changes with audit trail

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add Dockerfile
   # Add ProductionLineFactory.php if modified
   ```

2. Commit:
   ```bash
   git commit -m "$(cat <<'EOF'
   feat: optimize Dockerfile with BuildKit cache mounts (PinkieIt: fe2acac)

   Replay of PinkieIt commit fe2acacf56d1cac8f0962d13b0cc3491d955965d
   Constitutional adaptations: None (maintains YokaKit naming from CR2)

   Files modified:
   - Dockerfile (166 lines, BuildKit cache optimization)
     - Added composer-deps stage with cache mount
     - Added npm-deps stage with cache mount
     - Separated development and production targets
   - ProductionLineFactory.php (minor fix, if applicable)

   BuildKit cache mounts significantly reduce rebuild time
   Requires DOCKER_BUILDKIT=1 environment variable

   Phase 2 CR3
   YokaKit identity preserved ✓
   EOF
   )"
   ```

3. Verify:
   ```bash
   git log -1 --stat
   ```

**Validation**:
- [ ] Commit references fe2acac
- [ ] BuildKit requirement documented
- [ ] YokaKit identity noted

---

## COMMIT REPLAY 4: 08ac389 - Complete Docker optimization with multi-stage consolidation

**PinkieIt Commit**: `08ac3897e478078d254e1ca54c8f244216d1862b`
**Date**: 2025-06-26 21:55:57 +0900
**Files**: 2 files (+37, -63)
**Constitutional**: Maintain YokaKit naming

### Story/Issue Reference
- **YokaKit Epic**: #TBD (Phase 2: Docker Architecture Optimization)
- **YokaKit Story**: #TBD (CR4: Final consolidation)

---

### T020: Analyze final Dockerfile consolidation (08ac389)

**Type**: Preparation
**Estimated**: 15 min

**Objective**: Understand stage simplification strategy

**Steps**:
1. Checkout PinkieIt at commit 08ac389:
   ```bash
   cd pinkieit
   git checkout 08ac3897e478078d254e1ca54c8f244216d1862b
   git show 08ac389 --stat
   ```

2. Review Dockerfile simplifications:
   ```bash
   git diff fe2acac..08ac389 -- Dockerfile
   ```

3. Identify changes:
   - [ ] Merged composer-deps + npm-deps into unified build stage
   - [ ] Removed redundant stages
   - [ ] Optimized layer ordering
   - [ ] Final line count: 96 (reduced from 166)

4. Review compose.yml changes:
   ```bash
   git diff fe2acac..08ac389 -- compose.yml
   ```

**Validation**:
- [ ] Dockerfile diff analyzed
- [ ] Simplification strategy clear
- [ ] No new PinkieIt references

---

### T021: Simplify Dockerfile stages

**Type**: Implementation
**Estimated**: 45 min
**Dependencies**: T020

**Objective**: Consolidate redundant stages and optimize layers

**Files to Modify**:
- `YokaKit/Dockerfile`

**Implementation Steps**:
1. Review PinkieIt final Dockerfile:
   ```bash
   cd pinkieit
   git show 08ac389:Dockerfile > /tmp/Dockerfile.08ac389
   ```

2. Apply simplifications to YokaKit Dockerfile:
   - Merge composer-deps + npm-deps → unified build stage
   - Remove intermediate stages
   - Optimize COPY layer ordering (dependencies before code)
   - Maintain YokaKit naming

3. Verify final structure:
   ```bash
   wc -l YokaKit/Dockerfile  # Expected: 96 lines
   grep -i "pinkieit" YokaKit/Dockerfile  # Expected: No results
   ```

**Constitutional Compliance**:
- [ ] Maintains yokakit naming from CR2
- [ ] No new pinkieit references

**Validation**:
- [ ] Dockerfile reduced to 96 lines
- [ ] Stage consolidation complete
- [ ] YokaKit identity preserved

---

### T022: Update compose.yml for final structure

**Type**: Implementation
**Estimated**: 10 min
**Dependencies**: T020

**Objective**: Align compose.yml with simplified Dockerfile

**Files to Modify**:
- `YokaKit/compose.yml`

**Implementation Steps**:
1. Review PinkieIt compose.yml changes:
   ```bash
   cd pinkieit
   git diff fe2acac..08ac389 -- compose.yml
   ```

2. Apply to YokaKit compose.yml:
   - Update service configurations
   - Maintain yokakit naming

**Validation**:
- [ ] compose.yml updated
- [ ] YokaKit naming maintained

---

### T023: Validate final Docker optimization

**Type**: Validation
**Estimated**: 30 min
**Dependencies**: T021, T022

**Objective**: Verify final Docker architecture is production-ready

**Validation Steps**:

1. **Build Test**:
   ```bash
   cd YokaKit
   DOCKER_BUILDKIT=1 docker build -t yokakit-web-app .
   ```
   - [ ] Build succeeds
   - [ ] Fewer stages than CR3
   - [ ] Build time comparable or better

2. **Image Size Check**:
   ```bash
   docker images yokakit-web-app
   # Verify image size not significantly increased from CR3
   ```

3. **Service Functionality**:
   ```bash
   docker compose down
   docker compose up -d
   docker compose ps
   docker compose logs web-app | head -20
   ```
   - [ ] All services start successfully
   - [ ] No errors in logs
   - [ ] Application accessible

4. **Constitutional Compliance**:
   ```bash
   grep -ri "pinkieit" YokaKit/Dockerfile YokaKit/compose.yml
   # Expected: No results
   ```

5. **Structural Validation**:
   ```bash
   wc -l YokaKit/Dockerfile  # Expected: 96
   docker buildx imagetools inspect yokakit-web-app | grep -i "pinkieit"
   # Expected: No pinkieit references
   ```

**Success Criteria**:
- [ ] Dockerfile 96 lines (simplified from 166)
- [ ] Build succeeds with fewer stages
- [ ] Services fully functional
- [ ] Image size optimized
- [ ] Zero constitutional violations

---

### T024: Commit CR4 and complete Phase 2

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T023

**Objective**: Final commit for Phase 2 Docker optimization

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add Dockerfile compose.yml
   ```

2. Commit:
   ```bash
   git commit -m "$(cat <<'EOF'
   feat: complete Docker optimization with stage consolidation (PinkieIt: 08ac389)

   Replay of PinkieIt commit 08ac3897e478078d254e1ca54c8f244216d1862b
   Constitutional adaptations: None (maintains YokaKit naming)

   Files modified:
   - Dockerfile (96 lines, simplified from 166)
     - Merged composer-deps + npm-deps into unified build stage
     - Removed redundant intermediate stages
     - Optimized layer ordering for better caching
   - compose.yml (service configuration alignment)

   Final Docker architecture:
   - Multi-stage build (base → build → production)
   - BuildKit cache optimization
   - Production-ready image size
   - Optimized for rebuild performance

   Phase 2 CR4 COMPLETE
   YokaKit identity preserved ✓
   Constitutional compliance: 100%

   Phase 2 Docker Architecture Optimization: ✅ Complete
   - CR1: .dockerignore foundation
   - CR2: Multi-stage consolidation
   - CR3: BuildKit cache optimization
   - CR4: Final consolidation

   4 PinkieIt commits replayed successfully
   All files use YokaKit naming
   Zero constitutional violations
   EOF
   )"
   ```

3. Verify:
   ```bash
   git log -1 --stat
   git log --oneline | head -4  # Should show CR1-CR4
   ```

4. Tag Phase 2 completion (optional):
   ```bash
   git tag -a phase-2-complete -m "Phase 2: Docker Architecture Optimization complete"
   ```

**Validation**:
- [ ] Commit references 08ac389
- [ ] Phase 2 completion documented
- [ ] All 4 CRs referenced in commit message
- [ ] Constitutional compliance confirmed

---

## Task Execution Strategy

### Sequential Execution (Required)

Execute tasks in strict order (T001 → T002 → ... → T024):

**Rationale**: Each CR depends on the previous (b980f1e → f9340aa → fe2acac → 08ac389). Cannot parallelize.

```bash
# CR1: Foundation (T001-T005)
# → CR2: Consolidation (T006-T013)
# → CR3: Optimization (T014-T019)
# → CR4: Finalization (T020-T024)
```

**Advantage**: Clear audit trail, easier debugging, constitutional compliance verification at each CR

### BuildKit Requirement

**CRITICAL**: Tasks T015-T024 require Docker BuildKit enabled:

```bash
export DOCKER_BUILDKIT=1
# OR
echo 'export DOCKER_BUILDKIT=1' >> ~/.bashrc
```

**Validation**:
```bash
docker buildx version  # Ensure BuildKit available
```

---

## GitHub Issue Management

### Issue Creation Pattern

**Epic** (create once for Phase 2):
```bash
gh issue create --repo {org}/YokaKit \
  --title "[EPIC] Phase 2: Docker Architecture Optimization" \
  --label "epic:phase-2,constitutional:identity-preservation" \
  --milestone "Phase 2" \
  --body "4 PinkieIt commits (b980f1e..08ac389) → 4 Commit Replays → 24 tasks"
```

**Stories** (one per CR):
- CR1: `[Story] CR1: Docker baseline (.dockerignore)`
- CR2: `[Story] CR2: Multi-stage consolidation`
- CR3: `[Story] CR3: BuildKit cache optimization`
- CR4: `[Story] CR4: Final Dockerfile consolidation`

**Labels**: `story:phase-2`, `constitutional:identity-preservation`

### Issue Lifecycle

1. **Create**: After T005, T013, T019, T024 (each CR commit)
2. **Track**: Update with validation results
3. **Close**: When CR validation passes + merged to main

---

## Progress Tracking

### Commit Replay Checklist

- [ ] **CR1** (b980f1e): Docker baseline (T001-T005)
- [ ] **CR2** (f9340aa): Multi-stage consolidation (T006-T013)
- [ ] **CR3** (fe2acac): BuildKit optimization (T014-T019)
- [ ] **CR4** (08ac389): Final consolidation (T020-T024)

### Constitutional Compliance Checklist

- [ ] Zero pinkieit references in codebase
- [ ] YokaKit identity preserved in all configs
- [ ] All commits reference PinkieIt hashes (b980f1e, f9340aa, fe2acac, 08ac389)
- [ ] GitHub Issues track all 4 CRs

### Phase Completion Criteria

- [ ] All 4 commits replayed
- [ ] All 24 tasks completed
- [ ] Constitutional compliance: 100%
- [ ] Docker build succeeds with BuildKit
- [ ] All services (web-app, db, mqtt) operational
- [ ] Image size optimized
- [ ] Build cache functional

---

## Next Steps

1. **Execute Tasks**: Start with T001 (CR1 Analysis)
2. **Validate Continuously**: Check constitutional compliance after each CR (T005, T013, T019, T024)
3. **Track Progress**: Update this checklist and GitHub Issues
4. **Complete Phase**: After T024, update YokaKit_Replay submodule reference

---

**Created**: 2025-10-03
**PinkieIt Reference**: b980f1e..08ac389
**Total Tasks**: 24 (5 + 8 + 6 + 5)
**Estimated Duration**: 4-6 hours (based on PinkieIt 2h8m + validation overhead)
**BuildKit Required**: Yes (T015-T024)
**Constitutional Skips**: 0
**Identity Preservation**: 100% (pinkieit → yokakit adaptations in CR2)
