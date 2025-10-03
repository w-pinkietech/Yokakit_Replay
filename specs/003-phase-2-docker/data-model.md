# Phase 2: Docker Architecture Optimization - Data Model

**Generated**: 2025-10-03
**Purpose**: Docker infrastructure entities and configuration models from PinkieIt commits

## Entities from PinkieIt Commits

### Multi-Stage Dockerfile

**Introduced in**: Commit f9340aa (2025-06-26 20:01:55)
**Source**: `Dockerfile` (new file)

**Structure**:
```dockerfile
# From PinkieIt commit f9340aa (simplified structure)
FROM php:8.2-apache AS base
# Base runtime stage

FROM base AS build
# Asset compilation and dependency installation

FROM base AS production
# Production runtime (default target)
```

**Constitutional Adaptations**:
```diff
-# Multi-stage Dockerfile for PinkieIt
+# Multi-stage Dockerfile for YokaKit
```

**Attributes**:
- **Stages**: base, build, production (evolves to include composer-deps, npm-deps in fe2acac)
- **Base Image**: php:8.2-apache (inherited from Phase 1)
- **Build Tools**: composer, npm (installed in build stage)
- **Runtime**: Apache + PHP-FPM (production stage)

**Relationships**:
- Replaces: `docker/base/Dockerfile` + `docker/app/` configurations (Phase 1)
- Referenced by: `compose.yml` (service image)
- Referenced by: `.devcontainer/docker-compose.extend.yml` (development image)

---

### .dockerignore Configuration

**Introduced in**: Commit b980f1e (2025-06-26 19:47:40)
**Source**: `.dockerignore` (new file, 124 lines)

**Structure**:
```dockerignore
# Git files
.git
.gitignore
.gitattributes

# Node.js
node_modules
npm-debug.log*

# PHP
vendor/
composer.lock

# Development files
tests/
*.test.php

# IDE configurations
.vscode/
.idea/

# ... (124 total lines)
```

**Constitutional Adaptations**:
- None required (generic ignore patterns, no PinkieIt-specific content)

**Attributes**:
- **Categories**: Git files, dependencies, logs, caches, tests, IDE configs, OS files
- **Purpose**: Exclude ~90% of repository files from Docker build context
- **Impact**: Reduces build context from ~500MB to ~50MB (estimated)

**Relationships**:
- Used by: `Dockerfile` build process
- Optimizes: Docker build context transfer speed

---

### Docker Compose Services (YokaKit)

**Introduced in**: Commit f9340aa (2025-06-26 20:01:55)
**Source**: `compose.yml` (renamed from docker-compose.yml)

**Services**:

#### web-app Service

**PinkieIt Original** (commit f9340aa):
```yaml
services:
  web-app:
    image: pinkieit-web-app
    container_name: pinkieit-web-app
    build:
      context: .
      dockerfile: Dockerfile
```

**YokaKit Adapted**:
```yaml
services:
  web-app:
    image: yokakit-web-app
    container_name: yokakit-web-app
    build:
      context: .
      dockerfile: Dockerfile
```

**Constitutional Changes**:
- `image`: pinkieit-web-app → yokakit-web-app
- `container_name`: pinkieit-web-app → yokakit-web-app

**Attributes**:
- **Image**: Built from multi-stage Dockerfile
- **Dependencies**: db (healthy), mqtt (started) - inherited from Phase 1
- **Volumes**: Application code bind mount, storage persistence
- **Ports**: 18080:80 (HTTP) - inherited from Phase 1
- **Networks**: yokakit network (isolated) - inherited from Phase 1

**Relationships**:
- Depends on: `db` service (MariaDB 10.11.4 from Phase 1)
- Depends on: `mqtt` service (Eclipse Mosquitto from Phase 1)
- Uses: Multi-Stage Dockerfile entity

#### db Service

**Source**: Inherited from Phase 1 (no changes in Phase 2)
**Image**: mariadb:10.11.4
**Container Name**: yokakit-db (already YokaKit-compliant from Phase 1)

**Attributes** (unchanged):
- **Data Volume**: yokakit_db_data (persistent)
- **Port**: 3306 (internal only)
- **Healthcheck**: mysqladmin ping

#### mqtt Service

