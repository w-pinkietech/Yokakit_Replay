# Tasks: Phase 4 - Framework Modernization & DevContainer

**Input**: Design documents from `specs/005-phase-4-e0eaabd/`
**Prerequisites**: plan.md, research.md, data-model.md, contracts/

## Execution Flow (/tasks command scope)
```
1. ✅ Load plan.md (commit replay strategy)
   → Phase 4A: DevContainer unified (0cc0475 + 65eea6a + cdd8d6f)
   → Phase 4B: Framework modernization (5 sequential stories)
2. ✅ Load research.md (8 commits analyzed)
   → DevContainer: 3 commits unified
   → Framework: 5 commits sequential
3. ✅ Generate tasks by CR (Commit Replay):
   → CR1: DevContainer Complete (Analyze → Implement → Validate → Commit → GitHub)
   → CR2-CR6: Framework upgrades (sequential, each with full task cycle)
4. ✅ Apply task rules:
   → Phase 4A and 4B: Sequential (DevContainer blocks framework upgrades)
   → Within CR: Analyze → Implement → Validate → Commit
   → Constitutional checks in every validation task
5. ✅ Number tasks sequentially (T001, T002, ...)
6. ✅ Validate completeness:
   → All 6 CRs have full task cycle ✓
   → All constitutional adaptations documented ✓
9. ✅ Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files/CRs, no dependencies)
- Include exact file paths and PinkieIt commit references

## Path Conventions
- **YokaKit Repository**: `YokaKit/` (Git submodule - actual development target)
- **PinkieIt Repository**: `pinkieit/` (Git submodule - pattern reference)
- **Specs Directory**: `specs/005-phase-4-e0eaabd/`

---

## Overview

**PinkieIt Commits**: `0cc0475..cdd8d6f` (DevContainer + Framework Modernization)
**Total Commits**: 148 commits in range (analyzed in research.md)
**Primary Commits**: 8 (3 DevContainer unified + 5 framework modernization)
**Commits to Replay**: 6 stories (1 unified DevContainer + 5 framework upgrades)
**Total Tasks**: 48 tasks

**Task Structure**: Each Commit Replay (CR) follows this pattern:
1. **Analyze**: Review PinkieIt commit(s) and plan adaptations (15-30 min)
2. **Implement**: Replay files with constitutional compliance (1-4 hours)
3. **Validate**: Verify implementation matches PinkieIt + YokaKit identity (15-30 min)
4. **Commit**: Create commit with audit trail reference (5-10 min)
5. **Track**: Create/update GitHub Issues (10-15 min)

**Two-Phase Execution**:
- **Phase 4A**: DevContainer Complete Environment (CR1, Tasks T001-T010)
- **Phase 4B**: Framework Modernization (CR2-CR6, Tasks T011-T048)

---

## Constitutional Skips

**NONE** - All 8 primary commits are technical implementations with no PinkieIt→YokaKit rename commits.

---

## Commit Replays

### Summary by Commit Replay:

**Phase 4A: DevContainer Complete Environment**
- **CR1** (0cc0475 + 65eea6a + cdd8d6f): Tasks T001-T010 (10 tasks) - **Unified Implementation**

**Phase 4B: Framework Modernization** (Sequential)
- **CR2** (e0eaabd): Tasks T011-T017 (7 tasks) - PHP 8.2 Upgrade
- **CR3** (4152b54): Tasks T018-T025 (8 tasks) - Laravel 10 Initial Upgrade
- **CR4** (862d537): Tasks T026-T032 (7 tasks) - Laravel 10 Completion
- **CR5** (d4db04f): Tasks T033-T040 (8 tasks) - Laravel Reverb Installation
- **CR6** (524c1c3): Tasks T041-T048 (8 tasks) - Remove Legacy WebSockets

---

## PHASE 4A: DevContainer Complete Environment

## COMMIT REPLAY 1: Unified DevContainer Implementation

**PinkieIt Commits** (Unified):
- `0cc04757fa60ad18e1b941206fb9b5a6843f8bd2` (2025-02-20, Initial)
- `65eea6abe9dfaaf0017ff85e0f0a701edc3c9b81` (2025-06-26, Optimization)
- `cdd8d6f8e9a6e6db0cabce8e1d7ec0196a743f38` (2025-06-27, Finalization)

**Date**: 2025-02-20 (initial) → 2025-06-27 (final)
**Files**: 4 primary files (devcontainer.json, compose.override.yml, post-create.sh, Dockerfile updates)
**Constitutional**: Identity-preservation (pinkieit → yokakit adaptations)

**Rationale for Unification**: YokaKit Phase 2 Docker already complete (consolidated Dockerfile, multi-stage builds). Implementing final DevContainer form directly avoids unnecessary intermediate states. All 3 source commit hashes preserved for audit trail.

### Story/Issue Reference
- **YokaKit Epic**: #TBD (Phase 4: Framework Modernization & DevContainer)
- **YokaKit Story**: #TBD (CR1: DevContainer Complete Environment)

---

### T001: Analyze DevContainer Unified Implementation

**Type**: Preparation
**Estimated**: 30 min

**Objective**: Verify PinkieIt DevContainer evolution (3 commits) and plan YokaKit unified implementation with constitutional adaptations

**Steps**:

1. Review PinkieIt DevContainer commits in sequence:
   ```bash
   cd pinkieit

   # Initial implementation (Feb 2025)
   git checkout 0cc04757fa60ad18e1b941206fb9b5a6843f8bd2
   git show 0cc0475 --stat
   git show 0cc0475:.devcontainer/devcontainer.json

   # Optimization (June 2025)
   git checkout 65eea6abe9dfaaf0017ff85e0f0a701edc3c9b81
   git show 65eea6a --stat
   git show 65eea6a:.devcontainer/devcontainer.json

   # Finalization (June 2025)
   git checkout cdd8d6f8e9a6e6db0cabce8e1d7ec0196a743f38
   git show cdd8d6f --stat
   git show cdd8d6f:.devcontainer/devcontainer.json
   ```

2. Identify evolution pattern:
   - [ ] 0cc0475: Basic DevContainer (6 extensions, port 18080, legacy WebSocket 6001)
   - [ ] 65eea6a: Enhanced DevContainer (40+ extensions, separate 'dev' service, port 18081, config/ cleanup)
   - [ ] cdd8d6f: Finalized DevContainer (volume optimization, lifecycle commands, Reverb port 6002)

3. Extract constitutional adaptations needed for YokaKit unified implementation:
   - [ ] `name`: "PinkieIt Development" → "YokaKit Development"
   - [ ] `image`: pinkieit-dev → yokakit-dev
   - [ ] `container_name`: pinkieit-dev → yokakit-dev
   - [ ] `network`: pinkieit → yokakit
   - [ ] `database`: pinkieit → yokakit (SQL Tools connection)
   - [ ] `projectKey`: w-pinkietech_pinkieit → YokaKit SonarLint key
   - [ ] `initializeCommand`: `yes pinkie-it | ./setup.sh` → `yes yokakit | ./setup.sh`
   - [ ] `connectionName`: "PinkieIt Database" → "YokaKit Database"
   - [ ] Codespaces repository: w-pinkietech/pinkieit → YOUR_ORG/YokaKit

4. Document final DevContainer configuration to implement (from cdd8d6f):
   - devcontainer.json: 40+ extensions, PHP 8.2, Laravel 10 settings, YokaKit naming
   - compose.override.yml: yokakit-dev service, port 18081, workspace mounts
   - post-create.sh: Setup automation script
   - Lifecycle commands: init, postCreate, postStart, postAttach

**Reference**: contracts/devcontainer.contract.md

**Validation**:
- [ ] All 3 PinkieIt commits reviewed
- [ ] Evolution pattern documented (basic → enhanced → final)
- [ ] All constitutional adaptations identified (9 naming changes)
- [ ] Final configuration matches cdd8d6f + YokaKit adaptations

---

### T002: Create DevContainer Configuration File

**Type**: Implementation
**Estimated**: 1 hour
**Dependencies**: T001

**Objective**: Create `.devcontainer/devcontainer.json` with YokaKit naming, 40+ extensions, and complete VS Code settings

**Files to Create**:
- `YokaKit/.devcontainer/devcontainer.json`

**Implementation Steps**:

1. Create `.devcontainer/` directory in YokaKit:
   ```bash
   cd YokaKit
   mkdir -p .devcontainer
   ```

2. Create `devcontainer.json` based on PinkieIt commit cdd8d6f with YokaKit adaptations:

**Base on PinkieIt cdd8d6f**, adapt as follows:

```json
{
    "name": "YokaKit Development",  // ← Changed from "PinkieIt Development"
    "dockerComposeFile": [
        "../compose.yml",
        "compose.override.yml"
    ],
    "service": "dev",  // ← Uses separate 'dev' service from compose.override.yml
    "remoteUser": "www-data",
    "workspaceFolder": "/workspace",
    "customizations": {
        "vscode": {
            "extensions": [
                // PHP & Laravel Core
                "bmewburn.vscode-intelephense-client",
                "amiralizadeh9480.laravel-extra-intellisense",
                "onecentlin.laravel-blade",
                "ryannaddy.laravel-artisan",
                "codingyu.laravel-goto-view",
                "open-southeners.laravel-pint",

                // PHP Quality & Testing
                "recca0120.vscode-phpunit",
                "sanderronde.phpstan-vscode",

                // Database
                "mtxr.sqltools",
                "mtxr.sqltools-driver-mysql",

                // Frontend & Assets
                "dbaeumer.vscode-eslint",
                "esbenp.prettier-vscode",
                "bradlc.vscode-tailwindcss",

                // Git & Development
                "eamodio.gitlens",
                "GitHub.vscode-pull-request-github",
                "github.vscode-github-actions",

                // DevOps & Containers
                "ms-azuretools.vscode-docker",
                "ms-vscode-remote.remote-containers",

                // Code Quality & Documentation
                "SonarSource.sonarlint-vscode",
                "streetsidesoftware.code-spell-checker",
                "editorconfig.editorconfig",
                "redhat.vscode-yaml",

                // Environment & Configuration
                "mikestead.dotenv",
                "ms-vscode.vscode-json",

                // AI & Development Assistance
                "anthropic.claude-dev",
                "GitHub.copilot",
                "GitHub.copilot-chat"
            ],
            "settings": {
                // PHP Configuration
                "php.validate.executablePath": "/usr/local/bin/php",
                "intelephense.environment.phpVersion": "8.2.0",
                "intelephense.completion.triggerParameterHints": true,
                "intelephense.diagnostics.enable": true,

                // Laravel Configuration
                "laravel-goto-view.folders": [
                    "resources/views"
                ],
                "laravel_extra_intellisense.baseUrl": "http://localhost:18081",

                // Code Quality
                "phpstan.enabled": true,
                "phpstan.configFile": "./phpstan.neon",
                "sonarlint.connectedMode.project": {
                    "connectionId": "sonarcloud",
                    "projectKey": "YOUR_YOKAKIT_SONARCLOUD_KEY"  // ← Changed from w-pinkietech_pinkieit
                },

                // Editor Settings
                "editor.formatOnSave": true,
                "editor.codeActionsOnSave": {
                    "source.fixAll.eslint": "explicit"
                },
                "files.associations": {
                    "*.blade.php": "blade"
                },

                // Terminal
                "terminal.integrated.defaultProfile.linux": "zsh",

                // File Watching (Laravel-specific)
                "files.watcherExclude": {
                    "**/storage/logs/**": true,
                    "**/bootstrap/cache/**": true,
                    "**/coverage/**": true
                },

                // Database
                "sqltools.connections": [
                    {
                        "name": "YokaKit Database",  // ← Changed from "PinkieIt Database"
                        "driver": "MySQL",
                        "host": "db",
                        "database": "yokakit",  // ← Changed from "pinkieit"
                        "username": "y",
                        "password": "${localEnv:MYSQL_PASSWORD:P=PdZRSzTP1?}"
                    }
                ]
            }
        },
        "codespaces": {
            "repositories": {
                "YOUR_ORG/YokaKit": {  // ← Changed from w-pinkietech/pinkieit
                    "permissions": {
                        "contents": "read",
                        "metadata": "read"
                    }
                }
            },
            "extensions": [/* same as vscode.extensions */],
            "settings": {
                /* same as vscode.settings, but update baseUrl */
                "laravel_extra_intellisense.baseUrl": "https://$CODESPACE_NAME-18081.app.github.dev"
            }
        }
    },
    "forwardPorts": [
        18081,  // DevContainer app port
        6002    // Reverb WebSocket port (external → 6001 internal → 8080 Reverb)
    ],
    "overrideCommand": false,
    "initializeCommand": "chmod +x ./setup.sh && yes yokakit | ./setup.sh",  // ← Changed from yes pinkie-it
    "postCreateCommand": "bash -c ./.devcontainer/post-create.sh",
    "postStartCommand": "php artisan optimize:clear",
    "postAttachCommand": "echo 'DevContainer ready! Application: http://localhost:18081'",
    "features": {
        "ghcr.io/devcontainers/features/github-cli:1": {},
        "ghcr.io/devcontainers/features/docker-outside-of-docker:1": {},
        "ghcr.io/devcontainers/features/common-utils:2": {
            "configureZshAsDefaultShell": true,
            "installOhMyZsh": true,
            "nonFreePackages": true
        }
    }
}
```

3. **IMPORTANT**: Replace placeholder values:
   - `YOUR_YOKAKIT_SONARCLOUD_KEY`: Actual YokaKit SonarCloud project key
   - `YOUR_ORG/YokaKit`: Actual YokaKit GitHub repository URL

**Constitutional Compliance**:
- [ ] Name is "YokaKit Development"
- [ ] SonarLint project key is YokaKit-specific (not w-pinkietech_pinkieit)
- [ ] SQL Tools connection name is "YokaKit Database"
- [ ] Database is "yokakit" (not "pinkieit")
- [ ] initializeCommand uses "yokakit" input
- [ ] Codespaces repository is YOUR_ORG/YokaKit
- [ ] No "pinkieit" references anywhere

**Validation**:
- [ ] File created: `.devcontainer/devcontainer.json`
- [ ] 40+ extensions specified
- [ ] PHP 8.2 settings configured
- [ ] Laravel base URL: http://localhost:18081
- [ ] Ports forwarded: 18081, 6002
- [ ] All YokaKit naming adaptations applied
- [ ] JSON syntax valid (no trailing commas)

**Reference**: contracts/devcontainer.contract.md

---

### T003: Create DevContainer Compose Override

**Type**: Implementation
**Estimated**: 30 min
**Dependencies**: T002

**Objective**: Create `.devcontainer/compose.override.yml` with yokakit-dev service (separate from regular web-app)

**Files to Create**:
- `YokaKit/.devcontainer/compose.override.yml`

**Implementation Steps**:

1. Create `compose.override.yml` based on PinkieIt commit cdd8d6f with YokaKit adaptations:

```yaml
services:
  dev:
    build:
      context: .
      dockerfile: Dockerfile
      target: development  # Multi-stage Dockerfile target from Phase 2
      args:
        ENVIRONMENT: development
    image: yokakit-dev  # ← Changed from pinkieit-dev
    container_name: yokakit-dev  # ← Changed from pinkieit-dev
    user: "www-data:www-data"
    working_dir: /var/www/html
    environment:
      APACHE_LOG_DIR: /var/log/apache2
    depends_on:
      db:
        condition: service_healthy
      mqtt:
        condition: service_started
    command: ["/usr/local/bin/app-entrypoint.sh"]
    volumes:
      - .:/workspace  # Mount project root as workspace
      - ./app/laravel:/var/www/html  # Laravel application
    ports:
      - 18081:80  # Use different port to avoid conflicts with main web-app (18080)
      - 6002:6001  # Reverb WebSocket port
    extra_hosts:
      - host.docker.internal:host-gateway
    networks:
      - yokakit  # ← Changed from pinkieit
