# Phase 6: CI/CD Pipeline & Multi-Architecture Publishing - Data Model

## Entities

### GitHubActionsWorkflow

**Introduced in**: Commit 6bb70e1 (2025-07-04)
**Source**: `.github/workflows/docker-build.yml`, `docker-publish.yml`, `cache-cleanup.yml`

**Attributes**:
```yaml
# From .github/workflows/docker-build.yml at commit 6bb70e1
name: Docker Multi-Architecture Build

on:
  workflow_dispatch:
    inputs:
      push_to_registry: {type: choice, options: [true, false]}
      environment: {type: choice, options: [production, development]}
  push:
    branches: [ main ]
    paths: [ 'Dockerfile', 'app/laravel/**', 'config/**', '.env', 'compose.yml' ]
  pull_request:
    branches: [ main ]
    paths: [ 'Dockerfile', 'app/laravel/**', 'config/**', '.env', 'compose.yml' ]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}  # Resolves to w-pinkietech/YokaKit for YokaKit

jobs:
  build:
    strategy:
      matrix:
        environment: [production, development]
```

**Constitutional Adaptations**:
- `IMAGE_NAME: ${{ github.repository }}` automatically resolves to `w-pinkietech/YokaKit` (correct)
- No hardcoded "pinkieit" references in workflow logic (uses repository context variables)

**Relationships**:
- Triggers: workflow_dispatch (manual), push to main, pull_request
- Depends on: Docker Buildx setup, GitHub Container Registry access
- Produces: Multi-architecture Docker images (AMD64 + ARM64)

**Validation Rules**:
- Matrix must include both production and development environments
- Platforms must include linux/amd64 and linux/arm64
- Cache scope must match matrix.environment to prevent conflicts

---

### DockerBuildJob

**Introduced in**: Commit 6bb70e1 (2025-07-04)
**Source**: `.github/workflows/docker-build.yml` (lines 45-100)

**Attributes**:
```yaml
# From docker-build.yml at commit 6bb70e1
jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    strategy:
      matrix:
        environment: [production, development]

    steps:
      - uses: actions/checkout@v4
      - uses: docker/setup-buildx-action@v3
        with:
          platforms: linux/amd64,linux/arm64
      - uses: docker/login-action@v3
        if: github.event_name != 'pull_request'
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - uses: docker/build-push-action@v5
        with:
          context: .
          file: ./Dockerfile
          platforms: linux/amd64,linux/arm64
          target: ${{ matrix.environment }}
          push: ${{ github.event_name != 'pull_request' && (...) }}
          cache-from: type=gha,scope=${{ matrix.environment }}
          cache-to: type=gha,mode=max,scope=${{ matrix.environment }}
```

**Constitutional Adaptations**:
- Registry image path uses `${{ env.IMAGE_NAME }}` which resolves to repository name
- No PinkieIt-specific naming in workflow variables

**Relationships**:
- Requires: GitHub Actions runner with Docker support
- Uses: Docker Buildx for multi-platform builds
- Caches: Build layers in GitHub Actions cache (scoped by environment)
- Outputs: Tagged Docker images in ghcr.io

**Validation Rules**:
- Push only when not a pull request AND (manual push_to_registry=true OR main branch)
- Cache scope must match environment to prevent cross-environment conflicts
- Platforms must match Phase 5 multi-architecture support (AMD64 + ARM64)

---

### DockerPublishJob

**Introduced in**: Commit 6bb70e1 (2025-07-04)
**Source**: `.github/workflows/docker-publish.yml` (lines 20-90)

**Attributes**:
```yaml
# From docker-publish.yml at commit 6bb70e1
jobs:
  publish:
    strategy:
      matrix:
        environment:
          - production
          - development

    steps:
      - id: should-build
        run: |
          if [[ "${{ github.event.inputs.environment }}" == "both" ]] || \
             [[ "${{ github.event.inputs.environment }}" == "${{ matrix.environment }}" ]] || \
             [[ -z "${{ github.event.inputs.environment }}" && "${{ matrix.environment }}" == "production" ]]; then
            echo "build=true" >> $GITHUB_OUTPUT
          else
            echo "build=false" >> $GITHUB_OUTPUT
          fi

      - if: steps.should-build.outputs.build == 'true'
        uses: docker/build-push-action@v5
        # ... build configuration
```

**Constitutional Adaptations**:
- Environment selection logic uses generic variables (no PinkieIt naming)
- Registry and image name use GitHub context variables

**Relationships**:
- Triggers: workflow_dispatch (manual), push to main, version tags (v*)
- Conditional: Builds only selected environments based on input
- Outputs: Published multi-architecture images to ghcr.io

**Validation Rules**:
- Default behavior (no input): Build production only
- Input "both": Build both production and development
- Input "production" or "development": Build only that environment
- Version tag push (v*): Automatic production build

---

### CacheCleanupJob

**Introduced in**: Commit 6bb70e1 (2025-07-04)
**Source**: `.github/workflows/cache-cleanup.yml` (lines 12-48)

