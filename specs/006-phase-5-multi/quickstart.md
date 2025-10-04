# Phase 5: Multi-Architecture Docker Support - Quickstart Guide

## Prerequisites

**From PinkieIt Commit 9bfa0b5**:
- Docker Engine 19.03+ with BuildKit support
- Docker Buildx v0.10.0+ (multi-platform build plugin)
- QEMU binfmt (for cross-architecture builds on single-platform hosts)
- Git (for YokaKit repository access)

**YokaKit Environment**:
- Completed Phase 2 (Multi-stage Dockerfile)
- Completed Phase 4 (DevContainer & Framework Modernization)
- 425 tests passing (baseline for validation)

**System Requirements**:
- Linux, macOS, or Windows with WSL2
- 4GB+ RAM (for concurrent multi-arch builds)
- 20GB+ disk space (for Docker images and build cache)

---

## 15-Minute Setup

### Step 1: Verify Prerequisites (2 min)

```bash
# Check Docker version
docker version
# Expected: Docker Engine 19.03 or higher

# Check Docker Buildx
docker buildx version
# Expected: github.com/docker/buildx v0.10.0 or higher

# Check QEMU binfmt (for cross-platform builds)
docker run --privileged --rm tonistiigi/binfmt --install all
# Expected: Installing: linux/amd64, linux/arm64/v8, ...

# Verify multi-platform support
docker buildx ls
# Expected: Active builder with "linux/amd64*, linux/arm64" in platforms
```

**If Docker Buildx not installed**:
```bash
# Linux/macOS
docker buildx install

# Or manual installation
BUILDX_VERSION=v0.11.2
mkdir -p ~/.docker/cli-plugins
curl -L "https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-amd64" \
  -o ~/.docker/cli-plugins/docker-buildx
chmod +x ~/.docker/cli-plugins/docker-buildx
```

---

### Step 2: Checkout Phase 5 Branch (1 min)

**In YokaKit_Replay** (for tracking):
```bash
cd /path/to/YokaKit_Replay
git checkout 006-phase-5-multi
```

**In YokaKit** (for implementation):
```bash
cd /path/to/YokaKit_Replay/YokaKit
# Create Phase 5 implementation branch (or use existing if created)
git checkout -b feature/phase-5-multi-arch
```

---

### Step 3: Update Dockerfile - Base Stage (3 min)

**Based on**: PinkieIt commit 9bfa0b5

**File**: `YokaKit/Dockerfile`

**Changes to Apply** (in base stage RUN command):

**Before** (Phase 2):
```dockerfile
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt-get update && apt-get install -y \
    build-essential \
    curl \
    ...
    && a2enmod rewrite
```