```

**Constitutional Compliance**:
- [ ] Image: yokakit-dev (not pinkieit-dev)
- [ ] Container: yokakit-dev (not pinkieit-dev)
- [ ] Network: yokakit (not pinkieit)

**Validation**:
- [ ] File created: `.devcontainer/compose.override.yml`
- [ ] Service name is "dev"
- [ ] Dockerfile target "development" specified (from Phase 2)
- [ ] Port 18081 mapped to container 80 (DevContainer-specific)
- [ ] Port 6002 mapped to container 6001 (Reverb)
- [ ] Dependencies: db (healthy), mqtt (started)
- [ ] Network is "yokakit"
- [ ] YAML syntax valid

**Reference**: contracts/devcontainer.contract.md

---

### T004: Create DevContainer Post-Create Script

**Type**: Implementation
**Estimated**: 20 min
**Dependencies**: T003

**Objective**: Create `.devcontainer/post-create.sh` setup automation script

**Files to Create**:
- `YokaKit/.devcontainer/post-create.sh`

**Implementation Steps**:

1. Create `post-create.sh` based on PinkieIt pattern (from lifecycle commands):

```bash
#!/bin/bash
set -e

echo "🚀 DevContainer post-create setup starting..."

# Navigate to Laravel directory
cd /var/www/html

# Install composer dependencies
echo "📦 Installing Composer dependencies..."
composer install --no-interaction

# Run database migrations
echo "🗄️  Running database migrations..."
php artisan migrate --force

# Generate application key if not exists
if ! grep -q "APP_KEY=" .env; then
    echo "🔑 Generating application key..."
    php artisan key:generate
fi

# Set correct permissions
echo "🔒 Setting permissions..."
chown -R www-data:www-data storage bootstrap/cache

# Clear caches
echo "🧹 Clearing caches..."
php artisan optimize:clear

echo "✅ DevContainer setup complete!"
echo "📍 Application: http://localhost:18081"
```

2. Make script executable:
   ```bash
   chmod +x .devcontainer/post-create.sh
   ```

**Validation**:
- [ ] File created: `.devcontainer/post-create.sh`
- [ ] Script is executable (chmod +x)
- [ ] All commands use --no-interaction or --force flags
- [ ] Permissions set for www-data user
- [ ] Application URL mentions 18081 (DevContainer port)

---

### T005: Verify Dockerfile Development Target

**Type**: Validation
**Estimated**: 10 min
**Dependencies**: T004

**Objective**: Verify YokaKit Dockerfile has "development" target (from Phase 2) for DevContainer

**Steps**:

1. Check Dockerfile for development target:
   ```bash
   cd YokaKit
   grep -A 5 "FROM.*AS development" Dockerfile
   ```

2. If development target missing, verify multi-stage structure:
   ```bash
   grep "^FROM" Dockerfile
   # Expected: Multiple FROM statements (base, build, production, development)
   ```

**Expected Dockerfile Structure** (from Phase 2):
```dockerfile
# Stage 1: base
FROM php:8.2-apache AS base
...

# Stage 2: build
FROM base AS build
...

# Stage 3: production
FROM base AS production
...

