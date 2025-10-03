# Phase 2: Docker Architecture Optimization - Quickstart Guide

**Purpose**: Apply Phase 2 Docker optimizations to YokaKit
**Duration**: 30-45 minutes
**Prerequisites**: Phase 1 Docker Foundation completed

## Prerequisites

**From Phase 1**:
- YokaKit with docker/base + docker/app structure
- 3-container stack (web-app, db, mqtt) operational
- Docker Compose v2 installed

**System Requirements**:
- Docker BuildKit support (Docker 18.09+)
- 2GB free disk space (for build cache)

## Quick Start (30 minutes)

### Step 1: Enable BuildKit (2 min)

```bash
# Required for Phase 2 cache mounts
export DOCKER_BUILDKIT=1

# Make permanent (add to ~/.bashrc or ~/.zshrc)
echo 'export DOCKER_BUILDKIT=1' >> ~/.bashrc
```

### Step 2: Backup Phase 1 Configuration (3 min)

```bash
cd YokaKit

# Backup existing configuration
cp docker-compose.yml docker-compose.yml.phase1.bak
cp -r docker/ docker.phase1.bak/
```

### Step 3: Apply Phase 2 Changes (15 min)

**CR1 - .dockerignore** (b980f1e):
```bash
# Copy .dockerignore from PinkieIt
curl -o .dockerignore https://raw.githubusercontent.com/w-pinkietech/pinkieit/b980f1e/.dockerignore
```

**CR2 - Multi-stage Dockerfile** (f9340aa):
```bash
# Create consolidated Dockerfile (adapt from PinkieIt)
# See contracts/dockerfile.contract.md for full specification

# Key adaptation: Replace "PinkieIt" with "YokaKit" in header comment

# Rename docker-compose.yml → compose.yml
mv docker-compose.yml compose.yml

# Edit compose.yml: pinkieit → yokakit naming
sed -i 's/pinkieit-web-app/yokakit-web-app/g' compose.yml
sed -i 's/pinkieit-dev/yokakit-dev/g' compose.yml
sed -i 's/pinkieit:/yokakit:/g' compose.yml
```

**CR3 - BuildKit Cache** (fe2acac):
```bash
# Dockerfile already includes cache mounts from CR2
# Verify DOCKER_BUILDKIT=1 is set
echo $DOCKER_BUILDKIT  # Should output: 1
```

**CR4 - Final Consolidation** (08ac389):
```bash
# Final Dockerfile optimizations already applied in CR2
# No additional steps
```

### Step 4: Build and Test (10 min)

```bash
# Build with BuildKit
docker compose build

# Start services
docker compose up -d

# Verify all services healthy
docker compose ps
```

### Step 5: Constitutional Compliance Check (5 min)

```bash
# Verify no PinkieIt references
grep -ri "pinkieit" Dockerfile compose.yml .devcontainer/ || echo "✅ No PinkieIt references"

# Verify YokaKit naming
docker compose ps | grep yokakit
# Expected: yokakit-web-app, yokakit-db, yokakit-mqtt-broker

# Test HTTP access
curl -I http://localhost:18080
# Expected: HTTP/1.1 200 OK
```

## Validation

**Phase 2 Success Criteria**:
- [ ] .dockerignore present (124 lines)
- [ ] Dockerfile at root (multi-stage, ~96 lines)
- [ ] compose.yml (renamed from docker-compose.yml)
- [ ] docker/base/ and docker/app/ can be removed
- [ ] All services start successfully
- [ ] No "pinkieit" references in YokaKit codebase
- [ ] Build time improved (cache mounts functional)

**Rollback** (if issues):
```bash
# Restore Phase 1 configuration
mv docker-compose.yml.phase1.bak docker-compose.yml
rm -rf docker/ && mv docker.phase1.bak/ docker/
rm Dockerfile .dockerignore
docker compose up -d
```

## Troubleshooting

**BuildKit not enabled**:
```
Error: --mount requires BuildKit
Solution: export DOCKER_BUILDKIT=1
```

**PinkieIt references remain**:
```
Solution: Check compose.yml, Dockerfile, .devcontainer/docker-compose.extend.yml
Use: sed -i 's/pinkieit/yokakit/g' {file}
```

**Build fails**:
```
Solution: Check Dockerfile syntax, verify Phase 1 docker/base content included
```

## Next Steps

1. Remove deprecated docker/base and docker/app directories
2. Run `/tasks` to generate detailed task breakdown
3. Create GitHub Issue for Phase 2 tracking

---

**Quickstart Complete**: Phase 2 Docker optimization applied to YokaKit
