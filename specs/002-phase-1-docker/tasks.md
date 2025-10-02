# Tasks: Phase 1 Docker Foundation & Development Environment (Commit-Based Replay)

**Input**: Design documents from `/specs/002-phase-1-docker/` + PinkieIt actual commit history
**Prerequisites**: plan.md ✅, research.md ✅, data-model.md ✅, contracts/ ✅, quickstart.md ✅
**Target Repository**: YokaKit (w-pinkietech/YokaKit)
**Replay Approach**: Chronological commit-by-commit replay from PinkieIt history

## PinkieIt Commit Sequence (Source of Truth)

```
a5d3b77 (2024-07-01 21:51): add dockerfile and compose.yml etc
  ↓
643414f: rename YokaKit to PinkieIt → SKIP (constitutional requirement)
  ↓
fad82e6 (2025-02-01 12:07): reorganize docker directory structure (app/ → app/laravel/)
  ↓
bfd075e (2025-02-01 13:13): update docker-compose.yml (network, healthcheck, naming)
  ↓
3a0f1cd (2025-02-01 13:19): update docker-compose.yml (volumes, COPY order)
  ↓
13b40d1 (2025-02-01 13:47): Added mqtt container to docker-compose.yml
```

## Execution Flow
```
1. Load PinkieIt commit history ✅ - Actual chronological commits analyzed
2. Map commits to YokaKit tasks ✅ - Skip 643414f, adapt others with YokaKit naming
3. Generate commit-by-commit tasks ✅ - Each commit = group of related tasks
4. Add validation tasks (TDD) ✅ - Tests before implementation
5. Order by commit chronology ✅ - Exactly follows PinkieIt timeline
6. Mark parallel tasks ✅ - Independent files within same commit
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- **Commit-based**: Tasks grouped by source PinkieIt commit
- Constitutional requirement: Skip 643414f, maintain YokaKit identity throughout

---

## COMMIT REPLAY 1: a5d3b77 (2024-07-01) - Initial Docker Foundation

**PinkieIt Commit**: `a5d3b77ad98f34afae9ac7c6cd6be55770a4309c`
**Description**: add dockerfile and compose.yml etc
**Files Added**: 5 files (Dockerfile, docker-compose.yml, docker/apache/000-default.conf, docker/php/local.ini, updated seeder)

### Phase CR1.1: Pre-Implementation Validation (TDD)

- [ ] **T001** [P] Create Dockerfile validation test
  - **File**: YokaKit/tests/docker/test_dockerfile_a5d3b77.sh
  - **Description**: Validate Dockerfile structure matches a5d3b77 pattern
  - **Validation**: Test for PHP 8.2-apache, required extensions, Apache mod_rewrite
  - **Must**: This test MUST FAIL before T003 implementation
  - **Reference**: PinkieIt commit a5d3b77 Dockerfile (43 lines)

- [ ] **T002** [P] Create docker-compose validation test
  - **File**: YokaKit/tests/docker/test_compose_a5d3b77.sh
  - **Description**: Validate docker-compose.yml structure matches a5d3b77 pattern
  - **Validation**: Test for app service, db service, basic networking
  - **Must**: This test MUST FAIL before T004 implementation
  - **Reference**: PinkieIt commit a5d3b77 docker-compose.yml

### Phase CR1.2: Dockerfile Implementation (a5d3b77 pattern)

- [ ] **T003** Create Dockerfile in repository root
  - **File**: YokaKit/Dockerfile
  - **Description**: Create single-stage Dockerfile with PHP 8.2-apache base
  - **Content**: Exact a5d3b77 pattern with YokaKit naming
  - **Extensions**: pdo_mysql, mysqli, mbstring, exif, pcntl, bcmath, gd
  - **Apache**: a2enmod rewrite, expose port 80
  - **Validation**: T001 test PASSES, docker build succeeds
  - **Constitutional**: YokaKit naming, commit references "PinkieIt commit: a5d3b77"
  - **Reference**: PinkieIt commit a5d3b77ad98f34afae9ac7c6cd6be55770a4309c

### Phase CR1.3: Docker Compose Implementation (a5d3b77 pattern)

- [ ] **T004** Create docker-compose.yml in repository root
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Create basic Docker Compose with app + db services
  - **Services**:
    - app: build from Dockerfile, container: laravel-app, port 18080:80
    - db: mariadb:10.11.4, database: yokakit, user: yokakit
  - **Network**: laravel (simple network)
  - **Volumes**: dbdata for database persistence
  - **Validation**: T002 test PASSES, docker-compose config validates
  - **Constitutional**: Database named "yokakit" (preserves YokaKit heritage per a5d3b77)
  - **Reference**: PinkieIt commit a5d3b77ad98f34afae9ac7c6cd6be55770a4309c

### Phase CR1.4: Apache Configuration (a5d3b77 pattern)

- [ ] **T005** [P] Create docker directory structure
  - **Directories**: YokaKit/docker/, YokaKit/docker/apache/, YokaKit/docker/php/
  - **Description**: Create directory structure for Docker configuration
  - **Validation**: Directories exist with proper permissions

- [ ] **T006** [P] Create Apache VirtualHost configuration
  - **File**: YokaKit/docker/apache/sites-available/000-default.conf
  - **Description**: Create Apache configuration per a5d3b77 pattern
  - **Content**: DocumentRoot /var/www/html/public, AllowOverride All
  - **Validation**: Apache config syntax valid
  - **Reference**: PinkieIt commit a5d3b77 Apache config (13 lines)

- [ ] **T007** [P] Create PHP configuration overrides
  - **File**: YokaKit/docker/php/local.ini
  - **Description**: Create PHP ini overrides per a5d3b77 pattern
  - **Content**: upload_max_filesize, post_max_size, memory_limit settings
  - **Validation**: PHP ini syntax valid
  - **Reference**: PinkieIt commit a5d3b77 local.ini (3 lines)

### Phase CR1.5: Validation & Commit

- [ ] **T008** Test Docker environment (a5d3b77 baseline)
  - **Command**: docker-compose up -d && curl http://localhost:18080
  - **Description**: Verify basic Docker environment works
  - **Validation**: Services start, application accessible on port 18080
  - **Validation**: Database named "yokakit" (verify with docker-compose exec db mysql -e "SHOW DATABASES;")
  - **Milestone**: CR1 Complete - a5d3b77 pattern established

- [ ] **T009** Commit CR1 changes
  - **Command**: git add Dockerfile docker-compose.yml docker/
  - **Commit Message**: "feat: add Docker foundation (PinkieIt commit: a5d3b77)"
  - **Validation**: Commit references a5d3b77ad98f34afae9ac7c6cd6be55770a4309c
  - **Constitutional**: Audit trail maintained

---

## COMMIT REPLAY 2: 643414f - CONSTITUTIONAL SKIP

**PinkieIt Commit**: `643414f` - chore: rename YokaKit to PinkieIt
**Action**: **SKIP THIS COMMIT** (Constitutional requirement: Identity Preservation)
**Reason**: YokaKit name must be maintained throughout (NON-NEGOTIABLE)

**No tasks generated for this commit.**

---

## COMMIT REPLAY 3: fad82e6 (2025-02-01) - Application Structure Reorganization

**PinkieIt Commit**: `fad82e6e17ed98e82434295fbae4690836206dda`
**Description**: refactor: reorganize docker directory structure
**Impact**: **MASSIVE** - Moves entire Laravel application to app/laravel/ subdirectory
**Files Changed**: 200+ files relocated, .env.example added

### Phase CR3.1: Pre-Reorganization Validation

- [ ] **T010** Create application structure audit report
  - **File**: YokaKit/docs/APP_LARAVEL_REORGANIZATION_PLAN.md
  - **Description**: Document current app/ structure before reorganization
  - **Content**: File inventory, path mappings (app/ → app/laravel/app/), validation checklist
  - **Validation**: Complete inventory of files to be moved
  - **Reference**: PinkieIt commit fad82e6 file changes (200+ file moves)

- [ ] **T011** [P] Create structure validation test
  - **File**: YokaKit/tests/structure/test_app_laravel_structure.sh
  - **Description**: Validate app/laravel/ structure after reorganization
  - **Validation**: Test checks all files in correct locations
  - **Must**: This test MUST FAIL before reorganization

### Phase CR3.2: Application Reorganization Execution

- [ ] **T012** Create app/laravel/ directory structure
  - **Command**: mkdir -p app/laravel
  - **Description**: Create target directory for Laravel application
  - **Validation**: Directory created with proper permissions

- [ ] **T013** Move Laravel application to app/laravel/
  - **Source Paths**: app/, artisan, bootstrap/, composer.json, composer.lock, config/, database/, lang/, package.json, package-lock.json, phpunit.xml, public/, resources/
  - **Target Path**: app/laravel/
  - **Command**: git mv app app/laravel/app && git mv artisan app/laravel/artisan && ... (all files)
  - **Description**: Relocate entire Laravel application to app/laravel/ subdirectory
  - **Validation**: All files moved, no files left in root (except Docker files)
  - **Constitutional**: Preserve YokaKit functionality during relocation
  - **Reference**: PinkieIt commit fad82e6e17ed98e82434295fbae4690836206dda
  - **WARNING**: This is a MASSIVE structural change - careful execution required

- [ ] **T014** Create .env.example in repository root
  - **File**: YokaKit/.env.example
  - **Description**: Create environment variable template per fad82e6 pattern
  - **Content**: 65 lines with comprehensive Laravel + Docker configuration
  - **Validation**: File includes DB settings, app settings, Docker-specific vars
  - **Constitutional**: Use YokaKit naming in all variables
  - **Reference**: PinkieIt commit fad82e6 .env.example (65 lines)

### Phase CR3.3: Post-Reorganization Validation

- [ ] **T015** Update Dockerfile for app/laravel/ structure
  - **File**: YokaKit/Dockerfile
  - **Description**: Update COPY paths to reflect app/laravel/ structure
  - **Changes**: COPY app/laravel /var/www/html, update paths
  - **Validation**: docker build succeeds with new structure
  - **Reference**: Next commits will further refine this

- [ ] **T016** Update docker-compose.yml for app/laravel/ structure
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Update volume mounts and working directory for app/laravel/
  - **Changes**: Adjust paths to app/laravel/, update working_dir
  - **Validation**: docker-compose config validates

- [ ] **T017** Validate application functionality post-reorganization
  - **Command**: docker-compose up -d && docker-compose exec app php artisan about
  - **Description**: Verify Laravel application works after reorganization
  - **Validation**: T011 structure test PASSES, application loads
  - **Validation**: Routes accessible, no path errors

- [ ] **T018** Commit CR3 changes
  - **Command**: git add app/ .env.example Dockerfile docker-compose.yml
  - **Commit Message**: "refactor: reorganize to app/laravel/ structure (PinkieIt commit: fad82e6)"
  - **Validation**: Commit references fad82e6e17ed98e82434295fbae4690836206dda
  - **Constitutional**: YokaKit identity maintained despite structural change
  - **Milestone**: CR3 Complete - app/laravel/ structure established

---

## COMMIT REPLAY 4: bfd075e (2025-02-01) - Docker Compose Enhancement

**PinkieIt Commit**: `bfd075e7e7d9038cbbced99fc052c982b00058f9`
**Description**: update docker-compose.yml and Dockerfile
**Impact**: Enhanced networking, healthchecks, service naming, environment variables
**Files Changed**: docker-compose.yml, docker/base/Dockerfile

### Phase CR4.1: Service Enhancement

- [ ] **T019** Rename services and add YokaKit-specific naming
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Update service names, container names, network name
  - **Changes**:
    - Service: app → web-app
    - Container: laravel-app → yokakit-web-app
    - Image: laravel-app → yokakit-web-app
    - Network: laravel → yokakit
  - **Validation**: Service naming follows YokaKit identity
  - **Constitutional**: Replace PinkieIt naming from bfd075e with YokaKit naming
  - **Reference**: PinkieIt commit bfd075e (adapted for YokaKit)

- [ ] **T020** Add healthcheck to database service
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Add MariaDB healthcheck configuration
  - **Content**: mysqladmin ping test, 10s interval, 5 retries
  - **Validation**: Healthcheck defined per Docker Compose spec
  - **Reference**: PinkieIt commit bfd075e healthcheck pattern

- [ ] **T021** Add depends_on with service_healthy condition
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Make web-app depend on db healthcheck
  - **Content**: depends_on: db: condition: service_healthy
  - **Validation**: Web-app waits for database to be healthy
  - **Reference**: PinkieIt commit bfd075e dependency pattern

- [ ] **T022** Add environment variables to docker-compose
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Use environment variables from .env file
  - **Content**: DB_DATABASE, DB_USERNAME, DB_PASSWORD from ${...}
  - **Validation**: Environment variables properly referenced
  - **Reference**: PinkieIt commit bfd075e environment pattern

- [ ] **T023** Update Dockerfile path to docker/base/Dockerfile
  - **Files**: YokaKit/docker-compose.yml, create YokaKit/docker/base/Dockerfile
  - **Description**: Move Dockerfile from root to docker/base/ and update compose reference
  - **Validation**: Build context updated, dockerfile path correct
  - **Reference**: PinkieIt commit bfd075e Dockerfile relocation

- [ ] **T024** Commit CR4 changes
  - **Command**: git add docker-compose.yml docker/base/Dockerfile
  - **Commit Message**: "chore: enhance docker-compose with healthcheck and networking (PinkieIt commit: bfd075e)"
  - **Validation**: Commit references bfd075e7e7d9038cbbced99fc052c982b00058f9
  - **Milestone**: CR4 Complete - Enhanced Docker orchestration

---

## COMMIT REPLAY 5: 3a0f1cd (2025-02-01) - Volume and Build Refinements

**PinkieIt Commit**: `3a0f1cdc6412023a8a3feeec0a2112872475a43e`
**Description**: update docker-compose.yml and Dockerfile
**Impact**: Commented out development volumes, adjusted COPY order in Dockerfile
**Files Changed**: docker-compose.yml, docker/base/Dockerfile

### Phase CR5.1: Configuration Refinement

- [ ] **T025** Adjust volumes in docker-compose.yml
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Comment out development-specific volume mounts per 3a0f1cd
  - **Changes**: Adjust volume configuration based on deployment target
  - **Validation**: docker-compose config validates
  - **Reference**: PinkieIt commit 3a0f1cd volume changes

- [ ] **T026** Optimize Dockerfile COPY command order
  - **File**: YokaKit/docker/base/Dockerfile
  - **Description**: Reorder COPY commands for better layer caching
  - **Changes**: Dependencies before application code for cache efficiency
  - **Validation**: docker build succeeds, build time optimized
  - **Reference**: PinkieIt commit 3a0f1cd COPY order optimization

- [ ] **T027** Commit CR5 changes
  - **Command**: git add docker-compose.yml docker/base/Dockerfile
  - **Commit Message**: "chore: refine volumes and build optimization (PinkieIt commit: 3a0f1cd)"
  - **Validation**: Commit references 3a0f1cdc6412023a8a3feeec0a2112872475a43e
  - **Milestone**: CR5 Complete - Build optimization applied

---

## COMMIT REPLAY 6: 13b40d1 (2025-02-01) - MQTT Container Addition

**PinkieIt Commit**: `13b40d1386f17e1d69dd3481cd2281d53ce52382`
**Description**: Added mqtt container to docker-compose.yml
**Impact**: MQTT broker integration for IoT device communication
**Files Changed**: docker-compose.yml (15 lines added)

### Phase CR6.1: MQTT Integration

- [ ] **T028** Add MQTT container to docker-compose.yml
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Add Eclipse Mosquitto MQTT broker container
  - **Service Name**: mqtt (container: yokakit-mqtt-broker)
  - **Image**: eclipse-mosquitto:latest
  - **Ports**: 1883:1883, 9001:9001
  - **Network**: yokakit
  - **Volume**: mqtt-data for persistence
  - **Validation**: MQTT service defined correctly
  - **Constitutional**: Use yokakit-mqtt-broker (not pinkieit-mqtt-broker)
  - **Reference**: PinkieIt commit 13b40d1386f17e1d69dd3481cd2281d53ce52382

- [ ] **T029** Add depends_on for MQTT in web-app
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Make web-app aware of MQTT service dependency
  - **Changes**: Add mqtt to depends_on list (if needed for startup order)
  - **Validation**: Service dependency correctly configured
  - **Reference**: PinkieIt commit 13b40d1 dependency pattern

- [ ] **T030** Add mqtt volume to docker-compose.yml
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Create named volume for MQTT data persistence
  - **Volume**: mqtt-data
  - **Validation**: Volume defined in volumes section
  - **Reference**: PinkieIt commit 13b40d1 volume settings

- [ ] **T031** Test MQTT container functionality
  - **Command**: docker-compose up -d && docker-compose exec mqtt mosquitto_sub -h localhost -t 'test/#'
  - **Description**: Verify MQTT broker is running and accessible
  - **Validation**: MQTT broker responds, can subscribe to topics
  - **Milestone**: MQTT integration complete

- [ ] **T032** Commit CR6 changes
  - **Command**: git add docker-compose.yml
  - **Commit Message**: "feat: add MQTT container for IoT integration (PinkieIt commit: 13b40d1)"
  - **Validation**: Commit references 13b40d1386f17e1d69dd3481cd2281d53ce52382
  - **Milestone**: CR6 Complete - MQTT broker integrated

---

## POST-COMMIT VALIDATION & QUALITY INFRASTRUCTURE

### Phase PV.1: Constitutional Compliance Validation

- [ ] **T033** [P] Create constitutional compliance validation script
  - **File**: YokaKit/scripts/validation/constitutional-compliance.sh
  - **Description**: Automated script to verify YokaKit identity preservation
  - **Checks**:
    - No "PinkieIt" or "pinkieit" in YokaKit files (excluding submodules)
    - All containers/volumes/networks use "yokakit" naming
    - Commit messages reference PinkieIt commits for audit trail
  - **Validation**: Script detects identity violations
  - **Constitutional**: CRITICAL - NON-NEGOTIABLE compliance check
  - **Reference**: specs/002-phase-1-docker/contracts/validation-scripts.contract.yml

- [ ] **T034** Execute constitutional compliance validation
  - **Command**: ./scripts/validation/constitutional-compliance.sh
  - **Description**: Verify all commits maintain YokaKit identity
  - **Validation**: Zero violations detected
  - **Constitutional**: All commits CR1-CR6 preserve YokaKit naming

### Phase PV.2: Docker Environment Validation

- [ ] **T035** [P] Create Docker environment health check script
  - **File**: YokaKit/scripts/validation/docker-environment.sh
  - **Description**: Comprehensive Docker environment health validation
  - **Checks**:
    - All services running (web-app, database, mqtt)
    - Application responds on port 18080
    - Database accessible and healthy
    - MQTT broker operational
  - **Validation**: All services healthy, performance metrics met
  - **Reference**: specs/002-phase-1-docker/contracts/validation-scripts.contract.yml

- [ ] **T036** Execute complete environment validation
  - **Command**: ./scripts/validation/docker-environment.sh
  - **Description**: Run comprehensive validation suite
  - **Validation**:
    - Startup time < 2 minutes
    - All healthchecks pass
    - No errors in service logs
  - **Milestone**: Docker Foundation validated and operational

### Phase PV.3: DevContainer Integration

- [ ] **T037** [P] Create .devcontainer validation test
  - **File**: YokaKit/tests/devcontainer/test_devcontainer_config.sh
  - **Description**: Validate DevContainer configuration structure
  - **Validation**: Test checks required extensions, settings, features
  - **Must**: This test MUST FAIL before T038 implementation
  - **Reference**: specs/002-phase-1-docker/contracts/devcontainer.contract.json

- [ ] **T038** Create .devcontainer configuration
  - **File**: YokaKit/.devcontainer/devcontainer.json
  - **Description**: VS Code DevContainer configuration for YokaKit development
  - **Content**:
    - dockerComposeFile: "../docker-compose.yml"
    - service: "web-app"
    - workspaceFolder: "/var/www/html"
    - Extensions: PHP IntelliSense, Laravel extensions, Docker tools
  - **Validation**: T037 test PASSES, DevContainer opens in VS Code
  - **Constitutional**: All naming uses YokaKit, workspace references app/laravel/
  - **Reference**: PinkieIt DevContainer pattern (PR #2, 2025-02-20)

- [ ] **T039** Test DevContainer functionality
  - **Action**: Open YokaKit in VS Code, reopen in container
  - **Description**: Verify DevContainer builds and functions correctly
  - **Validation**:
    - Container builds successfully
    - All extensions installed
    - Terminal opens in /var/www/html
    - Laravel commands work (php artisan list)
  - **Milestone**: DevContainer operational

### Phase PV.4: Development Tools & Quality Infrastructure

- [ ] **T040** [P] Add Laravel Pint configuration
  - **File**: YokaKit/app/laravel/pint.json
  - **Description**: Laravel Pint code formatting configuration
  - **Validation**: ./vendor/bin/pint --test runs successfully
  - **Reference**: PinkieIt Pint configuration

- [ ] **T041** [P] Add Larastan configuration
  - **File**: YokaKit/app/laravel/phpstan.neon
  - **Description**: Larastan (PHPStan) static analysis configuration
  - **Validation**: ./vendor/bin/phpstan analyse runs successfully
  - **Reference**: PinkieIt Larastan configuration

- [ ] **T042** [P] Add EditorConfig
  - **File**: YokaKit/.editorconfig
  - **Description**: EditorConfig for consistent code style
  - **Validation**: .editorconfig defines indentation, encoding
  - **Reference**: PinkieIt .editorconfig

### Phase PV.5: Documentation

- [ ] **T043** [P] Create comprehensive README.md
  - **File**: YokaKit/README.md
  - **Description**: Complete developer documentation with app/laravel/ structure
  - **Content**:
    - Docker setup instructions
    - app/laravel/ structure explanation
    - Development commands
    - Troubleshooting guide
  - **Validation**: README covers all setup scenarios
  - **Constitutional**: All examples use YokaKit naming
  - **Reference**: specs/002-phase-1-docker/quickstart.md

- [ ] **T044** [P] Create setup script
  - **File**: YokaKit/setup.sh
  - **Description**: Automated environment setup script
  - **Content**: .env creation, permissions check, Docker validation
  - **Validation**: Script executes successfully, creates .env from .env.example
  - **Reference**: PinkieIt setup.sh pattern

### Phase PV.6: Phase Completion

- [ ] **T045** Execute full validation suite
  - **Command**:
    ```bash
    ./scripts/validation/constitutional-compliance.sh &&
    ./scripts/validation/docker-environment.sh &&
    docker-compose exec web-app php artisan test
    ```
  - **Description**: Comprehensive validation of all Phase 1 deliverables
  - **Validation**:
    - Constitutional compliance: PASS
    - Docker environment: PASS
    - Application functionality: PASS
    - All services healthy
  - **Milestone**: Phase 1 validation complete

- [ ] **T046** Create Phase 1 completion report
  - **File**: YokaKit/docs/PHASE_1_COMPLETION_REPORT.md
  - **Description**: Document Phase 1 achievements and validation results
  - **Content**:
    - Commit replays completed (CR1, CR3, CR4, CR5, CR6)
    - Commit 643414f skipped (constitutional compliance)
    - app/laravel/ structure established
    - Docker environment operational
    - Constitutional compliance verified
  - **Validation**: All acceptance criteria documented
  - **Reference**: specs/002-phase-1-docker/plan.md completion criteria

- [ ] **T047** Update YokaKit_Replay submodule reference
  - **Repository**: YokaKit_Replay
  - **Command**: cd YokaKit_Replay && git add YokaKit && git commit -m "chore: update YokaKit submodule to Phase 1 completion"
  - **Description**: Update submodule pointer to Phase 1 completion state
  - **Validation**: YokaKit_Replay references updated YokaKit commit
  - **Constitutional**: Submodule synchronization per constitution requirement II
  - **Milestone**: Phase 1 Complete! 🎉

---

## Task Summary by Commit

### CR1: a5d3b77 (Initial Docker Foundation)
**Tasks**: T001-T009 (9 tasks)
**Duration**: 2-3 days
**Deliverables**: Dockerfile, docker-compose.yml, Apache/PHP configs, basic validation

### CR2: 643414f (Rename - SKIP)
**Tasks**: None (constitutional skip)
**Duration**: N/A
**Reason**: Identity Preservation (NON-NEGOTIABLE)

### CR3: fad82e6 (Application Reorganization)
**Tasks**: T010-T018 (9 tasks)
**Duration**: 3-4 days
**Deliverables**: app/laravel/ structure, .env.example, updated Docker configs
**WARNING**: MASSIVE structural change - requires careful execution

### CR4: bfd075e (Docker Enhancement)
**Tasks**: T019-T024 (6 tasks)
**Duration**: 1-2 days
**Deliverables**: Enhanced networking, healthchecks, environment variables, YokaKit naming

### CR5: 3a0f1cd (Refinements)
**Tasks**: T025-T027 (3 tasks)
**Duration**: 0.5-1 day
**Deliverables**: Volume adjustments, build optimizations

### CR6: 13b40d1 (MQTT Addition)
**Tasks**: T028-T032 (5 tasks)
**Duration**: 1 day
**Deliverables**: MQTT container, volume, integration validation

### Post-Commit Validation & Quality
**Tasks**: T033-T047 (15 tasks)
**Duration**: 3-4 days
**Deliverables**: Validation scripts, DevContainer, quality tools, documentation, completion report

---

## Dependencies (Commit-Based)

### Critical Path (Chronological)
```
CR1 (T001-T009) → CR3 (T010-T018) → CR4 (T019-T024) → CR5 (T025-T027) → CR6 (T028-T032) → PV (T033-T047)
```

### Within-Commit Parallelization
- **CR1**: T001, T002 parallel (tests); T005, T006, T007 parallel (configs)
- **CR3**: T010, T011 parallel (analysis and validation prep)
- **CR4**: T019-T023 can be done as single commit with multiple changes
- **PV**: T033, T035 parallel (validation scripts); T040, T041, T042 parallel (quality tools)

---

## Parallel Execution Examples

### CR1: Initial Docker Foundation
```bash
# Parallel: Validation tests
Task T001: "Create Dockerfile validation test"
Task T002: "Create docker-compose validation test"