# Stage 4: development (for DevContainer)
FROM build AS development
...
```

**Validation**:
- [ ] Dockerfile exists
- [ ] "development" target exists (FROM ... AS development)
- [ ] Development target is suitable for DevContainer (includes build tools, no production optimization)

**If development target missing**: Create as final stage in Dockerfile (reference Phase 2 Docker architecture)

---

### T006: Test DevContainer with VS Code

**Type**: Validation
**Estimated**: 30 min
**Dependencies**: T005

**Objective**: Verify DevContainer opens successfully in VS Code with all extensions installed

**Steps**:

1. Open YokaKit folder in VS Code:
   ```bash
   code YokaKit/
   ```

2. VS Code should detect `.devcontainer/devcontainer.json`:
   - Click "Reopen in Container" notification
   - **OR** use Command Palette: `Ctrl+Shift+P` → "Remote-Containers: Reopen in Container"

3. Wait for DevContainer build (3-5 minutes first time):
   - Monitor output in VS Code terminal
   - Extensions install automatically (40+ extensions)

4. Once opened, verify inside DevContainer terminal:
   ```bash
   # Check PHP version
   php --version
   # Expected: PHP 8.2.x

   # Check Laravel version
   php artisan --version
   # Expected: Laravel Framework 9.x (will upgrade in Phase 4B)

   # Check Composer
   composer --version

   # Check Node.js
   node --version

   # Check npm
   npm --version

   # Check working directory
   pwd
   # Expected: /workspace

   # Check Laravel directory
   ls -la /var/www/html
   # Expected: Laravel application files
   ```

5. Verify VS Code extensions installed:
   - Open Extensions panel: `Ctrl+Shift+X`
   - Check for:
     - Intelephense (PHP)
     - Laravel Blade
     - Laravel Artisan
     - PHPUnit
     - PHPStan
     - SQL Tools
     - SonarLint
     - GitLens
     - Docker
     - Claude Dev
     - GitHub Copilot
     - ... (40+ total)

6. Test SQL Tools connection:
   - `Ctrl+Shift+P` → "SQLTools: Connect"
   - Select "YokaKit Database"
   - Expected: Connection successful, database "yokakit" accessible

7. Verify port forwarding:
   ```bash
   # Inside DevContainer, start Apache (if not already running)
   service apache2 status || service apache2 start

   # From host machine, test application
   curl http://localhost:18081
   # Expected: YokaKit application response (or Laravel welcome page)
   ```

**Validation**:
- [ ] DevContainer builds successfully
- [ ] All 40+ extensions installed and visible in VS Code
- [ ] PHP 8.2.x available in terminal
- [ ] Laravel artisan command works
- [ ] SQL Tools connects to "YokaKit Database"
- [ ] Port 18081 accessible from host machine
- [ ] No "pinkieit" references in DevContainer name or settings

**If issues occur**: Check Docker logs:
```bash
docker logs yokakit-dev
```

---

### T007: Test DevContainer with DevContainers CLI

**Type**: Validation
**Estimated**: 15 min
**Dependencies**: T006

**Objective**: Verify DevContainer works with DevContainers CLI (alternative to VS Code)

**Steps**:

1. Install DevContainers CLI (if not installed):
   ```bash
   npm install -g @devcontainers/cli
   ```

2. Build and start DevContainer:
   ```bash
   cd YokaKit
   devcontainer up --workspace-folder .
   ```

3. Execute commands in DevContainer:
   ```bash
   devcontainer exec --workspace-folder . bash

   # Inside DevContainer:
   php --version  # Should show PHP 8.2.x
   php artisan --version  # Should show Laravel 9.x
   ```

4. Test application inside DevContainer:
   ```bash
   devcontainer exec --workspace-folder . bash -c "service apache2 status"
   # Expected: Apache running

   # Test from host
   curl http://localhost:18081
   # Expected: Application response
   ```

5. Stop DevContainer:
   ```bash
   devcontainer down --workspace-folder .
   ```

**Validation**:
- [ ] DevContainers CLI builds successfully
- [ ] Commands execute in DevContainer
- [ ] PHP 8.2.x available
- [ ] Apache running
- [ ] Port 18081 accessible

---

### T008: Validate Constitutional Compliance

**Type**: Validation
**Estimated**: 15 min
**Dependencies**: T007

**Objective**: Verify zero pinkieit references and YokaKit identity preserved in all DevContainer files

**Steps**:

1. Check for pinkieit references (case-insensitive):
   ```bash
   cd YokaKit
   grep -ri "pinkieit" .devcontainer/ --exclude-dir=vendor --exclude-dir=node_modules
   # Expected: No results
   ```

2. Verify YokaKit naming:
   ```bash
   grep "YokaKit" .devcontainer/devcontainer.json
   # Expected: "name": "YokaKit Development"

   grep "yokakit" .devcontainer/compose.override.yml
   # Expected: image: yokakit-dev, container_name: yokakit-dev, network: yokakit

   grep "yokakit" .devcontainer/devcontainer.json
   # Expected: database: yokakit, initializeCommand with yokakit, etc.
   ```

3. Verify Docker container naming:
   ```bash
   docker ps | grep yokakit
   # Expected: yokakit-dev container running

   docker ps | grep pinkieit
   # Expected: No results
   ```

4. Verify SQL Tools connection:
   ```bash
   grep "YokaKit Database" .devcontainer/devcontainer.json
   # Expected: Found

   grep '"database": "yokakit"' .devcontainer/devcontainer.json
   # Expected: Found
   ```

**Success Criteria**:
- [ ] Zero "pinkieit" references in .devcontainer/
- [ ] DevContainer name is "YokaKit Development"
- [ ] Container name is yokakit-dev
- [ ] Database name is yokakit
- [ ] SQL Tools connection is "YokaKit Database"
- [ ] initializeCommand uses yokakit input
- [ ] Network name is yokakit

---

### T009: Commit CR1 with Audit Trail

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T008

**Objective**: Commit DevContainer unified implementation with PinkieIt references for audit trail

**Steps**:

1. Stage all DevContainer changes:
   ```bash
   cd YokaKit
   git add .devcontainer/
   ```

2. Commit with PinkieIt reference:
   ```bash
   git commit -m "feat: add DevContainer complete implementation (PinkieIt: 0cc0475 + 65eea6a + cdd8d6f)

   Unified DevContainer implementation combining 3 PinkieIt commits:
   - 0cc04757fa60ad18e1b941206fb9b5a6843f8bd2 (2025-02-20, Initial)
   - 65eea6abe9dfaaf0017ff85e0f0a701edc3c9b81 (2025-06-26, Optimization)
   - cdd8d6f8e9a6e6db0cabce8e1d7ec0196a743f38 (2025-06-27, Finalization)

   Constitutional adaptations applied:
   - Name: PinkieIt Development → YokaKit Development
   - Image: pinkieit-dev → yokakit-dev
   - Container: pinkieit-dev → yokakit-dev
   - Database: pinkieit → yokakit
   - Network: pinkieit → yokakit
   - SonarLint: w-pinkietech_pinkieit → YokaKit project key
   - initializeCommand: yes pinkie-it → yes yokakit

   Files created: 3
   - .devcontainer/devcontainer.json (40+ VS Code extensions, PHP 8.2, Laravel 10 settings)
   - .devcontainer/compose.override.yml (yokakit-dev service, port 18081)
   - .devcontainer/post-create.sh (setup automation)

   Phase 4A CR1
   YokaKit identity preserved ✓"
   ```

3. Verify commit:
   ```bash
   git log -1 --stat
   git log -1 --format="%B"
   ```

**Validation**:
- [ ] Commit created successfully
- [ ] Commit message references all 3 PinkieIt hashes
- [ ] Constitutional adaptations documented
- [ ] Phase 4A CR1 noted
- [ ] YokaKit identity preservation confirmed

---

### T010: [P] Create GitHub Story for CR1

**Type**: GitHub Issue
**Estimated**: 10 min
**Dependencies**: T009

**Objective**: Create tracking issue in YokaKit repository for CR1 (DevContainer Complete)

**Steps**:

1. Create Epic issue for Phase 4 (if not exists):
   ```bash
   gh issue create --repo YOUR_ORG/YokaKit \
     --title "[EPIC] Phase 4: Framework Modernization & DevContainer" \
     --label "epic:phase-4,constitutional:identity-preservation" \
     --milestone "Phase 4" \
     --body "$(cat <<'EOF'
   ## Overview

   Phase 4 modernizes YokaKit framework infrastructure through DevContainer environment and framework upgrades (PHP 8.2, Laravel 10, Laravel Reverb).

   ## Implementation Phases

   - **Phase 4A**: DevContainer Complete Environment (CR1)
   - **Phase 4B**: Framework Modernization (CR2-CR6)

   ## PinkieIt Reference

   **Commits**: 0cc0475..cdd8d6f (8 primary commits)
   **Pattern Source**: PinkieIt DevContainer + Framework upgrades

   ## Constitutional Requirements

   - YokaKit naming preserved throughout
   - All commits reference PinkieIt hashes
   - Test suite regression: 0 failures (425/425 baseline)

   ## Success Criteria

   - [x] CR1: DevContainer operational with 40+ extensions
   - [ ] CR2: PHP 8.2 upgrade complete
   - [ ] CR3: Laravel 10 initial upgrade
   - [ ] CR4: Laravel 10 completion (425/425 tests pass)
   - [ ] CR5: Laravel Reverb installed
   - [ ] CR6: Legacy WebSockets removed

   **Status**: 🚧 In Progress (Phase 4A complete, Phase 4B pending)
   EOF
   )"
   ```

2. Create Story issue for CR1:
   ```bash
   gh issue create --repo YOUR_ORG/YokaKit \
     --title "[Story] CR1: DevContainer Complete Implementation" \
     --label "story:phase-4,constitutional:identity-preservation,story:feature" \
     --milestone "Phase 4" \
     --body "$(cat <<'EOF'
   ## PinkieIt Reference

   **Commits** (Unified):
   - `0cc04757fa60ad18e1b941206fb9b5a6843f8bd2` (2025-02-20, Initial)
   - `65eea6abe9dfaaf0017ff85e0f0a701edc3c9b81` (2025-06-26, Optimization)
   - `cdd8d6f8e9a6e6db0cabce8e1d7ec0196a743f38` (2025-06-27, Finalization)

   **Files**: 3 files (devcontainer.json, compose.override.yml, post-create.sh)

   ## Implementation

   Tasks:
   - [x] T001: Analyze DevContainer unified implementation
   - [x] T002: Create devcontainer.json with YokaKit naming
   - [x] T003: Create compose.override.yml with yokakit-dev service
   - [x] T004: Create post-create.sh setup script
   - [x] T005: Verify Dockerfile development target
   - [x] T006: Test DevContainer with VS Code
   - [x] T007: Test DevContainer with DevContainers CLI
   - [x] T008: Validate constitutional compliance
   - [x] T009: Commit CR1 with audit trail

   ## Constitutional Compliance

   - [x] Name: "YokaKit Development"
   - [x] Image: yokakit-dev
   - [x] Container: yokakit-dev
   - [x] Database: yokakit
   - [x] Network: yokakit
   - [x] SonarLint: YokaKit project key
   - [x] initializeCommand: yokakit input
   - [x] No pinkieit references

   ## Validation

   - [x] DevContainer builds successfully in VS Code
   - [x] All 40+ extensions installed
   - [x] PHP 8.2.x available
   - [x] SQL Tools connects to "YokaKit Database"
   - [x] Port 18081 accessible
   - [x] DevContainers CLI validation passed
   - [x] Zero constitutional violations

   ## Unified Implementation Note

   YokaKit implements the **final evolved form** of DevContainer from day one, combining insights from all 3 PinkieIt commits. No intermediate versions needed since YokaKit Phase 2 Docker is already complete.

   **Status**: ✅ Complete (see commit {yokakit_commit_hash})
   EOF
   )"
   ```

3. Link Story to Epic:
   ```bash
   # Get issue numbers
   EPIC_NUMBER=$(gh issue list --repo YOUR_ORG/YokaKit --label "epic:phase-4" --limit 1 --json number --jq '.[0].number')
   STORY_NUMBER=$(gh issue list --repo YOUR_ORG/YokaKit --label "story:phase-4" --limit 1 --json number --jq '.[0].number')

   # Link Story to Epic
   gh issue comment $STORY_NUMBER --repo YOUR_ORG/YokaKit \
     --body "Part of Epic #$EPIC_NUMBER"
   ```

**Validation**:
- [ ] Epic issue created (if needed)
- [ ] Story issue created with correct labels
- [ ] Linked to Phase 4 milestone
- [ ] Referenced in Epic
- [ ] All tasks marked complete

**Note**: Replace `YOUR_ORG/YokaKit` with actual GitHub repository URL

---

## PHASE 4B: Framework Modernization

**Prerequisites**: Phase 4A complete (DevContainer operational)

**Execution Strategy**: All framework upgrades performed **inside DevContainer** environment to ensure consistency and leverage pre-configured quality tools.

---

## COMMIT REPLAY 2: PHP 8.2 Upgrade

**PinkieIt Commit**: `e0eaabdc98a333c799e4ad8b2de321f369a9562f`
**Date**: 2025-06-17
**Files**: 4 files (composer.json, composer.lock, sonarqube.yml, CLAUDE.md)
**Constitutional**: None (no PinkieIt-specific content)

### Story/Issue Reference
- **YokaKit Epic**: #{epic_number} (Phase 4: Framework Modernization & DevContainer)
- **YokaKit Story**: #TBD (CR2: PHP 8.2 Upgrade)

---

### T011: Analyze PHP 8.2 Upgrade

**Type**: Preparation
**Estimated**: 15 min

**Objective**: Verify PinkieIt PHP 8.2 upgrade commit and plan YokaKit implementation

**Steps**:

1. Review PinkieIt commit:
   ```bash
   cd pinkieit
   git checkout e0eaabdc98a333c799e4ad8b2de321f369a9562f
   git show e0eaabd --stat
   git show e0eaabd
   ```

2. Identify changes:
   - [ ] composer.json: PHP requirement ^8.1.0 → ^8.2.0
   - [ ] composer.json: nunomaduro/larastan → larastan/larastan (package migration)
   - [ ] composer.lock: Full dependency update for PHP 8.2
   - [ ] .github/workflows/sonarqube.yml: PHP version 8.1 → 8.2
   - [ ] CLAUDE.md: Documentation update (PHP 8.2 requirement)

3. Verify YokaKit preconditions:
   - [ ] Dockerfile already uses php:8.2.27-apache (from Phase 2)
   - [ ] DevContainer configured for PHP 8.2 (from Phase 4A)

**Validation**:
- [ ] All changes identified
- [ ] No constitutional adaptations needed (generic PHP upgrade)
- [ ] YokaKit Docker already on PHP 8.2 (just need composer update)

**Reference**: contracts/composer.contract.md

---

### T012: Update Composer PHP Requirement

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T011

**Objective**: Update `composer.json` to require PHP ^8.2.0

**Files to Modify**:
- `YokaKit/app/laravel/composer.json`

**Implementation Steps**:

1. Open DevContainer in VS Code (recommended) or regular container:
   ```bash
   # In VS Code: Reopen in Container
   # OR
   cd YokaKit
   docker compose exec web-app bash
   # OR (if using DevContainer)
   docker compose -f compose.yml -f .devcontainer/compose.override.yml exec dev bash
   ```

2. Inside container, update composer.json:
   ```bash
   cd /var/www/html  # (or /workspace/app/laravel if in DevContainer)

   # Backup original
   cp composer.json composer.json.bak

   # Update PHP requirement
   # Change "php": "^8.1.0" to "php": "^8.2.0"
   ```

**Edit `app/laravel/composer.json`**:
```json
{
    "require": {
        "php": "^8.2.0",  // ← Changed from ^8.1.0
        // ... other dependencies remain unchanged for now
    }
}
```

**Validation**:
- [ ] composer.json updated
- [ ] PHP requirement is ^8.2.0

---

### T013: Migrate Larastan Package

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T012

**Objective**: Replace deprecated nunomaduro/larastan with larastan/larastan

**Files to Modify**:
- `YokaKit/app/laravel/composer.json`

**Implementation Steps**:

1. Update composer.json require-dev section:

**Edit `app/laravel/composer.json`**:
```json
{
    "require-dev": {
        "larastan/larastan": "^2.0",  // ← Changed from "nunomaduro/larastan": "^2.0"
        // ... other dev dependencies
    }
}
```

**Validation**:
- [ ] composer.json updated
- [ ] Larastan package is larastan/larastan (not nunomaduro/larastan)

---

### T014: Run Composer Update for PHP 8.2

**Type**: Implementation
**Estimated**: 30 min
**Dependencies**: T013

**Objective**: Run `composer update` to resolve all dependencies for PHP 8.2

**Steps**:

1. Inside DevContainer or container, run composer update:
   ```bash
   cd /var/www/html

   # Clear composer cache
   composer clear-cache

   # Update dependencies
   composer update

   # Expected: All dependencies resolve for PHP 8.2
   # composer.lock will be regenerated
   ```

2. Verify PHP 8.2 is active:
   ```bash
   php --version
   # Expected: PHP 8.2.x

   composer show php
   # Expected: PHP ^8.2.0 required
   ```

3. Verify Larastan package:
   ```bash
   composer show larastan/larastan
   # Expected: Package found, version 2.x

   composer show nunomaduro/larastan
   # Expected: Package not found (removed)
   ```

**Validation**:
- [ ] Composer update completes successfully
- [ ] No dependency conflicts
- [ ] composer.lock updated
- [ ] PHP 8.2.x active
- [ ] Larastan 2.x installed
- [ ] nunomaduro/larastan NOT in composer.lock

---

### T015: Update CI/CD Workflow

**Type**: Implementation
**Estimated**: 10 min
**Dependencies**: T014

**Objective**: Update GitHub Actions workflow to use PHP 8.2

**Files to Modify**:
- `YokaKit/.github/workflows/sonarqube.yml` (or equivalent test workflow)

**Implementation Steps**:

1. Edit SonarQube workflow:

**Edit `.github/workflows/sonarqube.yml`**:
```yaml
- name: Setup PHP
  uses: shivammathur/setup-php@v2
  with:
    php-version: '8.2'  # ← Changed from '8.1'
    extensions: mbstring, xml, ctype, iconv, intl, pdo_mysql
    coverage: pcov
