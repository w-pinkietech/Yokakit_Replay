# Docker Build Workflow Contract

**Source**: PinkieIt commit 6bb70e1 (2025-07-04)
**Target**: YokaKit `.github/workflows/docker-build.yml`

## Workflow Configuration

### Triggers

**PinkieIt Reference** (commit 6bb70e1):
```yaml
on:
  workflow_dispatch:
    inputs:
      push_to_registry:
        description: 'Push images to registry'
        required: true
        default: 'false'
        type: choice
        options:
          - 'true'
          - 'false'
      environment:
        description: 'Build environment'
        required: true
        default: 'production'
        type: choice
        options:
          - 'production'
          - 'development'
  push:
    branches: [ main ]
    paths:
      - 'Dockerfile'
      - 'app/laravel/**'
      - 'config/**'
      - '.env'
      - 'compose.yml'
  pull_request:
    branches: [ main ]
    paths:
      - 'Dockerfile'
      - 'app/laravel/**'
      - 'config/**'
      - '.env'
      - 'compose.yml'
```

**YokaKit Contract**:
```yaml
# Identical configuration - no adaptations needed
# Path patterns match YokaKit structure (app/laravel exists from Phase 1)
```

**Adaptations**:
- None required (path patterns are YokaKit-compatible)

---

## Environment Variables

**PinkieIt Reference** (commit 6bb70e1):
```yaml
env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}  # Resolves to w-pinkietech/pinkieit
```

**YokaKit Contract**:
```yaml
env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}  # Resolves to w-pinkietech/YokaKit
```

**Adaptations**:
- IMAGE_NAME automatically adapts via GitHub context variable
- No manual naming changes required

---

## Build Job Matrix

**PinkieIt Reference** (commit 6bb70e1):
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    strategy:
      matrix:
        environment: [production, development]
```

**YokaKit Contract**:
```yaml
# Identical configuration
jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    strategy:
      matrix:
        environment: [production, development]
```

**Adaptations**:
- None required (generic configuration)

---

## Build Steps

### Step 1: Checkout

**Contract**:
```yaml
- name: Checkout repository
  uses: actions/checkout@v4
```

**Validation**:
- [ ] Checkout action version is v4 or higher
- [ ] Full repository history available for builds

---

### Step 2: Docker Buildx Setup

**Contract**:
```yaml
- name: Set up Docker Buildx
  uses: docker/setup-buildx-action@v3
  with:
    platforms: linux/amd64,linux/arm64
```

**Validation**:
- [ ] Buildx action version is v3
- [ ] Platforms include both linux/amd64 and linux/arm64
- [ ] Multi-platform build support enabled

---

### Step 3: Registry Login

**Contract**:
```yaml
- name: Log in to Container Registry
  if: github.event_name != 'pull_request'
  uses: docker/login-action@v3
  with:
    registry: ${{ env.REGISTRY }}
    username: ${{ github.actor }}
    password: ${{ secrets.GITHUB_TOKEN }}
```

**Validation**:
- [ ] Login skipped for pull requests (build-only validation)
- [ ] GITHUB_TOKEN has packages:write permission
- [ ] Registry is ghcr.io

---

### Step 4: Metadata Extraction

**Contract**:
```yaml
- name: Extract metadata
  id: meta
  uses: docker/metadata-action@v5
  with:
    images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
    tags: |
      type=ref,event=branch,suffix=-${{ matrix.environment }}
      type=ref,event=pr,suffix=-${{ matrix.environment }}
      type=raw,value=latest-${{ matrix.environment }},enable={{is_default_branch}}
      type=sha,prefix={{branch}}-${{ matrix.environment }}-,format=short
```

**Validation**:
- [ ] Metadata action version is v5
- [ ] Tags include environment suffix (-production, -development)
- [ ] Latest tag only on default branch (main)
- [ ] SHA tags include branch name and environment

---

### Step 5: Build and Push

**Contract**:
```yaml
- name: Build and push Docker image
  uses: docker/build-push-action@v5
  with:
    context: .
    file: ./Dockerfile
    platforms: linux/amd64,linux/arm64
    target: ${{ matrix.environment }}
    push: ${{ github.event_name != 'pull_request' && (github.event.inputs.push_to_registry == 'true' || github.ref == 'refs/heads/main') }}
    tags: ${{ steps.meta.outputs.tags }}
    labels: ${{ steps.meta.outputs.labels }}
    cache-from: type=gha,scope=${{ matrix.environment }}
    cache-to: type=gha,mode=max,scope=${{ matrix.environment }}
    build-args: |
      ENVIRONMENT=${{ matrix.environment }}
```

**Validation**:
- [ ] Build action version is v5
- [ ] Platforms match Phase 5 multi-architecture support
- [ ] Target matches matrix.environment (production or development)
- [ ] Push logic: Skip on PRs, require manual approval or main branch
- [ ] Cache scoped by environment to prevent conflicts
- [ ] Cache mode is "max" for aggressive layer caching

---

## Test Job

**Contract**:
```yaml
test:
  runs-on: ubuntu-latest
  needs: build
  if: github.event_name == 'pull_request'

  steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Run tests
      run: |
        # Test Docker image functionality
        docker compose -f compose.yml up -d
        docker compose exec -T yokakit-dev php artisan test
```

**Validation**:
- [ ] Test job only runs on pull requests
- [ ] Depends on successful build job
- [ ] Uses compose.yml from repository
- [ ] Runs full test suite (425 tests from Phase 3)

---

## Adaptations Summary

**YokaKit-Specific Changes**:
- ✅ IMAGE_NAME uses ${{ github.repository }} (automatic YokaKit naming)
- ✅ No hardcoded "pinkieit" references
- ✅ Path patterns match YokaKit structure (app/laravel from Phase 1)
- ✅ Dockerfile targets match Phase 5 (production, development)

**Validation Checklist**:
- [ ] Workflow triggers on main push, PR, and manual dispatch
- [ ] Matrix builds both production and development
- [ ] Multi-architecture builds for AMD64 and ARM64
- [ ] GitHub Actions cache scoped by environment
- [ ] Registry push conditional (PRs build only, main pushes)
- [ ] GITHUB_TOKEN has packages:write permission
- [ ] Test job runs on PRs after successful build

---

**Created**: 2025-10-04
**Based on**: PinkieIt commit 6bb70e13a520e2acf59905708446083d4ccf9f8e