# Parallel: Configuration files
Task T006: "Create Apache VirtualHost configuration"
Task T007: "Create PHP configuration overrides"
```

### CR3: Application Reorganization
```bash
# Sequential: MUST be done carefully due to massive scope
Task T010: "Create audit report" (analysis first)
Task T011: "Create validation test" (test before action)
Task T012-T013: "Execute reorganization" (careful step-by-step)
```

### Post-Validation Quality Infrastructure
```bash
# Parallel: Validation scripts
Task T033: "Create constitutional compliance validation"
Task T035: "Create Docker environment health check"

# Parallel: Quality tools
Task T040: "Add Laravel Pint"
Task T041: "Add Larastan"
Task T042: "Add EditorConfig"

# Parallel: Documentation
Task T043: "Create README"
Task T044: "Create setup script"
```

---

## Constitutional Compliance Checklist

### Identity Preservation (NON-NEGOTIABLE)
- [ ] Commit 643414f SKIPPED (rename YokaKit to PinkieIt)
- [ ] All "pinkieit" references replaced with "yokakit" in bfd075e pattern
- [ ] Database name remains "yokakit" throughout (a5d3b77 heritage)
- [ ] Container names use "yokakit-" prefix
- [ ] Network name is "yokakit"
- [ ] MQTT broker is "yokakit-mqtt-broker" (not pinkieit)

### Historical Fidelity (Audit Trail)
- [ ] CR1 commit references a5d3b77ad98f34afae9ac7c6cd6be55770a4309c
- [ ] CR3 commit references fad82e6e17ed98e82434295fbae4690836206dda
- [ ] CR4 commit references bfd075e7e7d9038cbbced99fc052c982b00058f9
- [ ] CR5 commit references 3a0f1cdc6412023a8a3feeec0a2112872475a43e
- [ ] CR6 commit references 13b40d1386f17e1d69dd3481cd2281d53ce52382
- [ ] All commit messages include "PinkieIt commit: {hash}"

### Quality First
- [ ] Validation tests created before implementation (TDD)
- [ ] Constitutional compliance validated throughout
- [ ] Docker environment health monitored
- [ ] Application functionality preserved during reorganization

---

## Success Metrics

### Phase 1 Completion Criteria
- [ ] All 6 commit replays completed (CR1, CR3, CR4, CR5, CR6; skip CR2)
- [ ] app/laravel/ structure established and functional
- [ ] Docker environment with web-app + database + mqtt operational
- [ ] YokaKit identity preserved (zero PinkieIt references)
- [ ] All validation scripts passing
- [ ] DevContainer functional in VS Code
- [ ] Documentation complete with app/laravel/ structure

### Performance Targets
- Docker environment startup: < 2 minutes ✓
- Application response time: < 1 second ✓
- Developer setup time: < 15 minutes ✓

### Constitutional Targets
- YokaKit identity preserved: ✓
- PinkieIt audit trail maintained: ✓ (5 commits referenced)
- Commit 643414f skipped: ✓
- Submodule synchronized: ✓

---

**Total Tasks**: 47 tasks (reduced from 48, more accurate)
**Commit Replays**: 5 commits (skip 1)
**Estimated Duration**: 2-3 weeks (faster than original 4-week estimate due to commit-guided approach)
**Parallel Tasks**: 15 tasks marked [P]
**Critical Path**: CR1 → CR3 → CR4 → CR5 → CR6 → PV (chronological commit order)
**Constitutional Compliance**: Verified at every commit

**Ready for accurate PinkieIt historical replay!** Each task maps to actual PinkieIt commits.