```

2. If other workflows reference PHP version, update those as well:
   ```bash
   grep -r "php-version: '8.1'" .github/workflows/
   # Update all matches to 8.2
   ```

**Validation**:
- [ ] SonarQube workflow uses PHP 8.2
- [ ] All GitHub Actions workflows updated

---

### T016: Validate PHP 8.2 Upgrade

**Type**: Validation
**Estimated**: 30 min
**Dependencies**: T015

**Objective**: Verify PHP 8.2 upgrade successful and all tests pass

**Steps**:

1. Run test suite (inside DevContainer):
   ```bash
   cd /var/www/html
   php artisan test

   # Expected: 425/425 tests passing (Phase 3 baseline)
   ```

2. Run static analysis:
   ```bash
   vendor/bin/phpstan analyse
   # Expected: No errors (Larastan compatible with PHP 8.2)
   ```

3. Run code formatting:
   ```bash
   vendor/bin/pint
   # Expected: No changes needed (or minor formatting)
   ```

4. Verify no deprecated PHP 8.1 features:
   ```bash
   # Check for common PHP 8.1 deprecations
   grep -r "create_function" app/
   # Expected: No results (deprecated in PHP 8.0, removed in 8.2)
   ```

5. Test application:
   ```bash
   # Start services (if not already running)
   php artisan serve --host=0.0.0.0 --port=8000 &

   # Test homepage
   curl http://localhost:8000
   # Expected: Application response
   ```

**Success Criteria**:
- [ ] All 425 tests passing
- [ ] PHPStan analysis passes
- [ ] Laravel Pint formatting clean
- [ ] No deprecated PHP 8.1 features
- [ ] Application runs successfully

---

### T017: Commit CR2 with Audit Trail

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T016

**Objective**: Commit PHP 8.2 upgrade with PinkieIt reference

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add app/laravel/composer.json app/laravel/composer.lock .github/workflows/
   ```

2. Commit:
   ```bash
   git commit -m "feat: upgrade project to PHP 8.2 (PinkieIt: e0eaabd)

   Replay of PinkieIt commit e0eaabdc98a333c799e4ad8b2de321f369a9562f

   - Update composer.json PHP requirement: ^8.1.0 → ^8.2.0
   - Replace deprecated nunomaduro/larastan with larastan/larastan ^2.0
   - Update composer dependencies for PHP 8.2 compatibility
   - Update CI/CD workflow to use PHP 8.2 in GitHub Actions

   Constitutional adaptations: None (generic PHP upgrade)

   Files changed: 3
   - app/laravel/composer.json (PHP requirement, Larastan package)
   - app/laravel/composer.lock (full dependency update)
   - .github/workflows/sonarqube.yml (PHP version)

   Test validation: 425/425 tests passing ✓
   Static analysis: PHPStan passing ✓

   Phase 4B CR2
   YokaKit identity preserved ✓"
   ```

**Validation**:
- [ ] Commit created
- [ ] References PinkieIt hash e0eaabd
- [ ] Test results documented
- [ ] Phase 4B CR2 noted

---

## COMMIT REPLAY 3: Laravel 10 Initial Upgrade

**PinkieIt Commit**: `4152b54f7399c29e4f2570517cdb429db5956710`
**Date**: 2025-06-17
**Files**: 6 files (composer.json, composer.lock, phpunit.xml, CustomizeFormatter.php, .gitignore, CLAUDE.md)
**Constitutional**: None (framework upgrade, no naming)

### Story/Issue Reference
- **YokaKit Epic**: #{epic_number}
- **YokaKit Story**: #TBD (CR3: Laravel 10 Initial Upgrade)

---

### T018: Analyze Laravel 10 Initial Upgrade

**Type**: Preparation
**Estimated**: 20 min

**Objective**: Verify PinkieIt Laravel 10 initial upgrade and plan YokaKit implementation

**Steps**:

1. Review PinkieIt commit:
   ```bash
   cd pinkieit
   git checkout 4152b54f7399c29e4f2570517cdb429db5956710
   git show 4152b54 --stat
   git show 4152b54
   ```

2. Identify package upgrades:
   - [ ] laravel/framework: ^9.19 → ^10.0
   - [ ] laravel/sanctum: ^2.14 → ^3.2
   - [ ] laravel/ui: ^3.4 → ^4.0
   - [ ] phpunit/phpunit: ^9.5.10 → ^10.0
   - [ ] laravel/dusk: ^6.25 → ^7.0
   - [ ] nunomaduro/collision: ^6.1 → ^7.0
   - [ ] spatie/laravel-ignition: ^1.0 → ^2.0

3. Identify code changes:
   - [ ] app/Logging/CustomizeFormatter.php: Monolog 3.x compatibility
   - [ ] phpunit.xml: PHPUnit 10.5 schema migration
   - [ ] .gitignore: Add .phpunit.cache/ directory

4. Note expected behavior:
   - Tests: ~95% passing (CSRF issues expected, fixed in CR4)
   - Core functionality: Operational
   - Test fixes: Deferred to CR4 (commit 862d537)