**After** (Phase 5):
```dockerfile
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

**Key Changes**:
1. Add `,sharing=locked` to cache mounts (lines 2-3)
2. Add `rm -f /etc/apt/apt.conf.d/docker-clean` before apt-get
3. Change `apt-get install -y` → `apt-get install -y --no-install-recommends`
4. Split package installation (essentials first, libraries second)
5. Add `ca-certificates` package
6. Add `apt-get update` after Node.js repository setup
7. Add `rm -rf /var/lib/apt/lists/*` at end

---

### Step 4: Update Dockerfile - Development Stage (2 min)

**Based on**: PinkieIt commit 9bfa0b5

**Changes to Apply** (in development stage RUN command):

**Before** (Phase 2):
```dockerfile
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt-get update && apt-get install -y \
    gifsicle git jpegoptim optipng pngquant vim \
    && pecl install pcov && docker-php-ext-enable pcov
```

**After** (Phase 5):
```dockerfile
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
    gifsicle git jpegoptim optipng pngquant vim \
    && pecl install pcov && docker-php-ext-enable pcov \
    && rm -rf /var/lib/apt/lists/*
```

**Key Changes**:
1. Add `,sharing=locked` to cache mounts
2. Add `--no-install-recommends` flag
3. Add `rm -rf /var/lib/apt/lists/*` cleanup

---

### Step 5: Test Multi-Architecture Builds (5 min)

**Platform-Specific Builds**:
```bash
cd YokaKit

# Build for AMD64 (Intel/AMD servers)
docker buildx build --platform linux/amd64 --target production --load -t yokakit:amd64 .
# Expected: [linux/amd64 1/1] CACHED ... Successfully built ...

# Build for ARM64 (Apple Silicon)
docker buildx build --platform linux/arm64 --target production --load -t yokakit:arm64 .
# Expected: [linux/arm64 1/1] ... Successfully built ...
# Note: May take longer due to QEMU emulation on non-ARM64 hosts

# Build development stage (AMD64)
docker buildx build --platform linux/amd64 --target development --load -t yokakit:dev-amd64 .
# Expected: Successfully built development image for AMD64
```

**Multi-Architecture Build** (both platforms simultaneously):
```bash
# Build for both AMD64 and ARM64
docker buildx build --platform linux/amd64,linux/arm64 --target production -t yokakit:latest .
# Expected: [linux/amd64 ...] [linux/arm64 ...] Successfully built for 2 platforms

# Note: Cannot use --load with multiple platforms
# To load multi-arch image, use --push to registry or build separately
```

---

### Step 6: Validation (2 min)

#### Constitutional Compliance

```bash
# Verify YokaKit identity preserved (no pinkieit references)
cd YokaKit
grep -ri "pinkieit" . --exclude-dir=vendor --exclude-dir=node_modules
# Expected: No results (all should be yokakit)
```

#### Service Health

```bash
# Check built images
docker images | grep yokakit
# Expected: yokakit:amd64, yokakit:arm64, yokakit:dev-amd64

# Inspect multi-arch manifest (if pushed to registry)
docker buildx imagetools inspect yokakit:latest
# Expected: MediaType: application/vnd.docker.distribution.manifest.list.v2+json
#           Platform: linux/amd64, linux/arm64
```

#### Feature Validation

```bash
# Run tests on AMD64 image
docker run --rm yokakit:dev-amd64 php artisan test
# Expected: Tests: 425 passed (425 total)

# Verify Dockerfile optimizations applied
docker history yokakit:amd64 | grep "apt-get install"
# Expected: Lines show "--no-install-recommends" and "sharing=locked"

# Check image size (should not increase significantly from Phase 2)
docker images yokakit:amd64 --format "{{.Repository}}:{{.Tag}} {{.Size}}"
# Expected: Similar size to Phase 2 build (optimizations applied)
```

---

## Troubleshooting

### Issue 1: Docker Buildx not found
**Symptom**: `docker: 'buildx' is not a docker command`

**Solution**:
```bash
# Install Buildx plugin
docker buildx install

# Or download manually
BUILDX_VERSION=v0.11.2
mkdir -p ~/.docker/cli-plugins
curl -L "https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-amd64" \
  -o ~/.docker/cli-plugins/docker-buildx
chmod +x ~/.docker/cli-plugins/docker-buildx
```

### Issue 2: QEMU not available for ARM64 builds
**Symptom**: `failed to solve: linux/arm64: exec format error`

**Solution**:
```bash
# Install QEMU binfmt support
docker run --privileged --rm tonistiigi/binfmt --install all

# Verify installation
docker buildx ls
# Expected: Platforms should include linux/arm64
```

### Issue 3: Cache conflicts during concurrent builds
**Symptom**: `Error: cache mount conflict` or build failures

**Solution**:
- Verify `,sharing=locked` is present on all cache mounts in Dockerfile
- Check commit 9bfa0b5 implementation for correct syntax
- Ensure both base and development stages have `sharing=locked`

### Issue 4: Image size increased
**Symptom**: Docker image larger than Phase 2 baseline

**Solution**:
- Verify `--no-install-recommends` on all apt-get install commands
- Verify `rm -rf /var/lib/apt/lists/*` at end of each RUN with apt-get
- Check `docker history yokakit:amd64` for unnecessary layers

### Issue 5: Tests failing on ARM64
**Symptom**: Test failures specific to ARM64 platform

**Solution**:
- Check for architecture-specific dependencies or assumptions
- Verify PCOV extension installs correctly on ARM64
- Review test failures for byte-order or pointer-size issues
- Note: ARM64 testing may be deferred if no ARM64 host available (rely on build success)

---

## Next Steps

1. **Update CLAUDE.md**: Add Phase 5 multi-architecture documentation (in YokaKit_Replay root)
2. **Run Full Test Suite**: Verify 425/425 tests pass on AMD64 (ARM64 if available)
3. **Commit Changes**: Reference PinkieIt commit 9bfa0b555b94e14a3b55a2a8d8f205486432a027
4. **Create Pull Request**: Merge Phase 5 multi-architecture support to YokaKit main

---

## Quick Reference Commands

```bash
# Build AMD64 production image
docker buildx build --platform linux/amd64 --target production --load -t yokakit:amd64 .

# Build ARM64 production image
docker buildx build --platform linux/arm64 --target production --load -t yokakit:arm64 .

# Build multi-architecture (both platforms)
docker buildx build --platform linux/amd64,linux/arm64 --target production -t yokakit:latest .

# Run tests on AMD64
docker run --rm yokakit:dev-amd64 php artisan test

# Check for pinkieit references (constitutional check)
grep -ri "pinkieit" YokaKit/ --exclude-dir=vendor --exclude-dir=node_modules
```

---

**Total Setup Time**: 15 minutes
**Validation Time**: 2 minutes
**Total Phase 5 Quickstart**: 17 minutes

**Created**: 2025-10-04
**Based on**: PinkieIt commit 9bfa0b555b94e14a3b55a2a8d8f205486432a027
**Status**: Ready for implementation ✅
