# Phase 6: CI/CD Pipeline & Multi-Architecture Publishing - Quickstart Guide

## Prerequisites

**From PinkieIt Commit 6bb70e1**:
- GitHub repository with Actions enabled
- GitHub Container Registry (ghcr.io) access
- GITHUB_TOKEN with packages:write permission
- Docker Buildx support (from Phase 5)
- Multi-architecture Dockerfile (from Phase 5)

**YokaKit Environment**:
- Completed Phase 5 (Multi-Architecture Docker Support)
- YokaKit repository at w-pinkietech/YokaKit
- GitHub Actions workflows directory (.github/workflows/)
- 425 tests passing (baseline for PR validation)

**System Requirements**:
- GitHub account with repository admin access
- gh CLI installed (for manual workflow testing)
- Docker installed locally (for image pull testing)

---

## 15-Minute Setup

### Step 1: Verify Prerequisites (2 min)

```bash
# Check gh CLI installed
gh --version
# Expected: gh version 2.0.0 or higher

# Check repository access
gh repo view w-pinkietech/YokaKit
# Expected: Repository details displayed

# Check GitHub Actions enabled
gh api repos/w-pinkietech/YokaKit/actions/permissions
# Expected: {"enabled": true}

# Check Docker Buildx (from Phase 5)
docker buildx version
# Expected: github.com/docker/buildx v0.26.0 or higher
```

---

### Step 2: Checkout Phase 6 Branch (1 min)

**In YokaKit** (for implementation):
```bash
cd /path/to/YokaKit
git checkout -b feature/phase-6-cicd
```

---

### Step 3: Create docker-build.yml Workflow (3 min)

**Based on**: PinkieIt commit 6bb70e1

**File**: `YokaKit/.github/workflows/docker-build.yml`

```bash
# Create workflows directory if not exists
mkdir -p .github/workflows

# Extract workflow from PinkieIt commit (for reference)
cd /path/to/YokaKit_Replay
git -C pinkieit show 6bb70e1:.github/workflows/docker-build.yml > /tmp/docker-build-ref.yml

# Copy to YokaKit (no adaptations needed - uses ${{ github.repository }})
cd /path/to/YokaKit
cp /tmp/docker-build-ref.yml .github/workflows/docker-build.yml
```

**Key Configuration** (verify):
- ✅ IMAGE_NAME uses `${{ github.repository }}` (auto-resolves to w-pinkietech/YokaKit)
- ✅ Platforms: linux/amd64, linux/arm64
- ✅ Matrix: [production, development]
- ✅ Cache scoped by environment

---

### Step 4: Create docker-publish.yml Workflow (2 min)

**Based on**: PinkieIt commit 6bb70e1

**File**: `YokaKit/.github/workflows/docker-publish.yml`

```bash
# Extract from PinkieIt
cd /path/to/YokaKit_Replay
git -C pinkieit show 6bb70e1:.github/workflows/docker-publish.yml > /tmp/docker-publish-ref.yml

# Copy to YokaKit
cd /path/to/YokaKit
cp /tmp/docker-publish-ref.yml .github/workflows/docker-publish.yml
```

**Key Configuration** (verify):
- ✅ IMAGE_NAME uses `${{ github.repository }}`
- ✅ Triggers: workflow_dispatch, push to main, version tags (v*)
- ✅ Environment selection: production / development / both

---

### Step 5: Create cache-cleanup.yml Workflow (2 min)

**Based on**: PinkieIt commit 6bb70e1

**File**: `YokaKit/.github/workflows/cache-cleanup.yml`

```bash
# Extract from PinkieIt
cd /path/to/YokaKit_Replay
git -C pinkieit show 6bb70e1:.github/workflows/cache-cleanup.yml > /tmp/cache-cleanup-ref.yml

# Copy to YokaKit
cd /path/to/YokaKit
cp /tmp/cache-cleanup-ref.yml .github/workflows/cache-cleanup.yml
```

**Key Configuration** (verify):
- ✅ Schedule: Weekly on Sundays at 2 AM UTC (cron: '0 2 * * 0')
- ✅ Deletes caches older than 7 days
- ✅ Uses ${{ github.repository }} for automatic YokaKit reference

---

### Step 6: Test Workflows Locally (5 min)

**Validate Workflow Syntax**:
```bash
cd /path/to/YokaKit

# Check docker-build.yml syntax
gh workflow view docker-build.yml
# Expected: Workflow details displayed without errors

# Check docker-publish.yml syntax
gh workflow view docker-publish.yml
# Expected: Workflow details displayed

# Check cache-cleanup.yml syntax
gh workflow view cache-cleanup.yml
# Expected: Workflow details displayed
```

**Manual Workflow Dispatch** (after push):
```bash
# Push workflows to repository
git add .github/workflows/
git commit -m "feat: add CI/CD workflows (PinkieIt commit: 6bb70e1)"
git push origin feature/phase-6-cicd

# Create PR or push to main to enable workflows
gh pr create --title "Phase 6: CI/CD Pipeline Integration" --body "Add GitHub Actions workflows for multi-architecture Docker builds, registry publishing, and cache cleanup"

# After PR merge, test docker-build workflow
gh workflow run docker-build.yml --ref main \
  -f push_to_registry=false \
  -f environment=production

# Check workflow run status
gh run list --workflow=docker-build.yml --limit 1
# Expected: Status "completed" with conclusion "success"
```

---

### Step 7: Validation (2 min)

#### Constitutional Compliance