**Validation**:
- [ ] All package upgrades identified
- [ ] Code changes documented
- [ ] Expected test behavior noted (not 100% yet)

**Reference**: contracts/composer.contract.md

---

### T019: Update Laravel Framework Packages

**Type**: Implementation
**Estimated**: 20 min
**Dependencies**: T018

**Objective**: Update composer.json with Laravel 10 package versions

**Files to Modify**:
- `YokaKit/app/laravel/composer.json`

**Implementation Steps**:

**Edit `app/laravel/composer.json`**:

```json
{
    "require": {
        "php": "^8.2.0",
        "laravel/framework": "^10.0",  // ← Changed from ^9.19
        "laravel/sanctum": "^3.2",     // ← Changed from ^2.14
        "laravel/ui": "^4.0",          // ← Changed from ^3.4
        // ... other dependencies
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0",                   // ← Changed from ^9.5.10
        "laravel/dusk": "^7.0",                       // ← Changed from ^6.25
        "nunomaduro/collision": "^7.0",               // ← Changed from ^6.1
        "spatie/laravel-ignition": "^2.0",            // ← Changed from ^1.0
        "larastan/larastan": "^2.0",  // (already updated in CR2)
        // ... other dev dependencies
    }
}
```

**Validation**:
- [ ] Laravel Framework: ^10.0
- [ ] Sanctum: ^3.2
- [ ] UI: ^4.0
- [ ] PHPUnit: ^10.0
- [ ] Dusk: ^7.0
- [ ] Collision: ^7.0
- [ ] Ignition: ^2.0

---

### T020: Run Composer Update for Laravel 10

**Type**: Implementation
**Estimated**: 30 min
**Dependencies**: T019

**Objective**: Run composer update to install Laravel 10 packages

**Steps**:

1. Inside DevContainer, run composer update:
   ```bash
   cd /var/www/html
   composer update

   # This may take 5-10 minutes
   # Expected: Laravel 10.48.29+ installed
   ```

2. Verify Laravel 10 installation:
   ```bash
   php artisan --version
   # Expected: Laravel Framework 10.48.x or later

   composer show laravel/framework
   # Expected: 10.x version

   composer show laravel/sanctum
   # Expected: 3.x version

   composer show phpunit/phpunit
   # Expected: 10.x version
   ```

**Validation**:
- [ ] Composer update completes successfully
- [ ] Laravel 10.48.x+ installed
- [ ] Sanctum 3.x installed
- [ ] PHPUnit 10.x installed

---

### T021: Migrate PHPUnit XML to 10.5 Schema

**Type**: Implementation
**Estimated**: 20 min
**Dependencies**: T020

**Objective**: Update phpunit.xml to PHPUnit 10.5 schema

**Files to Modify**:
- `YokaKit/app/laravel/phpunit.xml`

**Implementation Steps**:

1. Review PinkieIt phpunit.xml structure:
   ```bash
   cd pinkieit
   git show 4152b54:app/laravel/phpunit.xml | head -20
   ```

2. Update YokaKit phpunit.xml:

**Edit `app/laravel/phpunit.xml`**:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="vendor/phpunit/phpunit/phpunit.xsd"
         bootstrap="vendor/autoload.php"
         colors="true">
    <testsuites>
        <testsuite name="Unit">
            <directory>tests/Unit</directory>
        </testsuite>
        <testsuite name="Feature">
            <directory>tests/Feature</directory>
        </testsuite>
    </testsuites>
    <source>
        <include>
            <directory>app</directory>
        </include>
    </source>
    <php>
        <env name="APP_ENV" value="testing"/>
        <env name="BCRYPT_ROUNDS" value="4"/>
        <env name="CACHE_DRIVER" value="array"/>
        <env name="DB_CONNECTION" value="sqlite"/>
        <env name="DB_DATABASE" value=":memory:"/>
        <env name="MAIL_MAILER" value="array"/>
        <env name="QUEUE_CONNECTION" value="sync"/>
        <env name="SESSION_DRIVER" value="array"/>
        <env name="TELESCOPE_ENABLED" value="false"/>
    </php>
</phpunit>
```

**Key Changes** (PHPUnit 9 → 10):
- Schema: `vendor/phpunit/phpunit/phpunit.xsd` (PHPUnit 10.5)
- `<source>` instead of `<coverage>` (PHPUnit 10 syntax)
- `<include>` instead of `<whitelist>` (PHPUnit 10 syntax)

**Validation**:
- [ ] Schema updated to PHPUnit 10.5
- [ ] Test suites defined (Unit, Feature)
- [ ] Source coverage configured
- [ ] Environment variables set

---

### T022: Update Monolog Formatter for 3.x Compatibility

**Type**: Implementation
**Estimated**: 30 min
**Dependencies**: T021

**Objective**: Fix app/Logging/CustomizeFormatter.php for Monolog 3.x (Laravel 10 dependency)

**Files to Modify**:
- `YokaKit/app/laravel/app/Logging/CustomizeFormatter.php`

**Implementation Steps**:

1. Review PinkieIt changes:
   ```bash
   cd pinkieit
   git show 4152b54:app/laravel/app/Logging/CustomizeFormatter.php
   ```

2. Update YokaKit CustomizeFormatter.php for Monolog 3.x:

**Key Changes**:
- Monolog 3.x uses different method signatures
- LogRecord class may have different properties
- Formatter inheritance may need updates

**Edit `app/laravel/app/Logging/CustomizeFormatter.php`**:

(Apply changes from PinkieIt commit 4152b54 - check actual diff for exact implementation)

**Validation**:
- [ ] File updated for Monolog 3.x
- [ ] No syntax errors
- [ ] Formatter compatible with Laravel 10

---

### T023: Update .gitignore for PHPUnit Cache

**Type**: Implementation
**Estimated**: 5 min
**Dependencies**: T022

**Objective**: Add `.phpunit.cache/` to .gitignore

**Files to Modify**:
- `YokaKit/app/laravel/.gitignore`

**Implementation Steps**:

**Edit `app/laravel/.gitignore`**, add:
```
.phpunit.cache/
```

**Validation**:
- [ ] .gitignore updated
- [ ] .phpunit.cache/ entry added

---

### T024: Run Laravel 10 Initial Tests

**Type**: Validation
**Estimated**: 30 min
**Dependencies**: T023

**Objective**: Run test suite and verify Laravel 10 core functionality (expect some failures)

**Steps**:

1. Run test suite:
   ```bash
   cd /var/www/html
   php artisan test
   ```

**Expected Results** (from PinkieIt experience):
- Core unit tests: ~95% passing (199/208 unit tests in PinkieIt)
- Feature tests: Some failures due to CSRF token issues (expected)
- Total: Not 100% yet (fixes in CR4)

2. Verify core functionality:
   ```bash
   # Clear caches
   php artisan optimize:clear

   # Check routes
   php artisan route:list

   # Test database connection
   php artisan migrate:status
   ```

3. Check for critical errors:
   ```bash
   # Start application
   php artisan serve --host=0.0.0.0 --port=8000 &

   # Test basic routes
   curl http://localhost:8000
   # Expected: Application response (may have minor issues)
   ```

**Success Criteria**:
- [ ] Laravel 10 framework installed successfully
- [ ] Core unit tests ~95% passing
- [ ] Application starts without critical errors
- [ ] Some feature test failures (CSRF) are expected and OK

**Note**: Full test pass (425/425) will be achieved in CR4 (commit 862d537)

---

### T025: Commit CR3 with Audit Trail

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T024

**Objective**: Commit Laravel 10 initial upgrade

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add app/laravel/composer.json app/laravel/composer.lock \
     app/laravel/phpunit.xml app/laravel/app/Logging/CustomizeFormatter.php \
     app/laravel/.gitignore
   ```

2. Commit:
   ```bash
   git commit -m "feat: upgrade Laravel framework from 9.x to 10.x (PinkieIt: 4152b54)

   Replay of PinkieIt commit 4152b54f7399c29e4f2570517cdb429db5956710

   Framework upgrades:
   - laravel/framework: ^9.19 → ^10.0 (version 10.48.29+)
   - laravel/sanctum: ^2.14 → ^3.2
   - laravel/ui: ^3.4 → ^4.0

   Test framework upgrades:
   - phpunit/phpunit: ^9.5.10 → ^10.0
   - laravel/dusk: ^6.25 → ^7.0
   - nunomaduro/collision: ^6.1 → ^7.0
   - spatie/laravel-ignition: ^1.0 → ^2.0

   Code changes:
   - Fix Monolog 3.x compatibility in CustomizeFormatter
   - Migrate PHPUnit XML configuration to new schema (PHPUnit 10.5)
   - Add PHPUnit cache directory to .gitignore

   Constitutional adaptations: None (framework upgrade)

   Files changed: 5
   - app/laravel/composer.json (package versions)
   - app/laravel/composer.lock (dependency resolution)
   - app/laravel/phpunit.xml (PHPUnit 10 schema)
   - app/laravel/app/Logging/CustomizeFormatter.php (Monolog 3.x)
   - app/laravel/.gitignore (.phpunit.cache/)

   Test status: Core unit tests ~95% passing, some feature test failures expected
   Note: Full test fixes in CR4 (commit 862d537)

   Phase 4B CR3
   YokaKit identity preserved ✓"
   ```

**Validation**:
- [ ] Commit created
- [ ] References PinkieIt hash 4152b54
- [ ] Test status documented (not 100% yet)
- [ ] Note about CR4 test fixes included

---

## COMMIT REPLAY 4: Laravel 10 Completion

**PinkieIt Commit**: `862d5379a95a58b0274f2cba0ee15c53cd6f042f`
**Date**: 2025-06-17
**Files**: 9 files (AdminLTE, Sanctum migration, datatable component, test fixes)
**Constitutional**: None (test fixes, no naming)

### Story/Issue Reference
- **YokaKit Epic**: #{epic_number}
- **YokaKit Story**: #TBD (CR4: Laravel 10 Completion)

---

### T026: Analyze Laravel 10 Completion

**Type**: Preparation
**Estimated**: 20 min

**Objective**: Verify PinkieIt Laravel 10 completion commit (test fixes, AdminLTE)

**Steps**:

1. Review PinkieIt commit:
   ```bash
   cd pinkieit
   git checkout 862d5379a95a58b0274f2cba0ee15c53cd6f042f
   git show 862d537 --stat
   git show 862d537
   ```

2. Identify changes:
   - [ ] AdminLTE: 3.8 → 3.15 (composer.json)
   - [ ] Sanctum 3.x migration: Add expires_at column to personal_access_tokens
   - [ ] Datatable component: Fix AdminLTE integration (datatable-index.blade.php)
   - [ ] Test fixes: CSRF middleware bypass, authentication handling
   - [ ] Result: 591/591 tests passing (PinkieIt), expect 425/425 for YokaKit

