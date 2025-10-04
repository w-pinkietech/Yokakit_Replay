# Dockerfile Multi-Architecture Contract

**Source**: PinkieIt commit 9bfa0b5 (2025-06-26)
**Target**: YokaKit/Dockerfile (base and development stages)

## Base Stage Multi-Architecture Contract

### PinkieIt Reference (commit 9bfa0b5)

```dockerfile
# Base stage with common system dependencies and PHP extensions
FROM php:${PHP_VERSION}-apache AS base

# Install system dependencies with multi-architecture support
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

### YokaKit Contract

**Requirement**: Identical to PinkieIt (no naming changes in Dockerfile itself)

**Key Multi-Architecture Features**:
1. **Cache Mount Sharing**:
   ```dockerfile
   --mount=type=cache,target=/var/cache/apt,sharing=locked
   --mount=type=cache,target=/var/lib/apt,sharing=locked
   ```
   - **Purpose**: Prevent cache conflicts during concurrent AMD64/ARM64 builds
   - **Validation**: Both platforms can build simultaneously without cache corruption

2. **Minimal Package Installation**:
   ```dockerfile
   apt-get install -y --no-install-recommends
   ```
   - **Purpose**: Reduce image size by excluding recommended packages
   - **Validation**: Image size does not increase significantly compared to Phase 2

3. **Cache Cleanup**:
   ```dockerfile
   rm -rf /var/lib/apt/lists/*
   ```
   - **Purpose**: Minimize final layer size
   - **Validation**: `/var/lib/apt/lists/` directory is empty in final image

4. **Security Enhancement**:
   ```dockerfile
   ca-certificates
   ```
   - **Purpose**: Enable secure HTTPS operations
   - **Validation**: curl to HTTPS URLs succeeds without certificate errors

5. **Split Installation**:
   ```dockerfile
   && apt-get install -y --no-install-recommends \
   build-essential \
   curl \
   ca-certificates \
   && apt-get install -y --no-install-recommends \
   libfreetype6 libfreetype6-dev \
   ...
   ```
   - **Purpose**: Improve build clarity and caching
   - **Validation**: Two separate apt-get install commands in base stage RUN

### Validation Criteria

- [ ] Base stage builds successfully on linux/amd64 platform
- [ ] Base stage builds successfully on linux/arm64 platform
- [ ] `sharing=locked` present on all cache mounts
- [ ] `--no-install-recommends` present on all apt-get install commands
- [ ] `rm -rf /var/lib/apt/lists/*` executed after final apt-get install
- [ ] `ca-certificates` package installed before curl operations
- [ ] No pinkieit references in Dockerfile (constitutional compliance)

---

## Development Stage Multi-Architecture Contract

### PinkieIt Reference (commit 9bfa0b5)

```dockerfile
# Development stage - extends base with dev tools and dev dependencies
FROM base AS development

# Install development tools and PCOV with multi-architecture support
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
    gifsicle git jpegoptim optipng pngquant vim \
    && pecl install pcov && docker-php-ext-enable pcov \
    && rm -rf /var/lib/apt/lists/*
```

### YokaKit Contract

**Requirement**: Identical to PinkieIt (no naming changes in Dockerfile itself)

**Key Multi-Architecture Features**:
1. **Same Cache Mount Sharing**:
   ```dockerfile
   --mount=type=cache,target=/var/cache/apt,sharing=locked
   --mount=type=cache,target=/var/lib/apt,sharing=locked
   ```
   - **Consistency**: Same pattern as base stage for uniform multi-arch support

2. **Same Minimal Installation**:
   ```dockerfile
   apt-get install -y --no-install-recommends
   ```
   - **Purpose**: Consistent image size optimization across all stages

3. **Same Cache Cleanup**:
   ```dockerfile
   rm -rf /var/lib/apt/lists/*
   ```
   - **Purpose**: Minimize development stage layer size

### Validation Criteria

- [ ] Development stage builds successfully on linux/amd64 platform
- [ ] Development stage builds successfully on linux/arm64 platform
- [ ] `sharing=locked` present on all cache mounts
- [ ] `--no-install-recommends` present on all apt-get install commands
- [ ] `rm -rf /var/lib/apt/lists/*` executed after apt-get install
- [ ] PCOV extension installs and enables successfully on both platforms
- [ ] No pinkieit references in Dockerfile (constitutional compliance)

---

## Multi-Platform Build Contract

### Build Command Contract

**PinkieIt Reference**:
```bash
docker buildx build --platform linux/amd64,linux/arm64 --target production .
docker buildx build --platform linux/amd64 --target production --load -t pinkieit:amd64 .
docker buildx build --platform linux/arm64 --target production --load -t pinkieit:arm64 .
```

**YokaKit Contract**:
```bash
# Multi-architecture build (both platforms)
docker buildx build --platform linux/amd64,linux/arm64 --target production -t yokakit:latest .
docker buildx build --platform linux/amd64,linux/arm64 --target development -t yokakit:dev .

# Platform-specific builds (AMD64)
docker buildx build --platform linux/amd64 --target production --load -t yokakit:amd64 .
docker buildx build --platform linux/amd64 --target development --load -t yokakit:dev-amd64 .

# Platform-specific builds (ARM64)
docker buildx build --platform linux/arm64 --target production --load -t yokakit:arm64 .
docker buildx build --platform linux/arm64 --target development --load -t yokakit:dev-arm64 .
```

**Adaptations**:
- Image tags: `pinkieit:*` → `yokakit:*`
- All build commands MUST use `yokakit` prefix

### Validation Criteria

- [ ] Multi-architecture build completes without errors
- [ ] AMD64 platform-specific build completes successfully
- [ ] ARM64 platform-specific build completes successfully
- [ ] `docker buildx ls` shows active builder with multi-platform support
- [ ] Built images tagged with `yokakit:*` (no pinkieit references)
- [ ] `docker images | grep yokakit` shows expected tags

---

## Functional Validation Contract

### Test Suite Execution

**Requirement**: All 425 tests MUST pass on both AMD64 and ARM64 platforms

**AMD64 Validation**:
```bash
docker buildx build --platform linux/amd64 --target development --load -t yokakit:dev-amd64 .
docker run --rm yokakit:dev-amd64 php artisan test
# Expected: Tests: 425 passed (425 total)
```

**ARM64 Validation** (if ARM64 host available):
```bash
docker buildx build --platform linux/arm64 --target development --load -t yokakit:dev-arm64 .
docker run --rm yokakit:dev-arm64 php artisan test
# Expected: Tests: 425 passed (425 total)
```

**Emulation Validation** (if only AMD64 host):
```bash
# Rely on Docker Buildx + QEMU for ARM64 build success
docker buildx build --platform linux/arm64 --target production .
# Expected: Build completes without errors (functional equivalence assumed)
```

### Validation Criteria

- [ ] AMD64 build passes all 425 tests
- [ ] ARM64 build completes successfully (runtime tests if ARM64 host available)
- [ ] No architecture-specific failures or warnings
- [ ] PHP extensions load correctly on both platforms
- [ ] Laravel application serves requests on both platforms

---

## Constitutional Compliance Contract

### Identity Preservation

**Requirement**: No pinkieit references in YokaKit codebase

**Validation Command**:
```bash
grep -ri "pinkieit" YokaKit/ --exclude-dir=vendor --exclude-dir=node_modules
# Expected: No results (all references should be yokakit)
```

**Validation Criteria**:
- [ ] Dockerfile contains no pinkieit references
- [ ] Build commands use yokakit:* tags
- [ ] No pinkieit in CLAUDE.md (YokaKit_Replay documentation)
- [ ] No pinkieit in any Phase 5 artifacts

---

**Created**: 2025-10-04
**Contract Version**: 1.0
**Source Commit**: 9bfa0b555b94e14a3b55a2a8d8f205486432a027
**Validation**: All criteria MUST pass before Phase 5 completion
