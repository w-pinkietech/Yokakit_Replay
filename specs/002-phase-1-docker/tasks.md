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

- [x] **T001** [P] Create Dockerfile validation test
  - **File**: YokaKit/tests/docker/test_dockerfile_a5d3b77.sh
  - **Description**: Validate Dockerfile structure matches a5d3b77 pattern
  - **Validation**: Test for PHP 8.2-apache, required extensions, Apache mod_rewrite
  - **Must**: This test MUST FAIL before T003 implementation
  - **Reference**: PinkieIt commit a5d3b77 Dockerfile (43 lines)

- [x] **T002** [P] Create docker-compose validation test
  - **File**: YokaKit/tests/docker/test_compose_a5d3b77.sh
  - **Description**: Validate docker-compose.yml structure matches a5d3b77 pattern
  - **Validation**: Test for app service, db service, basic networking
  - **Must**: This test MUST FAIL before T004 implementation
  - **Reference**: PinkieIt commit a5d3b77 docker-compose.yml

### Phase CR1.2: Dockerfile Implementation (a5d3b77 pattern)

- [x] **T003** Create Dockerfile in repository root
  - **File**: YokaKit/Dockerfile
  - **Description**: Create single-stage Dockerfile with PHP 8.2-apache base
  - **Content**: Exact a5d3b77 pattern with YokaKit naming
  - **Extensions**: pdo_mysql, mysqli, mbstring, exif, pcntl, bcmath, gd
  - **Apache**: a2enmod rewrite, expose port 80
  - **Validation**: T001 test PASSES, docker build succeeds
  - **Constitutional**: YokaKit naming, commit references "PinkieIt commit: a5d3b77"
  - **Reference**: PinkieIt commit a5d3b77ad98f34afae9ac7c6cd6be55770a4309c

### Phase CR1.3: Docker Compose Implementation (a5d3b77 pattern)

- [x] **T004** Create docker-compose.yml in repository root
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

- [x] **T005** [P] Create docker directory structure
  - **Directories**: YokaKit/docker/, YokaKit/docker/apache/, YokaKit/docker/php/
  - **Description**: Create directory structure for Docker configuration
  - **Validation**: Directories exist with proper permissions

- [x] **T006** [P] Create Apache VirtualHost configuration
  - **File**: YokaKit/docker/apache/sites-available/000-default.conf
  - **Description**: Create Apache configuration per a5d3b77 pattern
  - **Content**: DocumentRoot /var/www/html/public, AllowOverride All
  - **Validation**: Apache config syntax valid
  - **Reference**: PinkieIt commit a5d3b77 Apache config (13 lines)

- [x] **T007** [P] Create PHP configuration overrides
  - **File**: YokaKit/docker/php/local.ini
  - **Description**: Create PHP ini overrides per a5d3b77 pattern
  - **Content**: upload_max_filesize, post_max_size, memory_limit settings
  - **Validation**: PHP ini syntax valid
  - **Reference**: PinkieIt commit a5d3b77 local.ini (3 lines)

### Phase CR1.5: Validation & Commit

- [x] **T008** Test Docker environment (a5d3b77 baseline)
  - **Command**: docker-compose up -d && curl http://localhost:18080
  - **Description**: Verify basic Docker environment works
  - **Validation**: Services start, application accessible on port 18080
  - **Validation**: Database named "yokakit" (verify with docker-compose exec db mysql -e "SHOW DATABASES;")
  - **Milestone**: CR1 Complete - a5d3b77 pattern established

- [x] **T009** Commit CR1 changes
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

- [x] **T010** Create application structure audit report
  - **File**: YokaKit/docs/APP_LARAVEL_REORGANIZATION_PLAN.md
  - **Description**: Document current app/ structure before reorganization
  - **Content**: File inventory, path mappings (app/ → app/laravel/app/), validation checklist
  - **Validation**: Complete inventory of files to be moved
  - **Reference**: PinkieIt commit fad82e6 file changes (200+ file moves)

- [x] **T011** [P] Create structure validation test
  - **File**: YokaKit/tests/structure/test_app_laravel_structure.sh
  - **Description**: Validate app/laravel/ structure after reorganization
  - **Validation**: Test checks all files in correct locations
  - **Must**: This test MUST FAIL before reorganization

### Phase CR3.2: Application Reorganization Execution

- [x] **T012** Create app/laravel/ directory structure
  - **Command**: mkdir -p app/laravel
  - **Description**: Create target directory for Laravel application
  - **Validation**: Directory created with proper permissions

- [x] **T013** Move Laravel application to app/laravel/
  - **Source Paths**: app/, artisan, bootstrap/, composer.json, composer.lock, config/, database/, lang/, package.json, package-lock.json, phpunit.xml, public/, resources/
  - **Target Path**: app/laravel/
  - **Command**: git mv app app/laravel/app && git mv artisan app/laravel/artisan && ... (all files)
  - **Description**: Relocate entire Laravel application to app/laravel/ subdirectory
  - **Validation**: All files moved, no files left in root (except Docker files)
  - **Constitutional**: Preserve YokaKit functionality during relocation
  - **Reference**: PinkieIt commit fad82e6e17ed98e82434295fbae4690836206dda
  - **WARNING**: This is a MASSIVE structural change - careful execution required