3. Map test fixes to YokaKit (YokaKit has 425 tests from Phase 3):
   - [ ] BaseControllerTest: Add withoutMiddleware()
   - [ ] WorkerControllerTest: Fix form validation
   - [ ] HomeControllerTest: Fix authentication
   - [ ] Laravel10CompatibilityTest: Environment-specific assertions

**Validation**:
- [ ] All changes identified
- [ ] Test fix patterns understood
- [ ] AdminLTE upgrade noted

**Reference**: contracts/composer.contract.md

---

### T027: Update AdminLTE Package

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T026

**Objective**: Update AdminLTE from 3.8 to 3.15

**Files to Modify**:
- `YokaKit/app/laravel/composer.json`

**Implementation Steps**:

**Edit `app/laravel/composer.json`**:
```json
{
    "require": {
        "jeroennoten/laravel-adminlte": "^3.15"  // ← Changed from ^3.8 (if exists)
        // or add if not present
    }
}
```

Run composer update:
```bash
cd /var/www/html
composer update jeroennoten/laravel-adminlte
```

**Validation**:
- [ ] AdminLTE 3.15+ installed
- [ ] No conflicts

---

### T028: Create Sanctum 3.x Migration

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T027

**Objective**: Create migration to add expires_at column to personal_access_tokens (Sanctum 3.x requirement)

**Files to Create**:
- `YokaKit/app/laravel/database/migrations/2025_06_17_add_expires_at_to_personal_access_tokens.php`

**Implementation Steps**:

1. Create migration file:
   ```bash
   cd /var/www/html
   php artisan make:migration add_expires_at_to_personal_access_tokens
   ```

2. Edit migration file:

**Migration content** (from PinkieIt commit 862d537):
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->timestamp('expires_at')->nullable()->after('abilities');
        });
    }

    public function down(): void
    {
        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->dropColumn('expires_at');
        });
    }
};
```

3. Run migration:
   ```bash
   php artisan migrate
   ```

**Validation**:
- [ ] Migration file created
- [ ] Migration runs successfully
- [ ] expires_at column added to personal_access_tokens table

---

### T029: Fix AdminLTE Datatable Component

**Type**: Implementation
**Estimated**: 20 min
**Dependencies**: T028

**Objective**: Fix datatable-index.blade.php for AdminLTE 3.15 compatibility

**Files to Modify**:
- `YokaKit/app/laravel/resources/views/components/datatable-index.blade.php`

**Implementation Steps**:

1. Review PinkieIt fix:
   ```bash
   cd pinkieit
   git show 862d537:app/laravel/resources/views/components/datatable-index.blade.php
   ```

2. Apply fixes to YokaKit file (check actual changes in PinkieIt commit)

**Key Changes** (based on commit message):
- Proper `:heads` and `:config` attribute passing to `<x-adminlte-datatable>`
- Conditional rendering improvements

**Validation**:
- [ ] Component file updated
- [ ] AdminLTE datatable renders correctly

---

### T030: Apply Test Fixes for Laravel 10

**Type**: Implementation
**Estimated**: 1 hour
**Dependencies**: T029

**Objective**: Fix all test failures (CSRF, authentication) to achieve 425/425 passing

**Files to Modify**:
- `YokaKit/app/laravel/tests/Feature/Controllers/BaseControllerTest.php`
- `YokaKit/app/laravel/tests/Feature/Controllers/WorkerControllerTest.php`
- `YokaKit/app/laravel/tests/Feature/HomeControllerTest.php`
- `YokaKit/app/laravel/tests/Feature/Laravel10CompatibilityTest.php`
- Other test files as needed

**Implementation Steps**:

1. **BaseControllerTest**: Add CSRF middleware bypass:

**Edit `tests/Feature/Controllers/BaseControllerTest.php`**:
```php
class BaseControllerTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->withoutMiddleware();  // ← Add this line (CSRF bypass)
    }

    // ... rest of test
}
```

2. **WorkerControllerTest**: Fix form validation:

Review PinkieIt changes:
```bash
cd pinkieit
git show 862d537:app/laravel/tests/Feature/Controllers/WorkerControllerTest.php
```

Apply redirect chain assertions and proper CSRF handling

3. **HomeControllerTest**: Fix authentication:

Add CSRF token handling for authenticated routes

4. **Laravel10CompatibilityTest**: Fix environment-specific assertions:

Adjust assertions for different config values in local vs CI environments

5. Review all test files for similar issues:
   ```bash
   cd /var/www/html
   php artisan test
   # Identify remaining failures, apply fixes
   ```

**Validation**:
- [ ] All test files updated
- [ ] CSRF issues resolved
- [ ] Authentication issues resolved

---

### T031: Validate Laravel 10 Complete

**Type**: Validation
**Estimated**: 30 min
**Dependencies**: T030

**Objective**: Verify 425/425 tests passing and Laravel 10 fully functional

**Steps**:

1. Run full test suite:
   ```bash
   cd /var/www/html
   php artisan test

   # Expected: 425/425 tests passing (100%)
   ```

2. Run parallel tests:
   ```bash
   php artisan test --parallel --processes=4

   # Expected: Same results, faster execution
   ```

3. Verify AdminLTE components:
   ```bash
   # Test AdminLTE datatable rendering
   # (check via browser or functional test)
   ```

4. Verify Sanctum 3.x:
   ```bash
   # Check personal_access_tokens table
   php artisan tinker
   >>> \DB::table('personal_access_tokens')->first()
   # Expected: expires_at column present
   ```

5. Run static analysis:
   ```bash
   vendor/bin/phpstan analyse
   # Expected: No errors
   ```

**Success Criteria**:
- [ ] 425/425 tests passing (100%)
- [ ] Parallel execution works
- [ ] AdminLTE 3.15 components functional
- [ ] Sanctum 3.x migration applied
- [ ] PHPStan analysis passes
- [ ] Application fully operational

---

### T032: Commit CR4 with Audit Trail

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T031

**Objective**: Commit Laravel 10 completion

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add app/laravel/composer.json app/laravel/composer.lock \
     app/laravel/database/migrations/ \
     app/laravel/resources/views/components/datatable-index.blade.php \
     app/laravel/tests/
   ```

2. Commit:
   ```bash
   git commit -m "feat: complete Laravel 10 upgrade with test fixes (PinkieIt: 862d537)

   Replay of PinkieIt commit 862d5379a95a58b0274f2cba0ee15c53cd6f042f

   Major changes:
   - Upgrade AdminLTE from 3.8 to 3.15 for Laravel 10 compatibility
   - Add Sanctum 3.x migration (expires_at column to personal_access_tokens)
   - Fix AdminLTE datatable component integration
   - Fix all CSRF token issues across feature tests
   - Fix authentication handling in tests
   - Fix Laravel10CompatibilityTest configuration assertions

   Constitutional adaptations: None (test infrastructure)

   Files changed: 9
   - app/laravel/composer.json (AdminLTE 3.15)
   - app/laravel/composer.lock (dependency update)
   - app/laravel/database/migrations/*_add_expires_at_to_personal_access_tokens.php (NEW)
   - app/laravel/resources/views/components/datatable-index.blade.php (AdminLTE fix)
   - app/laravel/tests/Feature/Controllers/BaseControllerTest.php (CSRF bypass)
   - app/laravel/tests/Feature/Controllers/WorkerControllerTest.php (form validation)
   - app/laravel/tests/Feature/HomeControllerTest.php (authentication)
   - app/laravel/tests/Feature/Laravel10CompatibilityTest.php (environment assertions)
   - (other test files as needed)

   Test validation: 425/425 tests passing (100%) ✓
   Laravel 10 framework fully compatible ✓
   AdminLTE 3.15 properly integrated ✓
   Production-ready Laravel 10 upgrade complete ✓

   Phase 4B CR4
   YokaKit identity preserved ✓"
   ```

**Validation**:
- [ ] Commit created
- [ ] References PinkieIt hash 862d537
- [ ] All test results documented (425/425 passing)
- [ ] Laravel 10 completion confirmed

---

## COMMIT REPLAY 5: Laravel Reverb Installation

**PinkieIt Commit**: `d4db04f46e8e8edc3c684288546ea7aad7a0e8b4`
**Date**: 2025-06-18
**Files**: 4 files (composer.json, composer.lock, broadcasting.php, reverb.php)
**Constitutional**: None (Reverb is framework-agnostic)

### Story/Issue Reference
- **YokaKit Epic**: #{epic_number}
- **YokaKit Story**: #TBD (CR5: Laravel Reverb Installation)

---

### T033: Analyze Laravel Reverb Installation

**Type**: Preparation
**Estimated**: 15 min

**Objective**: Verify PinkieIt Reverb installation and plan YokaKit implementation

**Steps**:

1. Review PinkieIt commit:
   ```bash
   cd pinkieit
   git checkout d4db04f46e8e8edc3c684288546ea7aad7a0e8b4
   git show d4db04f --stat
   git show d4db04f
   ```

2. Identify changes:
   - [ ] composer.json: Add laravel/reverb ^1.4
   - [ ] composer.lock: Reverb package installation
   - [ ] config/broadcasting.php: Add 'reverb' connection
   - [ ] config/reverb.php: Complete Reverb server configuration (93 lines)

3. Identify environment variables needed:
   - REVERB_APP_ID
   - REVERB_APP_KEY
   - REVERB_APP_SECRET
   - REVERB_HOST
   - REVERB_PORT
   - REVERB_SCHEME

**Validation**:
- [ ] All files identified
- [ ] No constitutional adaptations needed (Reverb configuration is generic)

**Reference**: contracts/reverb.contract.md

---

### T034: Install Laravel Reverb Package

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T033

**Objective**: Add laravel/reverb package to composer.json and install

**Files to Modify**:
- `YokaKit/app/laravel/composer.json`

**Implementation Steps**:

1. Add Reverb to composer.json:

**Edit `app/laravel/composer.json`**:
```json
{
    "require": {
        "laravel/reverb": "^1.4"  // ← Add this line
        // ... other dependencies
    }
}
```

2. Install package:
   ```bash
   cd /var/www/html
   composer update laravel/reverb
   ```

3. Verify installation:
   ```bash
   composer show laravel/reverb
   # Expected: 1.4.x or later
   ```

**Validation**:
- [ ] composer.json updated
- [ ] laravel/reverb installed (version 1.4+)

---

### T035: Publish Reverb Configuration

**Type**: Implementation
**Estimated**: 10 min
**Dependencies**: T034