**Attributes**:
```yaml
# From cache-cleanup.yml at commit 6bb70e1
jobs:
  cleanup:
    runs-on: ubuntu-latest
    permissions:
      actions: write
      contents: read

    steps:
      - run: |
          gh api repos/${{ github.repository }}/actions/caches \
            --jq '.actions_caches[] | select(.created_at < (now - 604800 | strftime("%Y-%m-%dT%H:%M:%SZ"))) | .id' \
            > old_cache_ids.txt

          while read cache_id; do
            gh api repos/${{ github.repository }}/actions/caches/$cache_id -X DELETE || true
          done < old_cache_ids.txt
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Constitutional Adaptations**:
- Uses `${{ github.repository }}` for repository reference (automatically correct for YokaKit)

**Relationships**:
- Triggers: Weekly schedule (cron: '0 2 * * 0'), workflow_dispatch (manual)
- Accesses: GitHub API for cache management
- Deletes: Caches older than 7 days (604800 seconds)

**Validation Rules**:
- Schedule: Run weekly on Sundays at 2 AM UTC
- Age threshold: Only delete caches older than 7 days
- Permissions: Requires actions:write for cache deletion
- Failure handling: Continue on cache deletion errors (|| true)

---

## Configuration Entities

### WorkflowEnvironmentVariables

**Introduced in**: Commit 6bb70e1 (2025-07-04)
**File**: `.github/workflows/docker-build.yml`, `docker-publish.yml`

**PinkieIt Original**:
```yaml
env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}  # Resolves to w-pinkietech/pinkieit
```

**YokaKit Adapted**:
```yaml
env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}  # Resolves to w-pinkietech/YokaKit
```

**Changes**:
- No changes needed: `${{ github.repository }}` automatically uses YokaKit repository name
- Registry remains ghcr.io (GitHub Container Registry)

---

### DockerImageTags

**Introduced in**: Commit 6bb70e1 (2025-07-04)
**Source**: `.github/workflows/docker-build.yml` (docker/metadata-action@v5)

**PinkieIt Original**:
```yaml
- id: meta
  uses: docker/metadata-action@v5
  with:
    images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
    tags: |
      type=ref,event=branch,suffix=-${{ matrix.environment }}
      type=ref,event=pr,suffix=-${{ matrix.environment }}
      type=raw,value=latest-${{ matrix.environment }},enable={{is_default_branch}}
      type=sha,prefix={{branch}}-${{ matrix.environment }}-,format=short
```

**YokaKit Adapted**:
```yaml
# Same configuration - IMAGE_NAME resolves to YokaKit repository
# Example generated tags:
# - ghcr.io/w-pinkietech/yokakit:main-production
# - ghcr.io/w-pinkietech/yokakit:main-development
# - ghcr.io/w-pinkietech/yokakit:latest-production
# - ghcr.io/w-pinkietech/yokakit:latest-development
# - ghcr.io/w-pinkietech/yokakit:main-production-a1b2c3d
```

**Changes**:
- No workflow changes needed (IMAGE_NAME is context-aware)
- Tag patterns remain identical (constitutional compliance automatic)

---

### GitHubActionsCacheScope

**Introduced in**: Commit 6bb70e1 (2025-07-04)
**Source**: `.github/workflows/docker-build.yml` (BuildKit cache configuration)

**Configuration**:
```yaml
cache-from: type=gha,scope=${{ matrix.environment }}
cache-to: type=gha,mode=max,scope=${{ matrix.environment }}
```

**Scopes**:
- `production`: Cache for production environment builds
- `development`: Cache for development environment builds

**Purpose**:
- Prevents cache conflicts between environments
- Optimizes cache hit rates per environment
- Mode=max: Aggressive caching of all layers

**Validation**:
- Cache keys must include environment suffix
- Separate cache namespaces for production vs development
- Maximum cache mode for optimal build performance

---

## Workflow Trigger Matrix

### docker-build.yml Triggers

| Trigger Type | Condition | Action |
|--------------|-----------|--------|
| workflow_dispatch | Manual execution | Build with user-selected environment and push option |
| push | main branch + Dockerfile/app changes | Build both environments, push to registry |
| pull_request | main branch + Dockerfile/app changes | Build both environments, NO push (test only) |

### docker-publish.yml Triggers

| Trigger Type | Condition | Action |
|--------------|-----------|--------|
| workflow_dispatch | Manual execution | Build selected environment(s): production / development / both |
| push | main branch | Build production (default) |
| push | version tag (v*) | Build production (release) |

### cache-cleanup.yml Triggers

| Trigger Type | Condition | Action |
|--------------|-----------|--------|
| schedule | Sundays 2 AM UTC (cron) | Delete caches >7 days old, report usage |
| workflow_dispatch | Manual execution | Delete caches >7 days old, report usage |

---

## Constitutional Compliance Summary

**Identity Preservation**:
- ✅ All workflows use `${{ github.repository }}` for automatic YokaKit naming
- ✅ No hardcoded "pinkieit" references in workflow files
- ✅ Image tags automatically include "yokakit" via IMAGE_NAME resolution

**Naming Adaptations Required**:
- ✅ Workflows: No adaptation needed (context-aware variables)
- ✅ CLAUDE.md: Update build command examples (pinkieit → yokakit)

**Validation Checklist**:
- [ ] Workflow files contain zero "pinkieit" string literals
- [ ] IMAGE_NAME resolves to w-pinkietech/YokaKit in all contexts
- [ ] ghcr.io registry configured for w-pinkietech/YokaKit repository
- [ ] GITHUB_TOKEN has packages:write permission
- [ ] Cache scopes correctly namespace production vs development

---

**Created**: 2025-10-04
**Based on**: PinkieIt commit 6bb70e13a520e2acf59905708446083d4ccf9f8e