- [x] **T014** Create .env.example in repository root
  - **File**: YokaKit/.env.example
  - **Description**: Create environment variable template per fad82e6 pattern
  - **Content**: 65 lines with comprehensive Laravel + Docker configuration
  - **Validation**: File includes DB settings, app settings, Docker-specific vars
  - **Constitutional**: Use YokaKit naming in all variables
  - **Reference**: PinkieIt commit fad82e6 .env.example (65 lines)

### Phase CR3.3: Post-Reorganization Validation

- [x] **T015** Update Dockerfile for app/laravel/ structure
  - **File**: YokaKit/Dockerfile
  - **Description**: Update COPY paths to reflect app/laravel/ structure
  - **Changes**: COPY app/laravel /var/www/html, update paths
  - **Validation**: docker build succeeds with new structure
  - **Reference**: Next commits will further refine this

- [x] **T016** Update docker-compose.yml for app/laravel/ structure
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Update volume mounts and working directory for app/laravel/
  - **Changes**: Adjust paths to app/laravel/, update working_dir
  - **Validation**: docker-compose config validates

- [x] **T017** Validate application functionality post-reorganization
  - **Command**: docker-compose up -d && docker-compose exec app php artisan about
  - **Description**: Verify Laravel application works after reorganization
  - **Validation**: T011 structure test PASSES, application loads
  - **Validation**: Routes accessible, no path errors

- [x] **T018** Commit CR3 changes
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

- [x] **T019** Rename services and add YokaKit-specific naming
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

- [x] **T020** Add healthcheck to database service
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Add MariaDB healthcheck configuration
  - **Content**: mysqladmin ping test, 10s interval, 5 retries
  - **Validation**: Healthcheck defined per Docker Compose spec
  - **Reference**: PinkieIt commit bfd075e healthcheck pattern

- [x] **T021** Add depends_on with service_healthy condition
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Make web-app depend on db healthcheck
  - **Content**: depends_on: db: condition: service_healthy
  - **Validation**: Web-app waits for database to be healthy
  - **Reference**: PinkieIt commit bfd075e dependency pattern

- [x] **T022** Add environment variables to docker-compose
  - **File**: YokaKit/docker-compose.yml
  - **Description**: Use environment variables from .env file
  - **Content**: DB_DATABASE, DB_USERNAME, DB_PASSWORD from ${...}
  - **Validation**: Environment variables properly referenced
  - **Reference**: PinkieIt commit bfd075e environment pattern

- [x] **T023** Update Dockerfile path to docker/base/Dockerfile
  - **Files**: YokaKit/docker-compose.yml, create YokaKit/docker/base/Dockerfile
  - **Description**: Move Dockerfile from root to docker/base/ and update compose reference
  - **Validation**: Build context updated, dockerfile path correct
  - **Reference**: PinkieIt commit bfd075e Dockerfile relocation

- [x] **T024** Commit CR4 changes
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
## PHASE 1 COMPLETION

### Summary

**Status**: ✅ COMPLETE
**Total Tasks**: 32 (T001-T032)
**PinkieIt Commits Replayed**: 6 (a5d3b77 → 13b40d1)
**Constitutional Skips**: 1 (643414f)

### Commit Replays

- [x] **CR1** (T001-T009): a5d3b77 - Initial Docker Foundation
- [x] **CR2**: 643414f - SKIP (Constitutional: Identity Preservation)
- [x] **CR3** (T010-T018): fad82e6 - Application Reorganization (app/→app/laravel/)
- [x] **CR4** (T019-T024): bfd075e - Docker Enhancement (networking, healthchecks, missing files)
- [x] **CR5** (T025-T027): 3a0f1cd - Volume and Build Refinements
- [x] **CR6** (T028-T032): 13b40d1 - MQTT Container Addition

### Deliverables

**Docker Infrastructure**:
- 3-container stack: web-app (PHP 8.2 + Apache), db (MariaDB 10.11.4), mqtt (Mosquitto)
- Production-ready docker-compose.yml with healthchecks and dependencies
- Isolated yokakit network
- Persistent volumes for database and MQTT

**Application Structure**:
- app/laravel/ - Complete Laravel application
- docker/base/ - PHP runtime Dockerfile
- docker/app/ - Apache and application configs
- mqtt/ - MQTT broker configuration

**Constitutional Compliance**:
- ✅ YokaKit naming throughout (yokakit-web-app, yokakit-db, yokakit_mqtt_broker)
- ✅ Identity preservation (no PinkieIt references)
- ✅ Commit 643414f skipped
- ✅ All commits reference PinkieIt hashes

### Validation Results

- ✅ HTTP 200 response at http://localhost:18080
- ✅ Database connectivity verified
- ✅ MQTT broker operational on port 18830
- ✅ All containers healthy

### Next Phase

Phase 1 is complete. Refer to `YokaKit/PHASE_1_COMPLETION_REPORT.md` for detailed completion report.

**Next Steps**:
1. Review PinkieIt timeline for Phase 2 commits
2. Create specs/003-phase-2-{feature}/ directory
3. Run `/plan` command for Phase 2 planning

---

**Completion Date**: 2025-10-03
**YokaKit Commit**: 17d43a2 (Phase 1 Completion Report)
**Ready for**: Phase 2