**Objective**: Create config/reverb.php configuration file

**Files to Create**:
- `YokaKit/app/laravel/config/reverb.php`

**Implementation Steps**:

1. Publish Reverb config:
   ```bash
   cd /var/www/html
   php artisan vendor:publish --provider="Laravel\Reverb\ReverbServiceProvider" --tag=config
   ```

   OR manually create file from PinkieIt:

2. Review PinkieIt config:
   ```bash
   cd pinkieit
   git show d4db04f:app/laravel/config/reverb.php > /tmp/reverb.php
   cat /tmp/reverb.php
   ```

3. Copy to YokaKit (no adaptations needed):
   ```bash
   cp /tmp/reverb.php YokaKit/app/laravel/config/reverb.php
   ```

**Expected File**: 93 lines with server and app configuration (see contracts/reverb.contract.md for full content)

**Validation**:
- [ ] File exists: config/reverb.php
- [ ] File is 93 lines (matches PinkieIt)
- [ ] Server configuration present
- [ ] App configuration present

**Reference**: contracts/reverb.contract.md

---

### T036: Add Reverb Broadcasting Connection

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T035

**Objective**: Add 'reverb' connection to config/broadcasting.php

**Files to Modify**:
- `YokaKit/app/laravel/config/broadcasting.php`

**Implementation Steps**:

1. Review PinkieIt changes:
   ```bash
   cd pinkieit
   git show d4db04f:app/laravel/config/broadcasting.php
   ```

2. Edit YokaKit broadcasting.php:

**Edit `app/laravel/config/broadcasting.php`**, add 'reverb' connection:

```php
'connections' => [

    // ... existing connections (pusher, ably, log, null)

    'reverb' => [
        'driver' => 'reverb',
        'key' => env('REVERB_APP_KEY'),
        'secret' => env('REVERB_APP_SECRET'),
        'app_id' => env('REVERB_APP_ID'),
        'options' => [
            'host' => env('REVERB_HOST', '0.0.0.0'),
            'port' => env('REVERB_PORT', 8080),
            'scheme' => env('REVERB_SCHEME', 'http'),
            'useTLS' => env('REVERB_SCHEME', 'http') === 'https',
        ],
        'client_options' => [
            // Guzzle client options: https://docs.guzzlephp.org/en/stable/request-options.html
        ],
    ],

],
```

**Validation**:
- [ ] 'reverb' connection added
- [ ] All environment variables referenced
- [ ] Configuration matches PinkieIt

---

### T037: Configure Reverb Environment Variables

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T036

**Objective**: Add REVERB_* variables to .env and .env.example

**Files to Modify**:
- `YokaKit/.env`
- `YokaKit/.env.example`

**Implementation Steps**:

1. Generate Reverb credentials:
   ```bash
   # Generate random credentials for development
   REVERB_APP_ID="yokakit-dev"
   REVERB_APP_KEY=$(openssl rand -hex 16)
   REVERB_APP_SECRET=$(openssl rand -hex 32)
   ```

2. Add to .env:

**Edit `.env`**, add:
```env
# Reverb WebSocket Configuration
REVERB_APP_ID=yokakit-dev
REVERB_APP_KEY={generated_key}
REVERB_APP_SECRET={generated_secret}
REVERB_HOST=localhost
REVERB_PORT=8080
REVERB_SCHEME=http
REVERB_SERVER_HOST=0.0.0.0
REVERB_SERVER_PORT=8080
```

3. Add to .env.example (template):

**Edit `.env.example`**, add:
```env
# Reverb WebSocket Configuration
REVERB_APP_ID=
REVERB_APP_KEY=
REVERB_APP_SECRET=
REVERB_HOST=localhost
REVERB_PORT=8080
REVERB_SCHEME=http
REVERB_SERVER_HOST=0.0.0.0
REVERB_SERVER_PORT=8080
```

**Validation**:
- [ ] .env has Reverb credentials (actual values)
- [ ] .env.example has Reverb template (empty credentials)
- [ ] All required REVERB_* variables present

---

### T038: Test Reverb Server Startup

**Type**: Validation
**Estimated**: 20 min
**Dependencies**: T037

**Objective**: Verify Reverb server starts and accepts WebSocket connections

**Steps**:

1. Start Reverb server (in DevContainer):
   ```bash
   cd /var/www/html
   php artisan reverb:start --debug

   # Expected output:
   # Reverb server started on 0.0.0.0:8080
   ```

2. In another terminal, test WebSocket connection:
   ```bash
   curl http://localhost:8080
   # Expected: Reverb server response

   # Or from host machine (DevContainer port forwarding)
   curl http://localhost:6002
   # Expected: Reverb server response (6002 → 6001 → 8080)
   ```

3. Test Pusher protocol compatibility:
   ```bash
   # Test basic connection (if Pusher.js or Echo configured)
   # Verify WebSocket upgrade successful
   ```

4. Stop Reverb server:
   ```bash
   # Ctrl+C in terminal running reverb:start
   ```

**Success Criteria**:
- [ ] Reverb server starts without errors
- [ ] Server listens on port 8080
- [ ] WebSocket connections accepted
- [ ] Port 6002 accessible from host (DevContainer forwarding)

---

### T039: Run Tests After Reverb Installation

**Type**: Validation
**Estimated**: 15 min
**Dependencies**: T038

**Objective**: Verify 425/425 tests still passing after Reverb installation

**Steps**:

1. Run test suite:
   ```bash
   cd /var/www/html
   php artisan test

   # Expected: 425/425 tests passing
   ```

2. Verify no regressions:
   ```bash
   # Check that Reverb installation didn't break existing functionality
   php artisan optimize:clear
   php artisan config:clear
   php artisan test
   ```

**Success Criteria**:
- [ ] All 425 tests passing
- [ ] No regressions from Reverb installation

---

### T040: Commit CR5 with Audit Trail

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T039

