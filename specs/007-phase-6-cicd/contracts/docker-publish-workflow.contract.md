# Docker Publish Workflow Contract

**Source**: PinkieIt commit 6bb70e1 (2025-07-04)
**Target**: YokaKit `.github/workflows/docker-publish.yml`

## Workflow Configuration

### Triggers

**PinkieIt Reference** (commit 6bb70e1):
```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to build'
        required: true
        default: 'production'
        type: choice
        options:
          - 'production'
          - 'development'
          - 'both'
  push:
    branches: [ main ]
    tags: [ 'v*' ]
```

**YokaKit Contract**:
```yaml
# Identical configuration
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to build'
        required: true
        default: 'production'
        type: choice
        options:
          - 'production'
          - 'development'
          - 'both'
  push:
    branches: [ main ]
    tags: [ 'v*' ]
```

**Adaptations**:
- None required (generic configuration)

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

---

## Publish Job Matrix

**PinkieIt Reference** (commit 6bb70e1):
```yaml
jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    strategy:
      matrix:
        environment:
          - production
          - development
```

**YokaKit Contract**:
```yaml
# Identical configuration
jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    strategy:
      matrix:
        environment:
          - production
          - development
```

**Adaptations**:
- None required

---

## Conditional Build Logic

**Contract**:
```yaml
steps:
  - name: Check if should build this environment
    id: should-build
    run: |
      if [[ "${{ github.event.inputs.environment }}" == "both" ]] || \
         [[ "${{ github.event.inputs.environment }}" == "${{ matrix.environment }}" ]] || \
         [[ -z "${{ github.event.inputs.environment }}" && "${{ matrix.environment }}" == "production" ]]; then
        echo "build=true" >> $GITHUB_OUTPUT
      else
        echo "build=false" >> $GITHUB_OUTPUT
      fi
```

**Logic Table**:
| Input | Matrix Env | Build? | Reason |
|-------|-----------|--------|--------|
| both | production | ✅ | Both selected |
| both | development | ✅ | Both selected |
| production | production | ✅ | Match |
| production | development | ❌ | No match |
| development | production | ❌ | No match |
| development | development | ✅ | Match |
| (empty/tag push) | production | ✅ | Default to production |
| (empty/tag push) | development | ❌ | Default excludes dev |

**Validation**:
- [ ] Conditional logic correctly selects environments
- [ ] Default behavior (no input) builds production only
- [ ] "both" input builds both environments
- [ ] Version tag push builds production only

---

## Publish Steps

### Step 1: Conditional Checkout

**Contract**:
```yaml
- name: Checkout repository
  if: steps.should-build.outputs.build == 'true'
  uses: actions/checkout@v4
```

**Validation**:
- [ ] Only runs if environment selected for build
- [ ] Checkout action version is v4

---

### Step 2: Docker Buildx Setup

**Contract**:
```yaml
- name: Set up Docker Buildx
  if: steps.should-build.outputs.build == 'true'
  uses: docker/setup-buildx-action@v3
  with:
    platforms: linux/amd64,linux/arm64
```

**Validation**:
- [ ] Only runs if environment selected
- [ ] Platforms match Phase 5 multi-architecture support

---

### Step 3: Registry Login

**Contract**:
```yaml
- name: Log in to Container Registry
  if: steps.should-build.outputs.build == 'true'
  uses: docker/login-action@v3
  with:
    registry: ${{ env.REGISTRY }}
    username: ${{ github.actor }}
    password: ${{ secrets.GITHUB_TOKEN }}
```

**Validation**:
- [ ] Always attempts login (not a PR workflow)
- [ ] GITHUB_TOKEN has packages:write permission

---

### Step 4: Metadata Extraction

**Contract**:
```yaml
- name: Extract metadata
  if: steps.should-build.outputs.build == 'true'
  id: meta
  uses: docker/metadata-action@v5
  with:
    images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
    tags: |
      type=ref,event=branch,suffix=-${{ matrix.environment }}
      type=ref,event=tag,suffix=-${{ matrix.environment }}
      type=raw,value=latest-${{ matrix.environment }},enable={{is_default_branch}}
```

**Validation**:
- [ ] Tag patterns include version tags (type=ref,event=tag)
- [ ] Environment suffix applied to all tags
- [ ] Latest tag only on main branch

---

### Step 5: Build and Publish

**Contract**:
```yaml
- name: Build and publish Docker image
  if: steps.should-build.outputs.build == 'true'
  uses: docker/build-push-action@v5
  with:
    context: .
    file: ./Dockerfile
    platforms: linux/amd64,linux/arm64
    target: ${{ matrix.environment }}
    push: true  # Always push in publish workflow
    tags: ${{ steps.meta.outputs.tags }}
    labels: ${{ steps.meta.outputs.labels }}
    cache-from: type=gha,scope=${{ matrix.environment }}
    cache-to: type=gha,mode=max,scope=${{ matrix.environment }}
    build-args: |
      ENVIRONMENT=${{ matrix.environment }}
```

**Validation**:
- [ ] Always pushes to registry (push: true)
- [ ] Multi-architecture build (AMD64 + ARM64)
- [ ] Cache scoped by environment
- [ ] Dockerfile target matches environment

---

## Trigger Scenarios

### Manual Dispatch (production)
```
Input: environment=production
Result: Builds and publishes production only
Tags:
- ghcr.io/w-pinkietech/yokakit:main-production
- ghcr.io/w-pinkietech/yokakit:latest-production
```

### Manual Dispatch (both)
```
Input: environment=both
Result: Builds and publishes both production and development
Tags:
- ghcr.io/w-pinkietech/yokakit:main-production
- ghcr.io/w-pinkietech/yokakit:main-development
- ghcr.io/w-pinkietech/yokakit:latest-production
- ghcr.io/w-pinkietech/yokakit:latest-development
```

### Version Tag Push (v1.0.0)
```
Trigger: git push origin v1.0.0
Result: Builds and publishes production only (default)
Tags:
- ghcr.io/w-pinkietech/yokakit:v1.0.0-production
- ghcr.io/w-pinkietech/yokakit:latest-production
```

### Main Branch Push
```
Trigger: git push origin main
Result: Builds and publishes production only (default)
Tags:
- ghcr.io/w-pinkietech/yokakit:main-production
- ghcr.io/w-pinkietech/yokakit:latest-production
```

---

## Adaptations Summary

**YokaKit-Specific Changes**:
- ✅ IMAGE_NAME uses ${{ github.repository }} (automatic YokaKit naming)
- ✅ No hardcoded "pinkieit" references
- ✅ Conditional logic uses generic variables

**Validation Checklist**:
- [ ] Workflow triggers on manual dispatch, main push, version tags
- [ ] Matrix includes both production and development
- [ ] Conditional logic correctly selects environments
- [ ] Multi-architecture publishing for AMD64 and ARM64
- [ ] Always pushes to registry (not conditional like docker-build.yml)
- [ ] GITHUB_TOKEN has packages:write permission
- [ ] Tags include version numbers on tag push

---

**Created**: 2025-10-04
**Based on**: PinkieIt commit 6bb70e13a520e2acf59905708446083d4ccf9f8e