**Source**: Inherited from Phase 1 (no changes in Phase 2)
**Image**: eclipse-mosquitto:latest
**Container Name**: yokakit-mqtt-broker (already YokaKit-compliant from Phase 1)

**Attributes** (unchanged):
- **Configuration**: ./mqtt/mosquitto/config/mosquitto.conf
- **Data Volume**: ./mqtt/mosquitto/data
- **Log Volume**: ./mqtt/mosquitto/log
- **Ports**: 18830:1883 (MQTT), 9001:9001 (WebSocket)

---

### BuildKit Cache Mounts

**Introduced in**: Commit fe2acac (2025-06-26 21:31:49)
**Source**: `Dockerfile` (BuildKit --mount directives)

**Structure**:
```dockerfile
# Composer cache mount
RUN --mount=type=cache,target=/root/.composer/cache \
    composer install --no-dev --optimize-autoloader

# NPM cache mount
RUN --mount=type=cache,target=/root/.npm \
    npm ci --production
```

**Constitutional Adaptations**:
- None required (cache paths are generic, no PinkieIt naming)

**Attributes**:
- **Composer Cache**: `/root/.composer/cache` (persistent across builds)
- **NPM Cache**: `/root/.npm` (persistent across builds)
- **Benefit**: 50-80% faster dependency installation on rebuilds (estimated)
- **Requirement**: DOCKER_BUILDKIT=1 environment variable

**Relationships**:
- Used by: Multi-Stage Dockerfile (composer-deps, npm-deps stages)
- Requires: Docker BuildKit enabled

---

### DevContainer Configuration

**Modified in**: Commit f9340aa (2025-06-26 20:01:55)
**Source**: `.devcontainer/docker-compose.extend.yml`

**PinkieIt Original**:
```yaml
services:
  web-app:
    image: pinkieit-web-app
    container_name: pinkieit-dev
```

**YokaKit Adapted**:
```yaml
services:
  web-app:
    image: yokakit-web-app
    container_name: yokakit-dev
```

**Constitutional Changes**:
- `image`: pinkieit-web-app → yokakit-web-app
- `container_name`: pinkieit-dev → yokakit-dev

**Attributes**:
- **Purpose**: VS Code Dev Container integration
- **Image**: References yokakit-web-app from compose.yml
- **Container**: yokakit-dev (development instance)

**Relationships**:
- Extends: `compose.yml` services
- Used by: VS Code Dev Containers extension

---

## Configuration Entities

### Dockerfile Build Stages (Evolution)

**Commit f9340aa** (Initial multi-stage):
```
base → build → production
```

**Commit fe2acac** (Cache optimization):
```
base → composer-deps → npm-deps → build → development → production
```

**Commit 08ac389** (Final consolidation):
```
base → build → production
(with integrated cache mounts)
```

**YokaKit Implementation** (08ac389 adapted):
- **base**: PHP 8.2-apache foundation with system packages
- **build**: Unified dependency stage with composer/npm cache mounts
- **production**: Optimized runtime with compiled assets (default)

**Constitutional Compliance**:
- All stage comments reference "YokaKit" (not "PinkieIt")
- Build artifacts contain no PinkieIt branding

---

## Docker Infrastructure Summary

**Files Created/Modified** (Phase 2):
- `Dockerfile` - NEW (multi-stage build, 96 lines final)
- `.dockerignore` - NEW (124 lines)
- `compose.yml` - RENAMED from docker-compose.yml (YokaKit naming)
- `.devcontainer/docker-compose.extend.yml` - UPDATED (YokaKit image references)

**Files Deprecated** (to be removed after Phase 2):
- `docker/base/Dockerfile` - Consolidated into root Dockerfile
- `docker/app/` - Configurations merged into root Dockerfile

**Constitutional Identity**:
- **Images**: yokakit-web-app, yokakit-db, yokakit-mqtt-broker
- **Containers**: yokakit-web-app, yokakit-db, yokakit-mqtt-broker, yokakit-dev
- **Network**: yokakit
- **Volumes**: yokakit_db_data, yokakit_mqtt_data

**No PinkieIt References**: All Docker infrastructure uses YokaKit naming exclusively

---

**Data Model Complete**: 5 primary entities, 3 services, constitutional compliance verified