**Objective**: Commit Laravel Reverb installation

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add app/laravel/composer.json app/laravel/composer.lock \
     app/laravel/config/reverb.php app/laravel/config/broadcasting.php \
     .env.example
   ```

2. Commit:
   ```bash
   git commit -m "feat: install Laravel Reverb for WebSocket broadcasting (PinkieIt: d4db04f)

   Replay of PinkieIt commit d4db04f46e8e8edc3c684288546ea7aad7a0e8b4

   - Add laravel/reverb ^1.4 package dependency
   - Create config/reverb.php with server and app settings (93 lines)
   - Add Reverb connection configuration to config/broadcasting.php
   - Configure environment variables for localhost:8080 HTTP
   - Replaces archived beyondcode/laravel-websockets package
   - Provides Pusher protocol compatibility for existing frontend

   Constitutional adaptations: None (Reverb is framework-agnostic)

   Files changed: 4
   - app/laravel/composer.json (add laravel/reverb)
   - app/laravel/composer.lock (package installation)
   - app/laravel/config/reverb.php (NEW, 93 lines)
   - app/laravel/config/broadcasting.php (reverb connection)
   - .env.example (Reverb environment variables)

   Test validation: 425/425 tests passing ✓
   Reverb server: Starts successfully ✓
   Pusher compatibility: Verified ✓

   Phase 4B CR5
   YokaKit identity preserved ✓"
   ```

**Validation**:
- [ ] Commit created
- [ ] References PinkieIt hash d4db04f
- [ ] Reverb validation documented

---

## COMMIT REPLAY 6: Remove Legacy WebSockets

**PinkieIt Commit**: `524c1c38a7305b61008d2ff56ce1e4563da92aed`
**Date**: 2025-06-19
**Files**: 6 files (composer.json, composer.lock, config deletion, migration deletion, test updates)
**Constitutional**: None (package removal, no naming)

### Story/Issue Reference
- **YokaKit Epic**: #{epic_number}
- **YokaKit Story**: #TBD (CR6: Remove Legacy WebSockets)

---

### T041: Analyze Legacy WebSockets Removal

**Type**: Preparation
**Estimated**: 15 min

**Objective**: Verify PinkieIt legacy WebSockets removal and plan YokaKit cleanup

**Steps**:

1. Review PinkieIt commit:
   ```bash
   cd pinkieit
   git checkout 524c1c38a7305b61008d2ff56ce1e4563da92aed
   git show 524c1c3 --stat
   git show 524c1c3
   ```

2. Identify removals:
   - [ ] composer.json: Remove beyondcode/laravel-websockets, pusher/pusher-php-server
   - [ ] composer.lock: Package cleanup
   - [ ] config/websockets.php: Delete file (141 lines)
   - [ ] database/migrations/*_create_websockets_statistics_entries_table.php: Delete migration
   - [ ] tests: Update to validate Reverb instead of WebSockets

**Validation**:
- [ ] All deletions identified
- [ ] Test updates noted

**Reference**: contracts/reverb.contract.md

---

### T042: Remove WebSockets Packages

**Type**: Implementation
**Estimated**: 15 min
**Dependencies**: T041

**Objective**: Remove beyondcode/laravel-websockets and pusher/pusher-php-server from composer.json

**Files to Modify**:
- `YokaKit/app/laravel/composer.json`

**Implementation Steps**:

1. Check if packages exist in YokaKit:
   ```bash
   cd /var/www/html
   composer show beyondcode/laravel-websockets
   # If found, proceed with removal

   composer show pusher/pusher-php-server
   # If found, proceed with removal
   ```

2. Remove from composer.json:

**Edit `app/laravel/composer.json`**:
```json
{
    "require": {
        // Remove these lines if present:
        // "beyondcode/laravel-websockets": "^1.14",
        // "pusher/pusher-php-server": "^7.0",
    }
}
```

3. Run composer update:
   ```bash
   composer update --no-scripts
   composer remove beyondcode/laravel-websockets pusher/pusher-php-server --no-update
   composer update
   ```

**Validation**:
- [ ] Packages removed from composer.json
- [ ] composer.lock updated
- [ ] Packages no longer in vendor/

---

### T043: Delete WebSockets Configuration

**Type**: Implementation
**Estimated**: 5 min
**Dependencies**: T042

**Objective**: Delete config/websockets.php file

**Files to Delete**:
- `YokaKit/app/laravel/config/websockets.php` (if exists)

**Implementation Steps**:

1. Check if file exists:
   ```bash
   cd /var/www/html
   ls -la config/websockets.php
   ```

2. If exists, delete:
   ```bash
   git rm config/websockets.php
   # or
   rm config/websockets.php
   ```

**Validation**:
- [ ] config/websockets.php deleted (if existed)

---

### T044: Delete WebSockets Statistics Migration

**Type**: Implementation
**Estimated**: 5 min
**Dependencies**: T043

**Objective**: Delete WebSockets statistics migration file

**Files to Delete**:
- `YokaKit/app/laravel/database/migrations/*_create_websockets_statistics_entries_table.php` (if exists)

**Implementation Steps**:

1. Find migration:
   ```bash
   cd /var/www/html
   ls database/migrations/*websockets_statistics*
   ```

2. If exists, delete:
   ```bash
   git rm database/migrations/*_create_websockets_statistics_entries_table.php
   # or
   rm database/migrations/*_create_websockets_statistics_entries_table.php
   ```

**Validation**:
- [ ] WebSockets statistics migration deleted (if existed)

---

### T045: Update Tests for Reverb

**Type**: Implementation
**Estimated**: 30 min
**Dependencies**: T044

**Objective**: Update tests to validate Reverb configuration instead of WebSockets

**Files to Modify** (if WebSocket tests exist):
- `YokaKit/app/laravel/tests/Feature/CurrentWebSocketFunctionalityTest.php` (or similar)

**Implementation Steps**:

1. Find WebSocket tests:
   ```bash
   cd /var/www/html
   grep -r "WebSocket" tests/
   grep -r "beyondcode" tests/
   ```

2. Update tests to validate Reverb:
   - Remove WebSocket configuration checks
   - Add Reverb configuration checks
   - Verify Reverb server startup
   - Validate Pusher protocol compatibility

**Example Changes**:
```php
// OLD (WebSockets)
$this->assertNotNull(config('websockets'));

// NEW (Reverb)
$this->assertNotNull(config('reverb'));
$this->assertArrayHasKey('reverb', config('broadcasting.connections'));
```

**Validation**:
- [ ] All WebSocket references removed from tests
- [ ] Reverb validation tests added (if applicable)

---

### T046: Verify Legacy Cleanup Complete

**Type**: Validation
**Estimated**: 20 min
**Dependencies**: T045

**Objective**: Verify all legacy WebSockets components removed and Reverb is sole WebSocket solution

**Steps**:

1. Check for WebSockets remnants:
   ```bash
   cd /var/www/html

   # No WebSockets packages
   composer show beyondcode/laravel-websockets
   # Expected: Package not found

   composer show pusher/pusher-php-server
   # Expected: Package not found

   # No WebSockets config
   ls config/websockets.php
   # Expected: No such file

   # No WebSockets migrations
   ls database/migrations/*websockets*
   # Expected: No such file

   # No WebSockets references in code
   grep -r "beyondcode" app/ config/
   # Expected: No results
   ```

2. Verify Reverb is functional:
   ```bash
   # Check Reverb config exists
   ls config/reverb.php
   # Expected: File exists

   # Check Reverb connection in broadcasting
   grep "reverb" config/broadcasting.php
   # Expected: Connection found

   # Test Reverb server
   php artisan reverb:start --debug &
   sleep 2
   curl http://localhost:8080
   # Expected: Reverb response
   pkill -f "reverb:start"
   ```

**Success Criteria**:
- [ ] beyondcode/laravel-websockets NOT in composer.lock
- [ ] pusher/pusher-php-server NOT in composer.lock
- [ ] config/websockets.php does NOT exist
- [ ] WebSockets migration does NOT exist
- [ ] Reverb config exists and functional

---

### T047: Run Final Tests

**Type**: Validation
**Estimated**: 20 min
**Dependencies**: T046

**Objective**: Verify 425/425 tests passing after WebSockets removal

**Steps**:

1. Run test suite:
   ```bash
   cd /var/www/html
   php artisan test

   # Expected: 425/425 tests passing
   ```

2. Run parallel tests:
   ```bash
   php artisan test --parallel --processes=4

   # Expected: Same results
   ```

3. Verify application functionality:
   ```bash
   # Clear caches
   php artisan optimize:clear

   # Test application
   curl http://localhost:18081
   # Expected: Application response
   ```

**Success Criteria**:
- [ ] All 425 tests passing (100%)
- [ ] No regressions from WebSockets removal
- [ ] Application fully functional

---

### T048: Commit CR6 with Audit Trail

**Type**: Git Commit
**Estimated**: 10 min
**Dependencies**: T047

**Objective**: Commit legacy WebSockets removal (final Phase 4B commit)

**Steps**:

1. Stage changes:
   ```bash
   cd YokaKit
   git add app/laravel/composer.json app/laravel/composer.lock
   git add -u  # Stage deletions (config/websockets.php, migration)
   git add app/laravel/tests/  # Test updates
   ```

2. Commit:
   ```bash
   git commit -m "feat: remove legacy Laravel WebSockets implementation (PinkieIt: 524c1c3)

   Replay of PinkieIt commit 524c1c38a7305b61008d2ff56ce1e4563da92aed

   - Remove beyondcode/laravel-websockets package (archived)
   - Remove pusher/pusher-php-server package (dependency)
   - Delete config/websockets.php configuration file (141 lines)
   - Delete WebSockets statistics migration
   - Update tests to validate Reverb configuration instead
   - Complete migration to Laravel Reverb as sole WebSocket solution

   Constitutional adaptations: None (package removal)

   Files changed: 6
   - app/laravel/composer.json (remove WebSockets packages)
   - app/laravel/composer.lock (dependency cleanup)
   - app/laravel/config/websockets.php (DELETED)
   - app/laravel/database/migrations/*_create_websockets_statistics_entries_table.php (DELETED)
   - app/laravel/tests/Feature/CurrentWebSocketFunctionalityTest.php (Reverb validation)
   - .sonarlint/connectedMode.json (SonarLint config update)

   Test validation: 425/425 tests passing (100%) ✓
   Reverb server: Operational ✓
   Legacy WebSockets: Completely removed ✓
   Clean migration complete ✓

   Phase 4B CR6 (Final)
   Phase 4 Complete ✅
   YokaKit identity preserved ✓"
   ```

**Validation**:
- [ ] Commit created
- [ ] References PinkieIt hash 524c1c3
- [ ] Notes Phase 4 completion
- [ ] All validation documented

---

## Dependencies

**Phase Dependency**:
- **Phase 4A (CR1)** → **Phase 4B (CR2-CR6)**: DevContainer must be operational before framework upgrades

**Within Phase 4A**:
- T001 → T002 → T003 → T004 → T005 → T006 → T007 → T008 → T009 → T010 (Sequential)

**Within Phase 4B**:
- CR2 (T011-T017) → CR3 (T018-T025) → CR4 (T026-T032) → CR5 (T033-T040) → CR6 (T041-T048) (Sequential)
- Framework upgrades must follow order: PHP 8.2 → Laravel 10 initial → Laravel 10 completion → Reverb → Legacy removal

**Cross-CR Dependencies**:
- CR3 depends on CR2 (PHP 8.2 required for Laravel 10)
- CR4 depends on CR3 (fixes Laravel 10 initial issues)
- CR5 depends on CR4 (Reverb requires Laravel 10 complete)
- CR6 depends on CR5 (Reverb must be functional before removing WebSockets)

---

## Task Execution Strategy

### Recommended: Sequential Execution

Execute tasks in order (T001 → T002 → ... → T048):

**Phase 4A: DevContainer** (1-2 days)
```bash
# T001-T010: DevContainer unified implementation
# Result: DevContainer operational with 40+ extensions
```

**Phase 4B: Framework Modernization** (4-6 days)
```bash
# T011-T017: PHP 8.2 upgrade (CR2)
# T018-T025: Laravel 10 initial (CR3)
# T026-T032: Laravel 10 completion (CR4)
# T033-T040: Laravel Reverb (CR5)
# T041-T048: Legacy WebSockets removal (CR6)
# Result: PHP 8.2 + Laravel 10 + Reverb operational, 425/425 tests passing
```

**Advantage**: Clear audit trail, easier debugging, constitutional compliance verification at each CR

### Parallel Execution: NOT Recommended for Phase 4

**Reason**: Sequential dependencies prevent meaningful parallelization:
- DevContainer blocks all framework upgrades
- Framework upgrades must follow strict order (PHP → Laravel → Reverb → cleanup)

**Only potential parallel tasks**: T006 and T007 (VS Code + CLI validation of same DevContainer)

---

## GitHub Issue Management

### Issue Creation Pattern

**Epic** (one per phase):
```bash
gh issue create --repo YOUR_ORG/YokaKit \
  --title "[EPIC] Phase 4: Framework Modernization & DevContainer" \
  --label "epic:phase-4,constitutional:identity-preservation" \
  --milestone "Phase 4"
```

**Stories** (one per CR):
- **Story 1**: CR1 - DevContainer Complete Implementation (T010)
- **Story 2**: CR2 - PHP 8.2 Upgrade (create after T017)
- **Story 3**: CR3 - Laravel 10 Initial Upgrade (create after T025)
- **Story 4**: CR4 - Laravel 10 Completion (create after T032)
- **Story 5**: CR5 - Laravel Reverb Installation (create after T040)
- **Story 6**: CR6 - Remove Legacy WebSockets (create after T048)

---

## Progress Tracking

### Commit Replay Checklist

**Phase 4A: DevContainer Complete Environment**
- [ ] **CR1** (0cc0475 + 65eea6a + cdd8d6f): DevContainer Unified Implementation (T001-T010)

**Phase 4B: Framework Modernization**
- [ ] **CR2** (e0eaabd): PHP 8.2 Upgrade (T011-T017)
- [ ] **CR3** (4152b54): Laravel 10 Initial Upgrade (T018-T025)
- [ ] **CR4** (862d537): Laravel 10 Completion (T026-T032)
- [ ] **CR5** (d4db04f): Laravel Reverb Installation (T033-T040)
- [ ] **CR6** (524c1c3): Remove Legacy WebSockets (T041-T048)

### Constitutional Compliance Checklist

- [ ] Zero pinkieit references in codebase
- [ ] YokaKit identity preserved in all configs
- [ ] All commits reference PinkieIt hashes
- [ ] GitHub Issues track all CRs

### Phase Completion Criteria

- [ ] All 6 commit replays completed
- [ ] All 48 tasks completed
- [ ] DevContainer operational with 40+ extensions
- [ ] PHP 8.2 active
- [ ] Laravel 10.48.x+ installed
- [ ] Laravel Reverb operational
- [ ] Legacy WebSockets removed
- [ ] Test suite: 425/425 passing (100%)
- [ ] Constitutional compliance: 100%
- [ ] All GitHub Issues closed
- [ ] YokaKit submodule updated in YokaKit_Replay

---

**Created**: 2025-10-04
**PinkieIt Reference**: 0cc0475..cdd8d6f (8 primary commits: 3 DevContainer + 5 framework)
**Total Tasks**: 48 tasks (10 DevContainer + 38 framework)
**Estimated Duration**: 1-2 weeks