```bash
# Verify YokaKit identity preserved (no pinkieit references in workflows)
cd /path/to/YokaKit
grep -ri "pinkieit" .github/workflows/
# Expected: No results (all should use ${{ github.repository }} context variable)
```

#### Workflow Health

```bash
# Check all workflows enabled
gh api repos/w-pinkietech/YokaKit/actions/workflows \
  --jq '.workflows[] | select(.path | contains("docker")) | {name, state, path}'
# Expected: All workflows with state "active"

# Check recent workflow runs
gh run list --limit 5
# Expected: Recent runs displayed with status
```

#### Registry Publishing

```bash
# After successful docker-build workflow run with push_to_registry=true
docker pull ghcr.io/w-pinkietech/yokakit:latest-production
# Expected: Image pulled successfully

# Inspect multi-architecture manifest
docker buildx imagetools inspect ghcr.io/w-pinkietech/yokakit:latest-production
# Expected: MediaType: application/vnd.docker.distribution.manifest.list.v2+json
#           Platforms: linux/amd64, linux/arm64
```

#### Cache Management

```bash
# Check GitHub Actions cache usage
gh api repos/w-pinkietech/YokaKit/actions/caches --jq '.total_count'
# Expected: Number of active caches

# Manually trigger cache cleanup
gh workflow run cache-cleanup.yml

# Check cleanup results
gh run list --workflow=cache-cleanup.yml --limit 1
# Expected: Workflow completed successfully
```

---

## Troubleshooting

### Issue 1: GITHUB_TOKEN lacks packages:write permission
**Symptom**: `docker/login-action@v3` fails with 403 Forbidden

**Solution**:
```bash
# Verify workflow permissions in docker-build.yml
grep -A 5 "permissions:" .github/workflows/docker-build.yml
# Expected:
# permissions:
#   contents: read
#   packages: write

# Ensure repository settings allow GitHub Actions to write packages
# Settings > Actions > General > Workflow permissions: "Read and write permissions"
```

### Issue 2: Multi-architecture build timeout
**Symptom**: ARM64 build exceeds time limit

**Solution**:
- Default GitHub Actions timeout is 360 minutes (sufficient)
- If issues persist, add explicit timeout to job:
```yaml
jobs:
  build:
    timeout-minutes: 60  # Increase if needed
```

### Issue 3: Cache quota exceeded
**Symptom**: Cache writes fail with storage limit error

**Solution**:
```bash
# Manually run cache cleanup
gh workflow run cache-cleanup.yml

# Check cache usage after cleanup
gh api repos/w-pinkietech/YokaKit/actions/caches \
  --jq '.actions_caches | map(.size_in_bytes) | add / 1024 / 1024 | floor'
# Expected: Total size in MB (GitHub limit: 10GB per repository)
```

### Issue 4: Workflow not triggering on push
**Symptom**: Push to main doesn't trigger docker-build.yml

**Solution**:
```bash
# Verify workflow file paths in trigger conditions
grep -A 10 "push:" .github/workflows/docker-build.yml
# Expected paths:
#   - 'Dockerfile'
#   - 'app/laravel/**'
#   - 'config/**'
#   - '.env'
#   - 'compose.yml'

# Ensure pushed files match trigger paths
git diff --name-only HEAD~1..HEAD
# Should include at least one path from workflow trigger
```

### Issue 5: Container registry authentication fails
**Symptom**: `docker pull ghcr.io/w-pinkietech/yokakit` fails with 401 Unauthorized

**Solution**:
```bash
# Authenticate with GitHub Container Registry
echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin

# Or use gh CLI authentication
gh auth token | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin

# Pull image
docker pull ghcr.io/w-pinkietech/yokakit:latest-production
```

---

## Next Steps

1. **Update CLAUDE.md**: Add Phase 6 CI/CD pipeline documentation (in YokaKit_Replay root)
2. **Test PR Workflow**: Create test PR to validate build-only behavior (no registry push)
3. **Test Version Tag**: Create version tag (v1.0.0) to test automated production publishing
4. **Monitor Cache Usage**: Schedule weekly review of cache-cleanup.yml results

---

## Quick Reference Commands

```bash
# Manual workflow dispatch (build without push)
gh workflow run docker-build.yml --ref main \
  -f push_to_registry=false \
  -f environment=production

# Manual workflow dispatch (build and push production)
gh workflow run docker-publish.yml --ref main \
  -f environment=production

# Manual workflow dispatch (build and push both environments)
gh workflow run docker-publish.yml --ref main \
  -f environment=both

# Check workflow run status
gh run list --workflow=docker-build.yml --limit 5

# View workflow run logs
gh run view <run_id> --log

# Trigger cache cleanup
gh workflow run cache-cleanup.yml

# Check cache usage
gh api repos/w-pinkietech/YokaKit/actions/caches --jq '.total_count'

# Pull multi-architecture image
docker pull ghcr.io/w-pinkietech/yokakit:latest-production

# Inspect image manifest
docker buildx imagetools inspect ghcr.io/w-pinkietech/yokakit:latest-production

# Constitutional compliance check
grep -ri "pinkieit" .github/workflows/
# Expected: No results
```

---

**Total Setup Time**: 15 minutes
**Validation Time**: 2 minutes
**Total Phase 6 Quickstart**: 17 minutes

**Created**: 2025-10-04
**Based on**: PinkieIt commit 6bb70e13a520e2acf59905708446083d4ccf9f8e
**Status**: Ready for implementation ✅
